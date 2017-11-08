//
//  BarCodeViewController.swift
//  DiscountApp
//
//  Created by andriibilan on 11/7/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

class BarCodeViewController: UIViewController {
    var pageVC = PageViewController()
    var card = CardManager()
    @IBOutlet weak var barCodeImage: UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       showBarCode()
        // Dispose of any resources that can be recreated.
    }
    

    func showBarCode(){
        barCodeImage?.transform = ( barCodeImage?.transform.rotated(by: CGFloat( -Double.pi/2)))!
        barCodeImage?.frame = CGRect(x: 50, y: 70, width: 275, height: 550)
        let showPath = pageVC.cardPage?.cardBackImage
       barCodeImage?.image = card.loadImageFromPath(path: showPath!)
    }
   
}
