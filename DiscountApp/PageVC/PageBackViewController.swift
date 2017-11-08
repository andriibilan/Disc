//
//  PageBackViewController.swift
//  DiscountApp
//
//  Created by andriibilan on 11/7/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

class PageBackViewController: UIViewController {
    var pageVC = PageViewController()
    var card = CardManager()
    
    @IBOutlet weak var backImage: UIImageView?
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showBackImage()
        // Do any additional setup after loading the view.
    }

    
    func showBackImage(){
        let showPath = pageVC.cardPage?.cardBackImage
        backImage?.transform = ( backImage?.transform.rotated(by: CGFloat( -Double.pi/2)))!
        backImage?.frame = CGRect(x: 50, y: 70, width: 275, height: 550)
        backImage?.image = card.loadImageFromPath(path: showPath!)
    }

}
