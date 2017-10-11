
//
//  AddViewController.swift
//  Wanted Monster
//
//  Created by Marjolaine Roux on 9/10/17.
//  Copyright © 2017 Marjolaine Roux. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource, UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var monsterImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typePicker: UIPickerView!
  
    @IBAction func takePhoto(_ sender: Any) {
        let image=UIImagePickerController()
        image.delegate=self
        image.sourceType=UIImagePickerControllerSourceType.camera
        image.allowsEditing=false
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    
    @IBAction func importImage(_ sender: Any) {
        let image=UIImagePickerController()
        image.delegate=self
        image.sourceType=UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing=false
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image=info[UIImagePickerControllerOriginalImage] as? UIImage{
            monsterImage.image=image
        }
        else{
            //TODO
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeArray.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //TODO
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }
    

}
