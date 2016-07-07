//
//  ViewController.swift
//  HabitKit
//
//  Created by Alex Zimin on 07/07/16.
//  Copyright © 2016 Alexander Zimin. All rights reserved.
//

import UIKit
import HabitKitFramework

class ViewController: UIViewController {

  @IBOutlet weak var segmentedControl: UISegmentedControl!
  var selectionHabit = ActionHabitRule(name: "SelectionHabit", defaultValue: 0)
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    selectionHabit.numberOfExecutions = 2
    
    segmentedControl.selectedSegmentIndex = selectionHabit.actionIndex
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func segmentedControlValueChanged(sender: UISegmentedControl) {
    selectionHabit.executeActionIndex(sender.selectedSegmentIndex)
  }

}

