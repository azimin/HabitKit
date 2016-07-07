//
//  ActionHabitRule.swift
//  HabitKit
//
//  Created by Alex Zimin on 07/07/16.
//  Copyright © 2016 Alexander Zimin. All rights reserved.
//

import Foundation
import CoreGraphics

public class ActionHabitRule: HabitRule {
  
  public static var cacheSizeGlobal = 50
  
  // Number of times must one value execute before selection
  public var numberOfExecutions = 1
  public var cacheSize = ActionHabitRule.cacheSizeGlobal
  
  // Recomended value
  public var actionIndex: Int {
    let values = ActionHabitRuleEntity.createOrFindEntity(name).values
    
    if values.count < numberOfExecutions {
      return defaultValue
    }
    
    let intValues = values.map() { $0.toInt() }
    let bestActions = intValues.groupCount({ $0 })
    let sortedBestActions = bestActions.keysSortedByValue(>)
    
    if sortedBestActions.count == 0 {
      return defaultValue
    } else if sortedBestActions.count == 1 {
      return sortedBestActions[0]
    }
    
    let best = sortedBestActions[0]
    let bestCount = bestActions[best]!
    let prebest = sortedBestActions[1]
    let prebestCount = bestActions[prebest]!
    
    if bestCount == prebestCount {
      for element in intValues.reverse() {
        if element == best {
          return best
        }
        
        if element == prebest {
          return prebest
        }
      }
    }
    
    return best
  }
  
  private var defaultValue: Int = 0
  
  public init(name: String, defaultValue: Int) {
    self.defaultValue = defaultValue
    super.init(name: name)
  }
  
  public init(name: String, defaultValue: Bool) {
    self.defaultValue = defaultValue ? 1 : 0
    super.init(name: name)
  }
  
  public func executeActionIndex(actionIndex: Int) {
    let value = ActionHabitRuleEntity.execute(name, value: actionIndex)
    value.cacheSizeCheck(cacheSize)
  }
  
  public func executeAction(action: Bool) {
    executeActionIndex(action ? 1 : 0)
  }
}

