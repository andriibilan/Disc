//
//  MainViewController.swift
//  DiscountApp
//
//  Created by andriibilan on 10/30/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//
//import Foundation
import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchBarDelegate, UIPopoverPresentationControllerDelegate, SortedDelegate {
    var filter = ""
    var card = CardManager()
    var  cardArray: [Card] = []
    @IBOutlet weak var prototypeTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    

    @IBAction func filterFromSegment(_ sender: UISegmentedControl) {
     let  indexSegment = sender.selectedSegmentIndex
        switch indexSegment {
        case 0:
            cardArray = card.fetchData(filter: "")
            prototypeTableView.reloadData()
        case 1:
            cardArray = card.fetchData(filter: "Shop")
            prototypeTableView.reloadData()
        case 2:
            cardArray = card.fetchData(filter: "Food")
            prototypeTableView.reloadData()
              
        case 3:
            cardArray = card.fetchData(filter: "Cafe")
            prototypeTableView.reloadData()
        case 4:
            cardArray = card.fetchData(filter: "Pharmacy")
            prototypeTableView.reloadData()
        default:
            cardArray = card.fetchData(filter: "Other")
            prototypeTableView.reloadData()
        }
    
    }
    
    
    func filterForTableView(text: String){
        cardArray = cardArray.filter( { (mod)-> Bool in
            return (mod.cardName.lowercased().contains(text.lowercased()))
        })
        prototypeTableView.reloadData()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchName: String) {
        if searchName.isEmpty{
            cardArray = card.fetchData(filter: filter )
            prototypeTableView.reloadData()
        } else {
            filterForTableView(text: searchName)
            prototypeTableView.reloadData()
            
        }
    }
  
    func sortedCellFromPopover(_ sort: sortedTap) {
        switch sort {
        case .sortFromAtoZ :
            cardArray.sort() {  $0.cardName.lowercased() < $1.cardName.lowercased() }
            prototypeTableView.reloadData()
        case .sortFromZtoA:
            cardArray.sort() {  $0.cardName.lowercased() > $1.cardName.lowercased() }
            prototypeTableView.reloadData()
        case .dateUp:
            cardArray.sort() { $0.cardDate < $1.cardDate }
            prototypeTableView.reloadData()
        case .dateDown:
            cardArray.sort() { $0.cardDate > $1.cardDate}
            prototypeTableView.reloadData()
            
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardArray.count
    } 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! TableViewCell
        let cardCell = cardArray[indexPath.row]
    //  print(cardArray)
        cell.name.text = cardCell.cardName
        cell.cardDescription?.text = cardCell.cardDescription
        cell.date?.text = card.dateConvert(cardCell.cardDate)
 
        cell.imagePrototype.image = card.loadImageFromPath(path: cardCell.cardFrontImage)
      
       cell.selectionStyle = UITableViewCellSelectionStyle.none
       cell.backgroundColor = UIColor.clear
//        imageCache.obtainImageWithPath(imagePath: cardCell.cardFrontImage! ){ (image) in
//            // Before assigning the image, check whether the current cell is visible
//            if let updateCell = tableView.cellForRow(at: indexPath) {
//                updateCell.imageView?.image = image
//            }
//        }
        
        
        
        
//                if let cacheImage = imageCashe.object(forKey: card.cardName as AnyObject){
//                    cell.imagePrototype.image = cacheImage as? UIImage
//                } else {
//                     cell.imageURl = URL(string: card.cardFrontImage!)
//                    self.imageCashe.setObject(URL(string: card.cardFrontImage!) as AnyObject, forKey: card.cardName as AnyObject)
//                }
        
         // cell.imageURl = URL(string: cardCell.cardFrontImage!)
         // print("card name : \(String(describing: card.cardName))")
         // print("card descr : \(String(describing: card.cardDescription))")
        // print("card foto : \(String(describing: URL(string: card.cardFrontImage!)))")
       
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.performSegue(withIdentifier: "show Paging", sender: self.cardArray[indexPath.row])

    }
   
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "") { action, sourceView, completionHandler  in
 
            let cardID = self.cardArray[indexPath.row]
            self.card.getContext().delete(cardID)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do{
                self.cardArray = try self.card.getContext().fetch(Card.fetchRequest()) as! [Card]
            } catch{
                print(error)
            }
            self.prototypeTableView.reloadData()
            completionHandler(true)
        }
        let share = UIContextualAction(style: .normal, title: "") { action, sourceView, completionHandler  in
          
            self.shareData(index: indexPath)
            
            completionHandler(true)
        }
        
        let edit = UIContextualAction(style: .normal, title: "") { action, sourceView, completionHandler  in

            self.performSegue(withIdentifier: "Show Edit", sender: self.cardArray[indexPath.row])
            
            completionHandler(true)
        }
        edit.backgroundColor = .cRed
        delete.backgroundColor = .cRed
        share.backgroundColor = .cRed
        delete.image = #imageLiteral(resourceName: "rsz_qslecfcggxicbdlbcpfi")
        share.image = #imageLiteral(resourceName: "rsz_1rsz_share")
        edit.image = #imageLiteral(resourceName: "rsz_dovyxaclbbfixgvidylk")
        
        let config = UISwipeActionsConfiguration(actions: [edit,share,delete])
        config.performsFirstActionWithFullSwipe = false
 
        return config

    }

    func shareData(index: IndexPath) {
     
        let  shareArray = cardArray[index.row]
        let share = [card.loadImageFromPath(path: shareArray.cardFrontImage) , card.loadImageFromPath(path: shareArray.cardBackImage) , card.loadImageFromPath(path: shareArray.cardBarCode)]
        let activityVC = UIActivityViewController(activityItems: [shareArray.cardName,card.loadImageFromPath(path: shareArray.cardFrontImage) , card.loadImageFromPath(path: shareArray.cardBackImage) , card.loadImageFromPath(path: shareArray.cardBarCode) ], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
       cardArray = card.fetchData(filter: filter)
        prototypeTableView.reloadData()
        prototypeTableView.delegate = self
        prototypeTableView.dataSource = self
        searchBar.delegate = self
        
        
        self.prototypeTableView.backgroundColor = UIColor.clear
     //  let tableImage = UIImageView(image: #imageLiteral(resourceName: "black_light_dark_figures_73356_1080x1920"))
      //  self.prototypeTableView.backgroundView = tableImage
        

        self.searchBar.setPlaceholderTextColorTo(color: UIColor.red)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.red

       
        let backgroindImage = UIImageView(frame: UIScreen.main.bounds)
        backgroindImage.image = #imageLiteral(resourceName: "black_light_dark_figures_73356_1080x1920")
        self.view.insertSubview(backgroindImage, at: 0)
        let segmentControl = UISegmentedControl.self
        //let titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        segmentControl.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .selected)
        
        
        
        self.navigationItem.configureDefaultNavigationBarAppearance()
//        let memoryCapacity = 5 * 1024 * 1024
//        let diskCapacity = 5 * 1024 * 1024
//        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "MyDiskCache")
//        URLCache.shared = urlCache
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Show Edit":
                let   goToEdit = segue.destination as? EditPropertiesViewController
                goToEdit?.cardEdit = sender as? Card
            case "showPopover" :
                let popoverViewController = segue.destination as! PopoverViewController
                popoverViewController.delegate = self
                popoverViewController.popoverPresentationController?.delegate = self
            case "show Paging" :
                //let navigationController = segue.destination as? UINavigationController
                let pagingViewController = segue.destination as! PageViewController
                pagingViewController.cardPage =  sender as? Card
                
                
                //                let pagingViewController = segue.destination as! PageViewController
            //                pagingViewController.cardPage =  sender as? Card
                
                
//            case "showShare":
//                let shareViewController = segue.destination as! ShareViewController
//                shareViewController.shareCard = sender as? Card
            default :  break
                
                
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

 
    
}



