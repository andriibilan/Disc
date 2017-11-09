//
//  EditPropertiesViewController.swift
//  DiscountApp
//
//  Created by andriibilan on 10/30/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//
import CoreImage
import UIKit
import RSBarcodes_Swift
import AVFoundation
class EditPropertiesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var card = CardManager()
    var imageIs = ""
    var cardEdit:Card?
    @IBOutlet weak var cardName: UITextField!
    @IBOutlet weak var frontImage: UIImageView?
    @IBOutlet weak var backImage: UIImageView?
    @IBOutlet weak var barCodeImage: UIImageView?
    @IBOutlet weak var barCodeText: UITextField!
    @IBOutlet weak var cardDescription: UITextView!
    @IBOutlet weak var SegmentFilter: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.frontImage?.isUserInteractionEnabled = true
        self.backImage?.isUserInteractionEnabled = true
        
        if let cardChange = cardEdit {
            self.cardName.text = cardChange.cardName
            self.cardDescription.text = cardChange.cardDescription
            self.frontImage?.image = card.loadImageFromPath(path: cardChange.cardFrontImage!)
            self.backImage?.image = card.loadImageFromPath(path: cardChange.cardBackImage!)
            self.barCodeImage?.image = card.loadImageFromPath(path: cardChange.cardBarCode!)
            self.SegmentFilter.selectedSegmentIndex = card.showSegment(value: cardChange.cardFilter)
        }
    }
    
    @IBAction func generateBarCode(_ sender: Any) {
         if barCodeText.text != nil && barCodeText.text != "" {
        barCodeImage?.image = RSUnifiedCodeGenerator.shared.generateCode(barCodeText.text!, machineReadableCodeObjectType: AVMetadataObject.ObjectType.ean13.rawValue)
         }else{
                let alertController = UIAlertController(title: "Error", message: "You should to write 13 symbols for generate barcode", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
    
    @IBAction func createCard(_ sender: Any) {
        if  cardName.text != "" && cardDescription.text != "" && frontImage != nil {
            if cardEdit != nil {
                card.editCard( card: cardEdit!,
                               name: cardName.text,
                               descript: cardDescription.text,
                               date: Date(),
                               frontImage: card.addToUrl((frontImage?.image)!),
                               backImage: card.addToUrl((backImage?.image)!),
                               barCode: card.addToUrl((barCodeImage?.image)!),
                               filter: card.chooseSegmentOfFilter(segment: SegmentFilter) )
            } else {
                card.createCard( name: cardName.text,
                                 descript: cardDescription.text,
                                 date: Date(),
                                 frontImage: card.addToUrl((frontImage?.image)!),
                                 backImage: card.addToUrl((backImage?.image)!),
                                 barCode: card.addToUrl((barCodeImage?.image)!),
                                 filter: card.chooseSegmentOfFilter(segment: SegmentFilter))
            }
        }else {
            let alertController = UIAlertController(title: "OOPS", message: "You need to give all the informations required to save this card", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
        
        

    }
    
    @IBAction func tapToFrontImage(_ sender: Any) {
        imageIs = "frontImage"
        allertAfterTapRecognizer()
    }
    @IBAction func tapToBackImage(_ sender: Any) {
        imageIs = "backImage"
        allertAfterTapRecognizer()
    }
    
    func allertAfterTapRecognizer() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: "Add a Picture", message: "Choose From", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            if(UIImagePickerController.isSourceTypeAvailable(.camera)){
                pickerController.sourceType = .camera
                self.present(pickerController, animated: true, completion: nil)
            }else{
                let alertController = UIAlertController(title: "Error", message: "Camera is not available now", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
        let photosLibraryAction = UIAlertAction(title: "Photos Library", style: .default) { (action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let savedPhotosAction = UIAlertAction(title: "Saved Photos Album", style: .default) { (action) in
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photosLibraryAction)
        alertController.addAction(savedPhotosAction)
        alertController.addAction(cancelAction)
        
        
        present(alertController, animated: true, completion: nil)
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        if  imageIs == "frontImage" {
            self.frontImage?.image = image
        }else{
            self.backImage?.image = image
        }
    }
    
 
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
