//
//  QRCOpenUrlManager.swift
//  QRCOpenUrl
//
//  Created by super on 2017/8/15.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

typealias QRCOpenUrlCallbackBlock = (_ viewController: UIViewController?, _ result: NSDictionary) -> Void

class QRCOpenUrlManager: NSObject {
  
  static let sharedInstance = QRCOpenUrlManager()
  var openUrlDicts = [String: QRCOpenUrlData]()
  var openUrlSchemes = [String]()
  var bundleName: String {
    return Bundle.main.infoDictionary!["CFBundleName"] as! String
  }
  
  override init() {
    super.init()
    
    let path = Bundle.main.path(forResource: "QRCOpenUrl", ofType: "plist")
    assert(path != nil, "scheme 文件为空")
    
    let dict = NSDictionary(contentsOfFile: path!)
    parseSchmes(with: dict!)
  }
  
  func parseSchmes(with dict: NSDictionary) {
    dict.enumerateKeysAndObjects({ (key, value, stop) in
      if let childDict = value as? NSDictionary, let keyValue = key as? String {
        openUrlSchemes.append(keyValue)
        self.parseDictionary(with: childDict)
      }
    })
  }
  
  func parseDictionary(with dict: NSDictionary) {
    dict.enumerateKeysAndObjects({ (key, value, stop) in
      if let childDict = value as? NSDictionary, let keyValue = key as? String, childDict.qrcHasKey("responseClass") && childDict.qrcHasKey("spring") {
        let openUrlData = QRCOpenUrlData(key: key as! String, data: childDict)
        openUrlDicts[keyValue] = openUrlData
      }
    })
  }
  
  func parseOpenUrlData(with url: URL) -> QRCOpenUrlData? {
    if openUrlDicts.isEmpty {
      return nil;
    }
    
    guard let scheme = url.scheme?.lowercased(), let host = url.host?.lowercased() else {
      return nil
    }
    
    if !openUrlSchemes.contains(url.scheme!) {
      return nil
    }
    
    var openUrlData: QRCOpenUrlData? = nil
    var pathKeys = [String]()
    pathKeys.append(scheme)
    pathKeys.append(host)
    
    for compnent in url.pathComponents {
      if compnent != "/" {
        pathKeys.append(compnent.lowercased())
      }
    }
    
    openUrlData = openUrlDicts[pathKeys.last!]
    
    if openUrlData == nil {
      NSLog("没有responseClass")
      // 如果本地没有配置，返回的responseClass为nil，可以使用一个默认的class来响应
      openUrlData = QRCOpenUrlData(key: url.host!, responseClass: nil, springType: .present)
    }
    
    return openUrlData
  }
  
  func topViewController() -> UIViewController? {
    return UIApplication.shared.keyWindow?.rootViewController
  }
  
  func trimString(_ string: String) ->String {
    return string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
  }
  
  @discardableResult
  func open(_ urlString: String, baseViewController: UIViewController?, springType: QRCOpenUrlSpringType? = nil, param: [String: Any]? = nil, callBackBlock: QRCOpenUrlCallbackBlock? = nil) -> QRCOpenUrlType {
    let trimUrlString = trimString(urlString)
    var url = URL(string: trimUrlString)
    var urlStatusType = QRCOpenUrlType.invalid
    if url == nil {
      if let validString = trimUrlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
        url = URL(string: validString)
      }
    }
    
    guard let validUrl = url else {
      return urlStatusType;
    }
    
    var viewController = baseViewController
    if viewController == nil {
      viewController = topViewController()
    }
    
    // 内部能处理就内部处理，不能处理就抛给系统
    if let openUrlData = parseOpenUrlData(with: validUrl) {
      urlStatusType = .appValid
      var newOpenUrlData = openUrlData
      if let spring = springType {
        newOpenUrlData.springType = spring
      }
      newOpenUrlData.bodyParam = param
      newOpenUrlData.scheme = validUrl.absoluteString
      if let responseClassString = openUrlData.responseClass, let className = NSClassFromString(bundleName + "." + responseClassString) {
        responseViewController(with: newOpenUrlData, className: className, baseViewController: viewController!, callBackBlock: callBackBlock)
      }
    } else {
      if UIApplication.shared.canOpenURL(validUrl) {
        UIApplication.shared.open(validUrl, options: [:], completionHandler: nil)
        urlStatusType = .systemValid
      }
    }
    
    return urlStatusType
  }
  
  func responseViewController(with openUrlData: QRCOpenUrlData, className: AnyClass, baseViewController: UIViewController, callBackBlock: QRCOpenUrlCallbackBlock?) {
    if baseViewController.responds(to: #selector(QRCViewController.inViewAnimating)), let object = baseViewController.perform(#selector(QRCViewController.inViewAnimating)).takeUnretainedValue() as? NSNumber, !object.boolValue {
      NSLog("baseViewController is in Animating")
      return
    } else if let nav = baseViewController as? UINavigationController, let topViewController = nav.viewControllers.last {
      if topViewController.responds(to: #selector(QRCViewController.inViewAnimating)), let object = topViewController.perform(#selector(QRCViewController.inViewAnimating)).takeUnretainedValue() as? NSNumber, !object.boolValue {
        NSLog("baseViewController is in Animating")
        return
      }
    }
    
    var topViewController: UIViewController?
    if let controllerType = className as? QRCViewController.Type {
      let newController = controllerType.init()
      newController.generate(with: openUrlData)
      topViewController = newController
      if openUrlData.springType == .present && !newController.isKind(of: UINavigationController.self) {
        let nav = UINavigationController(rootViewController: newController)
        topViewController = nav
      }
      
      var animation = true
      if let animationValue = openUrlData.schemeParam?[QRCOpenUrlViewControllerAnimationKey] as? NSInteger {
        animation = (animationValue == 1)
      }
      
      openViewController(baseViewController, newViewController: topViewController!, isAnimation: animation, springType: openUrlData.springType)
    }
  }
  
  func openViewController(_ baseViewController: UIViewController, newViewController: UIViewController, isAnimation: Bool, springType: QRCOpenUrlSpringType) {
    if springType == .push {
      baseViewController.navigationController?.pushViewController(newViewController, animated: isAnimation)
    } else {
      var topViewController = baseViewController
      while topViewController.presentedViewController != nil {
        topViewController = topViewController.presentedViewController!
      }
      
      topViewController.present(newViewController, animated: isAnimation, completion: nil)
    }
  }
}
