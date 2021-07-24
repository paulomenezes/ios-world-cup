//
//  GameTableViewCell.swift
//  CampeosDasCopas
//
//  Created by Paulo Menezes on 24/07/21.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewHome: UIImageView!
    @IBOutlet weak var imageViewAway: UIImageView!
    
    @IBOutlet weak var labelHome: UILabel!
    @IBOutlet weak var labelAway: UILabel!
    
    @IBOutlet weak var labelScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with game: Game) {
        imageViewHome.image = UIImage(named: game.home)
        imageViewAway.image = UIImage(named: game.away)
        
        labelHome.text = game.home
        labelAway.text = game.away
        
        labelScore.text = game.score
    }

}
