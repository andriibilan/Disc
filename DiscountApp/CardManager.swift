//
//  CardManager.swift
//  DiscountApp
//
//  Created by andriibilan on 10/31/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit
import CoreData
class CardManager: NSObject {
    
    
    
    func createCard( name: String? , descript: String? , date: Date? ,frontImage: String? , backImage: String? , barCode: String?){
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Card", in: context)
        let newCard = NSManagedObject(entity: entity!, insertInto: context)
            newCard.setValue(name, forKey: "cardName")
            newCard.setValue(descript, forKey: "cardDescription")
            newCard.setValue(date, forKey: "cardDate")
            newCard.setValue(frontImage, forKey: "cardFrontImage")
            newCard.setValue(backImage, forKey: "cardBackImage")
            newCard.setValue(barCode, forKey: "cardBarCode")
        
        saveData()
    }
    
    
    func editCard(card: Card, name: String? , descript: String? , date: Date?, frontImage: String? , backImage: String?, barCode: String?){
        card.cardName = name
        card.cardDescription = descript
        card.cardDate = date
        card.cardFrontImage = frontImage
        card.cardBackImage = backImage
        card.cardBarCode = barCode
        
         saveData()
    }
    
    func addToUrl (_ photo: UIImage )  -> String {
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let uuidStringforURL = UUID().uuidString + ".jpg"
        let imgPath = URL(fileURLWithPath: documentDirectoryPath.appendingPathComponent(uuidStringforURL))// Change extension if you want to save as PNG
        let imageString = String(describing: imgPath)
        print(imageString)
        do{
            try UIImageJPEGRepresentation(photo, 1.0)?.write(to: imgPath, options: .atomic)
        }catch let error{
            print(error.localizedDescription)
        }
        return uuidStringforURL
        
    }
    func loadImageFromPath(path: String) -> UIImage? {
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let imageURL = URL(fileURLWithPath: documentDirectoryPath.appendingPathComponent(path))
        do {
            let imageData = try Data(contentsOf: imageURL)
            return UIImage(data: imageData)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    func getContext() ->NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
//    func storeObj(){
//        let context = getContext()
//        let entity = NSEntityDescription.entity(forEntityName: "Card", in: context)
//
//        let  manageObj = NSManagedObject(entity: entity!, insertInto: context)
//
//
//    }
    
    func saveData(){
        do {
            try getContext().save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchData(filter: String?) -> [Card]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName :"Card")
        if filter != nil && filter != "" {
            fetchRequest.predicate = NSPredicate(format: "filter == %@", filter!)
            var cardArray:[Card] = []
            
            do{
                cardArray = (try getContext().fetch(Card.fetchRequest()) as? [Card])!
            } catch {
                print("Error fetch")
            }
            return cardArray
        } else {
            do {
                var cardArray: [Card] = []
                cardArray = try getContext().fetch(Card.fetchRequest()) as! [Card]
                return cardArray
            } catch {
                let cardArray: [Card] = []
                return cardArray
            }
            
        }
        
        
    }
 
    
   
    
    
}







