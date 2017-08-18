//
//  QRCOpenUrlData.swift
//  QRCOpenUrl
//
//  Created by super on 2017/8/15.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

typealias QRCOpenUrlParamDict = Dictionary<String, Any>

let QRCOpenUrlViewControllerAnimationKey = "animationKey"

enum QRCOpenUrlSpringType: Int {
  case push
  case present
}

enum QRCOpenUrlType: Int {
  case invalid
  case appValid
  case systemValid
}

struct QRCOpenUrlData {

  var key: String!
  var springType = QRCOpenUrlSpringType.push
  var responseClass: String?
  
  var scheme: String?
  var bodyParam: [String: Any]?       // body
  // scheme中携带的参数
  var schemeParam: [String: Any]? {
    return scheme?.urlToDictionary()
  }
  
  init(key: String, data: NSDictionary) {
    self.key = key
    responseClass = data.qrcStringValue("responseClass")
    springType = QRCOpenUrlSpringType(rawValue: data.qrcIntegerValue("spring")) ?? .push
  }
  
  init(key: String, responseClass: String?, springType: QRCOpenUrlSpringType) {
    self.key = key
    self.responseClass = responseClass
    self.springType = springType
  }
  
}
