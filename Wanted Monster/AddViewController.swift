
//
//  AddViewController.swift
//  Wanted Monster
//
//  Created by Marjolaine Roux on 9/10/17.
//  Copyright © 2017 Marjolaine Roux. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource, UINavigationControllerDelegate,UIImagePickerControllerDelegate
{

    var typeOfMonsterSelected:typeMonster?
    @IBOutlet weak var monsterImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typePicker: UIPickerView!
  
    
    @IBAction func takePhoto(_ sender: Any)
    {
        let image=UIImagePickerController()
        image.delegate=self
        image.sourceType=UIImagePickerControllerSourceType.camera
        image.allowsEditing=false
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    
    @IBAction func importImage(_ sender: Any)
    {
        let image=UIImagePickerController()
        image.delegate=self
        image.sourceType=UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing=false
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image=info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            monsterImage.image=image
        }
        else
        {
            //TODO
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addMonster(_ sender: Any)
    {
        guard let unwrappedTypeOfMonsterSelected=typeOfMonsterSelected else
        {
         return
        }
        guard let  imageMonsterSelected=monsterImage.image else
        {
            let alertController = UIAlertController(title: "Hey", message: "You need to add a picture please", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
            let someMonster=Monster(typeOfMonster: unwrappedTypeOfMonsterSelected, pictureOfMonster: imageMonsterSelected)
        FirebaseManager.addImageOfMonster(monster:someMonster)
        let alertController = UIAlertController(title: "Monster added", message:
            "Thank you for participating", preferredStyle: UIAlertControllerStyle.alert)
        let addAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.tabBarController?.selectedIndex = 0
        }
        alertController.addAction(addAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return typeArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return typeArray.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let typeOfMonsterPicked=typeArray[row]
        switch typeOfMonsterPicked
        {
        case "pile":
            typeOfMonsterSelected = .pile
        case "chair":
            typeOfMonsterSelected = .chair
        case "couch":
            typeOfMonsterSelected = .couch
        case "decoration":
            typeOfMonsterSelected = .decoration
        default:
            typeOfMonsterSelected = .decoration
            
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
      
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
 
    }
}

