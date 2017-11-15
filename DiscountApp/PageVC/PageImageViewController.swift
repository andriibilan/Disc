//
//  PageImageViewController.swift
//  DiscountApp
//
//  Created by andriibilan on 11/7/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

class PageImageViewController: UIViewController {
    var card = CardManager()
  //  var arrayCard:Card?
    @IBOutlet weak var showPageImage: UIImageView!
    var imagePage: String = ""
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
   
     showView(imagePage)
       
//        let backgroindImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroindImage.backgroundColor = UIColor.black
//        self.view.insertSubview(backgroindImage, at: 0)
    
    }
  
    func showView(_ imageStr: String) {
        let imageForPaging = UIImageView(image: card.loadImageFromPath(path: imageStr))
        imageForPaging.transform = imageForPaging.transform.rotated(by: CGFloat(-Double.pi / 2))
         imageForPaging.setCorner(radius: 50)
        imageForPaging.layer.borderColor = UIColor.red.cgColor
        let newWidth = UIScreen.main.bounds.width - 20
        let newHeight = newWidth / 0.68
        imageForPaging.frame = CGRect(x: 10, y: 20, width: newWidth, height: newHeight)

        view.addSubview(imageForPaging)

    }
   
}

