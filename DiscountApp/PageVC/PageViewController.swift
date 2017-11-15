//
//  PageViewController.swift
//  DiscountApp
//
//  Created by andriibilan on 11/5/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
  
    var pageControl = UIPageControl.appearance()
    var cardPage: Card?
    var card = CardManager()
    var pageIndex = 0
    var pageCount = 0
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print(pageIndex)
        var index = (viewController as! PageImageViewController).index
        index = index - 1
        
        return imageViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! PageImageViewController).index
        index = index + 1
        
        return imageViewController(at: index)
    }
    


    
    func imageViewController(at index: Int) -> PageImageViewController? {
        var maxCountOfPage = 3
        let  imageArray = [cardPage?.cardFrontImage, cardPage?.cardBackImage, cardPage?.cardBarCode]
        if cardPage?.cardBarCode != "" {
            pageCount = imageArray.count
        } else {
            pageCount = imageArray.count-1
            maxCountOfPage = 2
        }
        
        if index < 0 || index >= maxCountOfPage {
            return nil
        }
        if let imageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageImageViewController") as? PageImageViewController {
            imageViewController.imagePage = imageArray[index]!
            imageViewController.index = index
            return imageViewController
        }
        
        return nil
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let  imageViewController = pageViewController.viewControllers?.first as? PageImageViewController {
                print("Content view controller index: \(imageViewController.index)")
                pageIndex = imageViewController.index
               
            }
            
            
        }
        

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        if let firstViewController = imageViewController(at: 0) {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)}
       self.navigationItem.configureDefaultNavigationBarAppearance()
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        self.pageControl.pageIndicatorTintColor = UIColor.yellow
        self.pageControl.backgroundColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.red
        return pageCount
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {

        return 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "showEditforPage" {
            let editViewController = segue.destination as! EditPropertiesViewController
            editViewController.cardEdit = cardPage
        }
    }
    
}






