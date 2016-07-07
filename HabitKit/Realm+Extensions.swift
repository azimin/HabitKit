//
//  RealmExtension.swift
//  Hitch
//
//  Created by Alexander Zimin on 14/11/15.
//  Copyright © 2015 Triagne glow. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

internal var realmDataBase: Realm {
  return HabitKit.sharedInstance.realmDataBase
}

internal func writeFunction(block: (() -> Void)) {
  if realmDataBase.inWriteTransaction {
    block()
  } else {
    do {
      try realmDataBase.write(block)
    } catch { }
  }
}

internal extension Realm {
  func writeFunction(block: (() -> Void)) {
    if realmDataBase.inWriteTransaction {
      block()
    } else {
      do {
        try write(block)
      } catch { }
    }
  }
}

internal extension List where T: RealmInt {
  func toIntArray() -> [Int] {
    return self.map({ (value) -> Int in
      value.toInt()
    })
  }
}

internal protocol ObjectSingletone: class {
  init()
}

internal extension ObjectSingletone where Self: Object {
  static var value: Self {
    let object = realmDataBase.objects(Self).first
    if let value = object {
      return value
    } else {
      let value = Self()
      
      if realmDataBase.inWriteTransaction {
        realmDataBase.add(value) 
      } else {
        realmDataBase.writeFunction({ () -> Void in
          realmDataBase.add(value)
        })
      }
      
      return value
    }
  }
}


internal extension Object {
  func firstSave() -> Self {
    realmDataBase.writeFunction { () -> Void in
      realmDataBase.add(self)
    }
    return self
  }
}

internal class RLMArraySwift<T: RLMObject> : RLMArray {
  class func itemType() -> String {
    return "\(T.self)"
  }
}

internal extension Results {
  func toArray() -> [T] {
    return self.map{$0}
  }
}

internal extension RealmSwift.List {
  func toArray() -> [T] {
    return self.map{$0}
  }
}

internal class RealmInt: Object, IntegerLiteralConvertible {
  dynamic var value: Int = 0
  
  func toInt() -> Int {
    return value
  }
  
  convenience required init(integerLiteral value: Int) {
    self.init()
    self.value = value
  }
}

internal extension Int {
  func toRealmInt() -> RealmInt {
    let realmInt = RealmInt(integerLiteral: self)
    return realmInt.firstSave()
  }
}