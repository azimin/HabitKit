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
  private var defaultValue: Int = 0
  
  // Recomended value
  var actionIndex: Int {
    let values = ActionHabitRuleEntity.createOrFindEntity(name).values
    
    if values.count < numberOfExecutions {
      return defaultValue
    }
    
    let intValues = values.map() { $0.toInt() }
    let bestActions = intValues.groupCount({ $0 })
    let sortedBestActions = bestActions.keysSortedByValue(>)
    
    print(bestActions)
    
    if sortedBestActions.count == 0 {
      return defaultValue
    } else if sortedBestActions.count == 1 {
      return sortedBestActions[0]
    }
    
    let best = sortedBestActions[0]
    let bestValue = bestActions[best] ?? 0
    let sum = bestValue + (bestActions[defaultValue] ?? 0)
    
    if CGFloat(bestValue / sum) > executionValue {
      return best
    }
    
    return defaultValue
  }
  
  // Number of times must one value execute before selection
  var numberOfExecutions = 1
  
  // Dominant percent of this value from second one
  var executionValue: CGFloat = 0.5
  
  func executeActionIndex(actionIndex: Int) {
    ActionHabitRuleEntity.execute(name, value: actionIndex)
  }
  
  func executeAction(action: Bool) {
    ActionHabitRuleEntity.execute(name, value: action ? 1 : 0)
  }
  
  init(name: String, defaultValue: Int) {
    self.defaultValue = defaultValue
    super.init(name: name)
  }
  
  init(name: String, defaultValue: Bool) {
    self.defaultValue = defaultValue ? 1 : 0
    super.init(name: name)
  }
}

