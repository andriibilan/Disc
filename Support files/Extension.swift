//
//  Extension.swift
//  DiscountApp
//
//  Created by andriibilan on 11/13/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

extension UIView
{
    func setCorner(radius: CGFloat){
        
        self.layer.cornerRadius = radius
        layer.borderWidth = 2
        layer.borderColor = UIColor.yellow.cgColor
        layer.masksToBounds = true
    }
    func setBackgroundImage() {
        let backgroindImage = UIImageView(frame: UIScreen.main.bounds)
        backgroindImage.image = #imageLiteral(resourceName: "black_light_dark_figures_73356_1080x1920")
       insertSubview(backgroindImage, at: 0)
        
        
    }
}
extension UISearchBar
{
    func setPlaceholderTextColorTo(color: UIColor)
    {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = color
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = color
    }
}


extension UINavigationItem
{
    func configureTitleView()
    {
        let navBar = UINavigationBar.appearance()
        let image = #imageLiteral(resourceName: "rsz_1467be293e99ed9ef56014a02f4be2308-discount-red-rounded-by-vexels")
        let imageView = UIImageView(image: image)
        let bannerW = navBar.frame.size.width
        let bannerH = navBar.frame.size.height
        let bannerX = bannerW / 2 - image.size.width / 2
        let bannerY = bannerH / 2 - image.size.height / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerW , height: bannerH)
        //imageView.contentMode = .scaleAspectFit
        titleView = imageView
    }
}


extension UIColor
{
    static var cBlack = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
}








