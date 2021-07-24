//
//  WorldCupViewController.swift
//  CampeosDasCopas
//
//  Created by Paulo Menezes on 24/07/21.
//

import UIKit

class WorldCupViewController: UIViewController {
    var worldCup: WorldCup!

    @IBOutlet weak var imageViewWinner: UIImageView!
    @IBOutlet weak var imageViewVice: UIImageView!
    
    @IBOutlet weak var labelWinner: UILabel!
    @IBOutlet weak var labelVice: UILabel!
    
    @IBOutlet weak var labelScores: UILabel!
    @IBOutlet weak var labelPenalties: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "WorldCup \(worldCup.year)"

        imageViewWinner.image = UIImage(named: worldCup.winner)
        imageViewVice.image = UIImage(named: worldCup.vice)
        
        labelWinner.text = worldCup.winner
        labelVice.text = worldCup.vice
        
        if worldCup.winnerScore.contains(" ") {
            let winnerScore = worldCup.winnerScore.split(separator: " ")
            let viceScore = worldCup.viceScore.split(separator: " ")
            
            labelScores.text = "\(winnerScore[0]) x \(viceScore[0])"
            labelPenalties.text = "\(winnerScore[1]) x \(viceScore[1])"
        } else {
            labelScores.text = "\(worldCup.winnerScore) x \(worldCup.viceScore)"
            labelPenalties.text = ""
        }
    }
}

extension WorldCupViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return worldCup.matches.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worldCup.matches[section].games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameTableViewCell
        
        let match = worldCup.matches[indexPath.section]
        let game = match.games[indexPath.row]
        
        cell.prepare(with: game)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return worldCup.matches[section].stage
    }
}
