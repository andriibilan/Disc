//
//  TableViewCell.swift
//  DiscountApp
//
//  Created by andriibilan on 10/30/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//
import UIKit

class TableViewCell: UITableViewCell {

   @IBOutlet weak var imagePrototype: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cardDescription: UILabel?
    @IBOutlet weak var date: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imagePrototype.setCorner(radius: 10)
//        imagePrototype.layer.cornerRadius = imagePrototype.frame.width/10.0
//        imagePrototype.layer.borderWidth = 2
        imagePrototype.layer.borderColor = UIColor.red.cgColor
        
    }
//    override func prepareForReuse() {
//        super.prepareForReuse()
//    }
}
