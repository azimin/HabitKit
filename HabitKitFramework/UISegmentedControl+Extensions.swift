//
//  UISegmentedControl+Extensions.swift
//  HabitKit
//
//  Created by Alex Zimin on 07/07/16.
//  Copyright © 2016 Alexander Zimin. All rights reserved.
//

import UIKit
import ObjectiveC.runtime

private var associatedObjectHandle: UInt8 = 0
private var associatedObjectHandle2: UInt8 = 0

public extension UISegmentedControl {
  public func hk_addHabitWithName(name: String, defaultValue: Int = 0) {
    hk_habit = ActionHabitRule(name: name, defaultValue: defaultValue)
    selectedSegmentIndex = hk_habit.actionIndex
    
    let segmented_observer = UISegmentedControlObserver.attachTo(self)
    self.addObserver(segmented_observer, forKeyPath: "selectedSegmentIndex", options: NSKeyValueObservingOptions.New, context: nil)
    
//    HKDeallocHook.attachTo(self) { 
//      print("Bye bye")
//      self.removeObserver(segmented_observer, forKeyPath: "selectedSegmentIndex")
//    }
  }
  
  var hk_habit: ActionHabitRule {
    get {
      return objc_getAssociatedObject(self, &associatedObjectHandle) as! ActionHabitRule
    }
    set {
      objc_setAssociatedObject(self, &associatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
}

//private class UISegmentedControlObserver: NSObject {
//  private override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//    print(object)
//  }
//}