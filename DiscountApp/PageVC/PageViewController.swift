//
//  PageViewController.swift
//  DiscountApp
//
//  Created by andriibilan on 11/5/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
  
    var pageControl = UIPageControl()
    var cardPage: Card?
    var card = CardManager()
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController(viewController:"frontImage"),
                self.newViewController(viewController: "backImage"),
                self.newViewController(viewController: "barCode")]
      
    }()

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        return orderedViewControllers[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllersIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllersIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
    
    func newViewController(viewController: String) -> UIViewController{

//        if viewController == "frontImage"{
//
//            if let frontImageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController) as? PageImageViewController {
//                frontImageVC.pageVC = self
//            //   frontImageVC.frontImage?.image = card.loadImageFromPath(path: (cardPage?.cardFrontImage)!)
//                return frontImageVC
//            }
//        } else if viewController == "backImage" {
//            if let backImageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController) as? PageImageViewController{
//                backImageVC.pageVC = self
//                return backImageVC
//            }
//        }else if viewController == "barCode" {
//            if let barCodeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController) as? PageImageViewController {
//                barCodeVC.pageVC = self
//                return barCodeVC
//
//            }
//        }
//

        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:viewController)
   
    }

  
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 75,width: UIScreen.main.bounds.width,height:75))
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
       configurePageControl()

        // This sets up the first view that will show up on our page control
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)}

    }

   
        
        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
