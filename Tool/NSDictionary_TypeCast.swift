//
//  NSDictionary_TypeCast.swift
//  QRCOpenUrl
//
//  Created by super on 2017/8/16.
//  Copyright © 2017年 super. All rights reserved.
//

import Foundation
import UIKit

extension NSDictionary {
  
  func qrcHasKey(_ key: String) -> Bool {
    if object(forKey: key) != nil {
      return true
    }
    
    return false
  }
  
  func qrcString(_ key: String) -> String? {
    return object(forKey: key) as? String
  }
  
  func qrcStringValue(_ key: String) -> String? {
    return object(forKey: key) as? String ?? ""
  }
  
  func qrcInteger(_ key: String) -> NSInteger? {
    return (object(forKey: key) as? NSNumber)?.intValue
  }
  
  func qrcIntegerValue(_ key: String) -> NSInteger {
    return (object(forKey: key) as? NSNumber)?.intValue ?? 0
  }
  
  func qrcFloat(_ key: String) -> Float? {
    return (object(forKey: key) as? NSNumber)?.floatValue
  }
  
  func qrcFloatValue(_ key: String) -> Float {
    return (object(forKey: key) as? NSNumber)?.floatValue ?? 0
  }
  
  func qrcDouble(_ key: String) -> Double? {
    return (object(forKey: key) as? NSNumber)?.doubleValue
  }
  
  func qrcDoubleValue(_ key: String) -> Double {
    return (object(forKey: key) as? NSNumber)?.doubleValue ?? 0
  }
  
  func qrcBool(_ key: String) -> Bool? {
    return (object(forKey: key) as? NSNumber)?.boolValue
  }
  
  func qrcBoolValue(_ key: String) -> Bool {
    return (object(forKey: key) as? NSNumber)?.boolValue ?? false
  }
  
  func qrcObject(_ key: String) -> Any? {
    return object(forKey: key)
  }
  
  func qrcRect(_ key: String) -> CGRect? {
    if let value = qrcString(key) {
      return CGRectFromString(value)
    }
    
    return nil
  }
  
  func qrcRectValue(_ key: String) -> CGRect? {
    if let value = qrcString(key) {
      return CGRectFromString(value)
    }
    
    return CGRect.zero
  }
  
  func qrcPoint(_ key: String) -> CGPoint? {
    if let value = qrcString(key) {
      return CGPointFromString(value)
    }
    
    return nil
  }
  
  func qrcRectValue(_ key: String) -> CGPoint? {
    if let value = qrcString(key) {
      return CGPointFromString(value)
    }
    
    return CGPoint.zero
  }
  
  func qrcRect(_ key: String) -> CGSize? {
    if let value = qrcString(key) {
      return CGSizeFromString(value)
    }
    
    return nil
  }
  
  func qrcRectValue(_ key: String) -> CGSize? {
    if let value = qrcString(key) {
      return CGSizeFromString(value)
    }
    
    return CGSize.zero
  }
}
