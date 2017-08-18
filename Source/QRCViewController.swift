//
//  QRCViewController.swift
//  QRCOpenUrl
//
//  Created by super on 2017/8/16.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

enum QRCViewControllerStatus {
  case inInitialized
  case inLoad
  case inDidload
  case inWillAppear
  case inDidAppear
  case inWillDisappear
  case inDidDisappear
}

class QRCViewController: UIViewController {
  
  var status = QRCViewControllerStatus.inInitialized
  var openUrlData: QRCOpenUrlData?
  var callbackBlock: QRCOpenUrlCallbackBlock?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.white
    status = .inDidload
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    status = .inWillAppear
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    status = .inDidAppear
  }
  
  func inViewAnimating() -> Bool {
    return status == .inWillAppear || status == .inWillDisappear
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    status = .inWillDisappear
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    status = .inDidDisappear
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
