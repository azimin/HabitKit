//
//  Collections+Extensions.swift
//  HabitKit
//
//  Created by Alex Zimin on 07/07/16.
//  Copyright © 2016 Alexander Zimin. All rights reserved.
//

import Foundation

extension SequenceType {
  func group<U : Hashable>(@noescape keyFunc: Generator.Element -> U) -> [U:[Generator.Element]] {
    var dict: [U : [Generator.Element]] = [:]
    for el in self {
      let key = keyFunc(el)
      if case nil = dict[key]?.append(el) { dict[key] = [el] }
    }
    return dict
  }
  
  func groupCount<U : Hashable>(@noescape keyFunc: Generator.Element -> U) -> [U : Int] {
    var dict: [U : Int] = [:]
    for el in self {
      let key = keyFunc(el)
      dict[key] = (dict[key] ?? 0) + 1
    }
    return dict
  }
}

extension Dictionary {
  func sortedKeys(isOrderedBefore:(Key,Key) -> Bool) -> [Key] {
    return Array(self.keys).sort(isOrderedBefore)
  }
  
  func sortedKeysByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
    return sortedKeys {
      isOrderedBefore(self[$0]!, self[$1]!)
    }
  }
  
  func keysSortedByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
    return Array(self)
      .sort() {
        let (_, lv) = $0
        let (_, rv) = $1
        return isOrderedBefore(lv, rv)
      }
      .map {
        let (k, _) = $0
        return k
    }
  }
}