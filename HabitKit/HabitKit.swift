//
//  HabitKit.swift
//  HabitKit
//
//  Created by Alex Zimin on 07/07/16.
//  Copyright © 2016 Alexander Zimin. All rights reserved.
//

import Foundation
import RealmSwift

public class HabitKit {
  static let sharedInstance: HabitKit = {
    let value = HabitKit()
    value.realmDataBase = try! Realm()
    return value
  }()
  
  internal private(set) var realmDataBase: Realm!
}