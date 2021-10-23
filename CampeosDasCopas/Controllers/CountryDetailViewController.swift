//
//  CountryDetailViewController.swift
//  CampeosDasCopas
//
//  Created by Paulo Menezes on 07/08/21.
//

import UIKit

class CountryDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelWinners: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var worldCups: [WorldCup] = []
    var selectedWorldCup: WorldCup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selected = selectedWorldCup {
            imageView.image = UIImage(named: selected.winner)
            labelTitle.text = selected.winner
            title = selected.winner
            
            var count = 0
            var text = ""
            
            for worldCup in worldCups {
                if worldCup.winner == selected.winner {
                    count += 1
                    
                    text.append("\(worldCup.country), \(worldCup.year) (\(worldCup.winner) \(worldCup.winnerScore) x \(worldCup.viceScore) \(worldCup.vice))\n")
                }
            }
            
            labelWinners.text = "\(count)"
            textView.text = text
        }
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
