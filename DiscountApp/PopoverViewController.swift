//
//  PopoverViewController.swift
//  DiscountApp
//
//  Created by andriibilan on 11/5/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit
class PopoverViewController: UIViewController{
 
    var delegate : SortedDelegate?
    
    @IBAction func sortFromAtoZ(_ sender: Any) {
        delegate?.sortedCellFromPopover(.sortFromAtoZ)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sortFromZtoA(_ sender: Any) {
        delegate?.sortedCellFromPopover(.sortFromZtoA)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dateUp(_ sender: Any) {
        delegate?.sortedCellFromPopover(.dateUp)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dateDown(_ sender: Any) {
        delegate?.sortedCellFromPopover(.dateDown)
        dismiss(animated: true, completion: nil)
    }


}


protocol SortedDelegate {
    func sortedCellFromPopover(_ sort: sortedTap)
}
enum sortedTap {
    case sortFromAtoZ
    case sortFromZtoA
    case dateUp// = "Date ⬆︎"
    case dateDown //= "Date ⬇︎"
}
