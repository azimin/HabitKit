//
//  ActionHabitRuleEntity.swift
//  HabitKit
//
//  Created by Alex Zimin on 07/07/16.
//  Copyright © 2016 Alexander Zimin. All rights reserved.
//

import Foundation
import RealmSwift

class ActionHabitRuleEntity: Object {
  dynamic var name: String = ""
  var values = List<RealmInt>()
  
  static func execute(name: String, value: Int) -> ActionHabitRuleEntity {
    let object = createOrFindEntity(name)
    
    writeFunction { 
      object.values.append(RealmInt(integerLiteral: value))
    }
    
    return object
  }
  
  func cacheSizeCheck(size: Int) {
    if values.count > size {
      let value = values.removeFirst()
      writeFunction({ 
        realmDataBase.delete(value)
      })
    }
  }
  
  static func createOrFindEntity(name: String) -> ActionHabitRuleEntity {
    if let value = HabitKit.sharedInstance.realmDataBase.objects(ActionHabitRuleEntity).filter("name = '\(name)'").first {
      return value
    }
    let value = ActionHabitRuleEntity()
    value.name = name
    return value.firstSave()
  }
}