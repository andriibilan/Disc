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
            filter = ""
            cardArray = card.fetchData(filter: filter)
            prototypeTableView.reloadData()
        case 1:
             filter = "Shop"
            cardArray = card.fetchData(filter: filter)
            prototypeTableView.reloadData()
        case 2:
             filter = "Food"
            cardArray = card.fetchData(filter: filter)
            prototypeTableView.reloadData()
              
        case 3:
             filter = "Cafe"
            cardArray = card.fetchData(filter: filter)
            prototypeTableView.reloadData()
        case 4:
             filter = "Pharmacy"
            cardArray = card.fetchData(filter: filter)
            prototypeTableView.reloadData()
        default:
             filter = "Other"
            cardArray = card.fetchData(filter: filter)
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
        cell.name.text = cardCell.cardName
        cell.cardDescription?.text = cardCell.cardDescription
        cell.date?.text = card.dateConvert(cardCell.cardDate)
        cell.imagePrototype.image = card.loadImageFromPath(path: cardCell.cardFrontImage)
      
        
       cell.selectionStyle = UITableViewCellSelectionStyle.none
       cell.backgroundColor = UIColor.clear
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.performSegue(withIdentifier: "show Paging", sender: self.cardArray[indexPath.row])
    }
   
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "") { action, sourceView, completionHandler  in
            self.card.deleteCard(card: self.cardArray[indexPath.row])
            self.cardArray = self.card.fetchData(filter: self.filter)
            self.prototypeTableView.reloadData()
            completionHandler(true)
        }
        let share = UIContextualAction(style: .normal, title: "") { action, sourceView, completionHandler  in
            let  shareArray = self.cardArray[indexPath.row]
            let activityVC = UIActivityViewController(activityItems: [ shareArray.cardName ,
                                                                       self.card.loadImageFromPath(path: shareArray.cardFrontImage) ?? #imageLiteral(resourceName: "467be293e99ed9ef56014a02f4be2308-discount-red-rounded-by-vexels") ,
                                                                       self.card.loadImageFromPath(path: shareArray.cardBackImage) ?? #imageLiteral(resourceName: "467be293e99ed9ef56014a02f4be2308-discount-red-rounded-by-vexels") ,
                                                                       self.card.loadImageFromPath(path: shareArray.cardBarCode) ?? #imageLiteral(resourceName: "467be293e99ed9ef56014a02f4be2308-discount-red-rounded-by-vexels")], applicationActivities: nil)
                activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
            completionHandler(true)
        }
        let edit = UIContextualAction(style: .normal, title: "") { action, sourceView, completionHandler  in
            self.performSegue(withIdentifier: "Show Edit", sender: self.cardArray[indexPath.row])
            completionHandler(true)
        }
        edit.backgroundColor = .cBlack
        delete.backgroundColor = .cBlack
        share.backgroundColor = .cBlack
        delete.image = #imageLiteral(resourceName: "rsz_qslecfcggxicbdlbcpfi")
        share.image = #imageLiteral(resourceName: "rsz_1rsz_share")
        edit.image = #imageLiteral(resourceName: "rsz_dovyxaclbbfixgvidylk")
        let config = UISwipeActionsConfiguration(actions: [edit,share,delete])
        config.performsFirstActionWithFullSwipe = false
        return config

    }

    override func viewDidLoad() {
        super.viewDidLoad()
       cardArray = card.fetchData(filter: filter)
        prototypeTableView.reloadData()
        prototypeTableView.delegate = self
        prototypeTableView.dataSource = self
        searchBar.delegate = self
        self.prototypeTableView.backgroundColor = UIColor.clear
        
        self.searchBar.setPlaceholderTextColorTo(color: UIColor.white)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.red

        view.setBackgroundImage()
        let segmentControl = UISegmentedControl.self
        segmentControl.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .selected)

        self.navigationItem.configureTitleView()
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
                let pagingViewController = segue.destination as! PageViewController
                pagingViewController.cardPage =  sender as? Card
            default :
                break
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         self.searchBar.endEditing(true)
    }
}



