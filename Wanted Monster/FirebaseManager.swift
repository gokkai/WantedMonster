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


class FirebaseManager{
    
    static var databaseRef: DatabaseReference!

    static func addMonster(monster:Monster)
    {
        
        databaseRef=Database.database().reference()
        let startDatabase=databaseRef.child("monster").childByAutoId()
        startDatabase.child("typeOfMonster").setValue(monster.typeOfMonster.description)
        startDatabase.child("downloadingImageUrl").setValue(monster.downlodingImageUrl)
        startDatabase.child("latitudeMonster").setValue(monster.latitudeOfMonster)
        startDatabase.child("longitudeMonster").setValue(monster.longitudeOfMonster)
       

    }
    static func addImageOfMonster(monster:Monster){
        //let uid="mmmm"
        let imageName=NSUUID().uuidString
        let storage = Storage.storage()
        let storageRef=storage.reference().child("\(imageName).png")
        if let uploadPicture=UIImagePNGRepresentation(monster.pictureOfMonster)
        {
            //let imagesRef=storageRef.child("imageOfMonster")
            //completion is a callback on completion
            storageRef.putData(uploadPicture, metadata: nil, completion:
            {
                    (metadata, error) in
                    if error != nil
                    {
                        print(error)
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
}
