//
//  WinnersTableViewController.swift
//  CampeosDasCopas
//
//  Created by Paulo Menezes on 24/07/21.
//

import UIKit

class WinnersTableViewController: UITableViewController {
    var worldCups: [WorldCup] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWorldCups()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func loadWorldCups() {
        let fileURL = Bundle.main.url(forResource: "winners", withExtension: ".json")!
        let jsonData = try! Data(contentsOf: fileURL)

        do {
          worldCups = try JSONDecoder().decode([WorldCup].self, from: jsonData)
        } catch  {
          print(error.localizedDescription)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return worldCups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorldCupTableViewCell

        let worldCup = worldCups[indexPath.row]
        
        cell.prepare(with: worldCup)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.destination is WorldCupViewController {
            let viewController = segue.destination as! WorldCupViewController
            
            let worldCup = worldCups[tableView.indexPathForSelectedRow!.row]
            
            viewController.worldCup = worldCup
        } else if segue.destination is MapViewController {
            let viewController = segue.destination as! MapViewController
            
            viewController.worldCups = worldCups
        }
    }
}
