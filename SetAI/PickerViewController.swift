//
//  PickerViewController.swift
//  SetAI
//
//  Created by Sahil Ambardekar on 3/19/16.
//  Copyright © 2016 Kyle Haptonstall. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {

    @IBOutlet weak var colorPicker: UISegmentedControl!
    @IBOutlet weak var fillPicker: UISegmentedControl!
    @IBOutlet weak var numberPicker: UISegmentedControl!
    var delegate: PickerControllerDelegate?
    
    @IBAction func done(sender: AnyObject) {
        
        let color = Color(rawValue: colorPicker.titleForSegmentAtIndex(colorPicker.selectedSegmentIndex)!)
        
        let fill = Fill(rawValue: fillPicker.titleForSegmentAtIndex(fillPicker.selectedSegmentIndex)!)
        
        let numberStr = numberPicker.titleForSegmentAtIndex(numberPicker.selectedSegmentIndex)!
        
        var number = 1
        
        switch numberStr {
            
        case "One":
            number = 1
        case "Two":
            number = 2
        case "Three":
            number = 3
        default:
            break
        }
        
        delegate?.finishedPickingCard(Card(color: color!, fill: fill!, count: number))
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

protocol PickerControllerDelegate {
    
    func finishedPickingCard(card: Card)
}

struct Card {
    
    var color: Color
    var fill: Fill
    var count: Int
    
    init(color: Color, fill: Fill, count: Int) {
        
        self.color = color
        self.fill = fill
        self.count = count
    }
}

enum Color: String {
    
    case Red = "Red", Green = "Green", Purple = "Purple"
}

enum Fill: String {
    
    case Striped = "Striped", Filled = "Filled", Bordered = "Bordered"
}

