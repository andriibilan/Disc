//
//  TableViewCell.swift
//  DiscountApp
//
//  Created by andriibilan on 10/30/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//
import UIKit

class TableViewCell: UITableViewCell {
    // var imageCashe = NSCache<AnyObject, AnyObject>()

   @IBOutlet weak var imagePrototype: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cardDescription: UILabel?
    @IBOutlet weak var date: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    var imageURl: URL? {
//        didSet {
//          //  imagePrototype?.image = nil
//           updateUI()
//        }
//
//    }
//
//    func updateUI(){
//        //if let casheImage = imageCashe.object(forKey: )
//        if let url = imageURl{
//            DispatchQueue.global(qos: .userInitiated).async {
//                let contentsOfURL = try? Data(contentsOf: url)
//                DispatchQueue.main.async {
//                    if url == self.imageURl{
//                        if let imageData = contentsOfURL {
//                            self.imagePrototype.image =  UIImage(data: imageData)
//                        }
//                    }
//                }
//            }
//        }
//
//
//    }
    
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//      setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
