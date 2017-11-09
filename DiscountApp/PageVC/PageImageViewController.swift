//
//  PageImageViewController.swift
//  DiscountApp
//
//  Created by andriibilan on 11/7/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

class PageImageViewController: UIViewController {
    var pageVC = PageViewController()
    var card = CardManager()
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var barCode: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //showFrontImage(image: frontImage)

   }
    func showFrontImage(image: UIImageView){
       let showPath = pageVC.cardPage
        switch image {
        case frontImage :
            image.image = card.loadImageFromPath(path: (showPath?.cardFrontImage)!)
        default:
            break
        }
       /// let transform1 = transform.translatedBy(x: self.size.width, y: 0)
//        frontImage?.transform = (frontImage?.transform.rotated(by: CGFloat( -Double.pi/2)))!
//        frontImage?.frame = CGRect(x: 50, y: 70, width: 275, height: 550)
       // frontImage?.image = card.loadImageFromPath(path: showPath!)
     
    }
//    func rotateImage(){
//    let customImageView = frontImage
//        customImageView?.frame = CGRect(x: 50, y: 50, width: 250, height: 400)
//        customImageView?.image = showFrontImage()
//
//        customImageView?.transform = customImageView.transform.rotated(by: CGFloat.init(M_PI_2))
//    var rotatedImage = UIImage()
//        rotatedImage = customImageView?.image
//    }
}
