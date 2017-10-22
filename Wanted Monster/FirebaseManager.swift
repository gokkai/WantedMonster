//
//  FirebaseManager.swift
//  Wanted Monster
//
//  Created by Marjolaine Roux on 16/10/17.
//  Copyright © 2017 Marjolaine Roux. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import SwiftyJSON


class FirebaseManager{
    
    static var databaseRef: DatabaseReference!
    static let sharedInstance = FirebaseManager()
    var currentUser: User?
    var databaseRef = Database.database().reference()

    static func addMonster(monster:Monster)
    {
        
        databaseRef=Database.database().reference()
        let startDatabase=databaseRef.child("monster").childByAutoId()
        startDatabase.child("typeOfMonster").setValue(monster.typeOfMonster.rawValue)
        startDatabase.child("downloadingImageUrl").setValue(monster.downlodingImageUrl)
        startDatabase.child("latitudeOfMonster").setValue(monster.latitudeOfMonster)
        startDatabase.child("longitudeOfMonster").setValue(monster.longitudeOfMonster)

       

    }
    static func addImageOfMonster(monster:Monster)
    {
        //let uid="mmmm"
        let imageName=NSUUID().uuidString
        let storage = Storage.storage()
        let storageRef=storage.reference().child("\(imageName).png")
        guard let image = monster.pictureOfMonster else {
            return
        }
        if let uploadPicture=UIImagePNGRepresentation(image)
        {
            //let imagesRef=storageRef.child("imageOfMonster")
            //completion is a callback on completion
            storageRef.putData(uploadPicture, metadata: nil, completion:
            {
                    (metadata, error) in
                    if error != nil
                    {
                        print("Ther's been an error, sorry")
                        return
                    }
               if let downloadImageUrl=metadata?.downloadURL()?.absoluteString
               {
                    monster.downlodingImageUrl=downloadImageUrl
                    addMonster(monster: monster)
                }
            })
            
        }
    }
    
    static func deleteMonster(monster:Monster){
        databaseRef=Database.database().reference()
        let imageUrl=monster.downlodingImageUrl
        let fileName=getFileNameFromUrl(url: imageUrl!)
        let desertRef = Storage.storage().reference().child(fileName!)
        
        // Delete the file
        desertRef.delete { error in
            if error != nil
            {
                print("Uh-oh, an error occurred!")
            } else
            {
                let refMonster=databaseRef.child("monster").child(monster.monsterId!)
                refMonster.removeValue()
            }
        }
        
        
    }
    
    static func getFileNameFromUrl(url:String)->String?
    {
        guard let URL = URLComponents(string: url) else { return nil }
        let theFileName = (URL.path as NSString).lastPathComponent
        return theFileName
    }

    
        
        func logInToApplication(userName : String, password : String, completionHandler : @escaping (Bool, Error?)->Void){
            Auth.auth().signIn(withEmail: userName, password: password) { (user, error) in
                self.currentUser = user
                completionHandler(user != nil, error)
            }
        }
        
        func createANewUser(userName : String, password : String, completionHandler : @escaping (Bool, Error?)->   Void){
            Auth.auth().createUser(withEmail: userName, password: password){(user,error) in
                if let error = error{
                    completionHandler(user == nil, error)
                }
                else{
                    
                    self.currentUser = user
                    self.currentUser?.sendEmailVerification(completion: nil)
                    completionHandler(user != nil, error)
                }
            }
        }
    
}
