//
//  QRCStringExtension.swift
//  QRCOpenUrl
//
//  Created by super on 2017/8/18.
//  Copyright © 2017年 super. All rights reserved.
//

import Foundation

extension String {
  
  func isAllSpaceString() -> Bool {
    let string: NSString = self as NSString
    if string.length <= 0 {
      return true
    }
    
    var isAllSpaceString = true
    for i in 0..<characters.count {
      let range = NSRange(location: i, length: 1)
      if string.substring(with: range).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count <= 0 {
        isAllSpaceString = true
      } else {
        isAllSpaceString = false
        break
      }
    }
    
    return isAllSpaceString
  }
  
  func urlToDictionary() -> [String: Any] {
    var result = [String: Any]()
    if let params = URL(string: self)?.query {
      let array = params.components(separatedBy: "&")
      for item in array {
        let keyValues = item.components(separatedBy: "=")
        if keyValues.count >= 2 {
          result[keyValues[0]] = keyValues[1]
        }
      }
    }
    
    return result
  }
  
}
