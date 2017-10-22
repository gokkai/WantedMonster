//
//  HomeViewController.swift
//  Wanted Monster
//
//  Created by Marjolaine Roux on 3/10/17.
//  Copyright © 2017 Marjolaine Roux. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import SwiftyJSON


class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    var ref:DatabaseReference?

    var monsters:[Monster]=[]

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        homeTableView.delegate=self
        homeTableView.dataSource=self

        self.fetchMonster { (monsters) in
            print("done")
            self.monsters = monsters
            self.homeTableView.reloadData()
        }
        
    }

    func fetchMonster(completionHandler: @escaping ([Monster]) -> Void){

        ref = Database.database().reference()
        ref!.observe(.childAdded) { (snapshot) in
            var arrayOfMonster = [Monster]()
            if let value = snapshot.value{
                 let json = JSON(value)
                for (key, value) in json.dictionaryValue{
                    print("Key is \(key) - \(value)")
                    if let monster = Monster(id: key, json: value){
                        arrayOfMonster.append(monster)
                    }
                }
            }
            completionHandler(arrayOfMonster)
        }
    }
    override func viewWillAppear(_ animated: Bool) {

        self.fetchMonster { (monsters) in
            self.monsters = monsters
            self.homeTableView.reloadData()
            
        }
        self.homeTableView.setNeedsDisplay()

    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "HomeToDetail"{
            let destVC=segue.destination as! DetailsViewController
            destVC.monster = sender as? Monster
        }
    }
}

extension HomeViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monsters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let monster=monsters[indexPath.row]
        let cell=tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
        
        cell.setMonster(monster: monster)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let monster=monsters[indexPath.row]
        performSegue(withIdentifier: "HomeToDetail", sender: monster)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

