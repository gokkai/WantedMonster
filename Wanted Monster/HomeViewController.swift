//
//  HomeViewController.swift
//  Wanted Monster
//
//  Created by Marjolaine Roux on 3/10/17.
//  Copyright © 2017 Marjolaine Roux. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    
    var monsters:[Monster]=[]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        monsters=createArray()
        
        homeTableView.delegate=self
        homeTableView.dataSource=self
        

    }

    func createArray() ->[Monster]{
        var tempMonster:[Monster]=[]
        
        let monster1=Monster(typeOfMonster: .chair, pictureOfMonster: #imageLiteral(resourceName: "genaude"))
        let monster2=Monster(typeOfMonster: .couch, pictureOfMonster: #imageLiteral(resourceName: "cookieMonster"))
        let monster3=Monster(typeOfMonster: .pile, pictureOfMonster: #imageLiteral(resourceName: "Kraken_v2_by_elmisa-d70nmt4"))
        let monster4=Monster(typeOfMonster: .decoration, pictureOfMonster:#imageLiteral(resourceName: "cthulhu"))
        let monster5=Monster(typeOfMonster: .pile, pictureOfMonster: #imageLiteral(resourceName: "spectra"))
        let monster6=Monster(typeOfMonster: .couch, pictureOfMonster:#imageLiteral(resourceName: "nosferatu"))
        
        tempMonster.append(monster1)
        tempMonster.append(monster2)
        tempMonster.append(monster3)
        tempMonster.append(monster4)
        tempMonster.append(monster5)
        tempMonster.append(monster6)
        
        return tempMonster
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToDetail"{
            let destVC=segue.destination as! DetailsViewController
            destVC.monster=sender as? Monster
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

