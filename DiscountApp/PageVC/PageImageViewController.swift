//
//  PageImageViewController.swift
//  DiscountApp
//
//  Created by andriibilan on 11/7/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

class PageImageViewController: UIViewController,UIScrollViewDelegate {
    var card = CardManager()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var showPageImage: UIImageView!
    var imagePage: String = ""
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 4.0
        
        showPageImage.image = UIImage(cgImage: (card.loadImageFromPath(path: imagePage)?.cgImage!)!, scale: CGFloat(1.0), orientation: .left)
        showPageImage.setCorner(radius: 50)
        showPageImage.layer.borderColor = UIColor.red.cgColor
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.showPageImage
    }

}

