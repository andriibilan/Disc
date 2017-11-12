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
    var arrayCard:Card?
    var imagePage: String = ""
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showView(imagePage)
        
    }
    
    
    
    
    func showView(_ imageStr: String) {
        let imageForPaging = UIImageView(image: card.loadImageFromPath(path: imageStr))
        imageForPaging.transform = imageForPaging.transform.rotated(by: CGFloat(-Double.pi / 2))
        let newWidth = UIScreen.main.bounds.width - 20
        let newHeight = newWidth / 0.68
        imageForPaging.frame = CGRect(x: 10, y: 80, width: newWidth, height: newHeight)
        view.addSubview(imageForPaging)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "showEditforPage" {
            let editViewController = segue.destination as! EditPropertiesViewController
            editViewController.cardEdit = arrayCard
        }
    }
}

