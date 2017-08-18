//
//  ViewController.swift
//  QRCOpenUrl
//
//  Created by super on 2017/8/15.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  @IBAction func push(_ sender: Any) {
    QRCOpenUrlManager.sharedInstance.open("scheme1://testA", baseViewController: self)
  }
  
  @IBAction func present(_ sender: Any) {
    QRCOpenUrlManager.sharedInstance.open("scheme1://testB", baseViewController: self)
  }
  
  @IBAction func systemCall(_ sender: Any) {
    QRCOpenUrlManager.sharedInstance.open("http://www.baidu.com", baseViewController: self)
  }
  
  @IBAction func invalidCall(_ sender: Any) {
    QRCOpenUrlManager.sharedInstance.open("scheme1://error", baseViewController: self)
  }
  
}

