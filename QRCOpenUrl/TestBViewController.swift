//
//  TestBViewController.swift
//  QRCOpenUrl
//
//  Created by super on 2017/8/16.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class TestBViewController: QRCViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "TestB"
    
    let backBarButton = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(self.back))
    navigationItem.leftBarButtonItem = backBarButton
    // Do any additional setup after loading the view.
  }

  func back() {
    dismiss(animated: true, completion: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}
