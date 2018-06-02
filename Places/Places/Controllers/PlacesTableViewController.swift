//
//  PlacesTableViewController.swift
//  Places
//
//  Created by Liv Souza on 02/06/18.
//  Copyright © 2018 CESAR School. All rights reserved.
//

import UIKit



class PlacesTableViewController: UITableViewController {
    
    
    var places : [Place] = []

    let ud = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadPlaces()
    }
    
    func loadPlaces() {
        
        if let placeData = ud.data(forKey: "places") {
            do {
                places = try JSONDecoder().decode([Place].self, from: placeData)
                tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func savePlaces() {
        do {
            let json = try JSONEncoder().encode(places)
            self.ud.setValue(json, forKey: "places")
        } catch {
            print(error.localizedDescription)
        }
    }

  
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Configure the cell...
        let place = places[indexPath.row]
        cell.textLabel?.text = place.name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "finderSegue" {
            let vc = segue.destination as! PlaceFinderViewController
            vc.delegate = self
        }
    }
    
    

    /*
    
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
    */

}


extension PlacesTableViewController: PlaceFinderDelegate {
    
    func addPlace(_ place: Place) {
        
        // 1
        
        // Como evitar que um place de mesma (longitude e latitude) seja adicionado?
        // TIP. : definir uma regra no model de Place
        
        if !places.contains(place) {
            // save
            self.places.append(place)
            self.savePlaces()
            self.tableView.reloadData()
        }
        
        
    }
}



