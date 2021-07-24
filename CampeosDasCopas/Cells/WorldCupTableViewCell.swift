//
//  WorldCupTableViewCell.swift
//  CampeosDasCopas
//
//  Created by Paulo Menezes on 24/07/21.
//

import UIKit

class WorldCupTableViewCell: UITableViewCell {
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    
    @IBOutlet weak var imageViewWinner: UIImageView!
    @IBOutlet weak var imageViewVice: UIImageView!
    
    @IBOutlet weak var labelWinner: UILabel!
    @IBOutlet weak var labelVice: UILabel!
    
    @IBOutlet weak var labelGoalsWinner: UILabel!
    @IBOutlet weak var labelGoalsVice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func prepare(with wordCup: WorldCup) {
        labelYear.text = String(wordCup.year)
        labelCountry.text = wordCup.country
        
        imageViewWinner.image = UIImage(named: wordCup.winner)
        imageViewVice.image = UIImage(named: wordCup.vice)
        
        labelWinner.text = wordCup.winner
        labelVice.text = wordCup.vice
        
        labelGoalsWinner.text = wordCup.winnerScore
        labelGoalsVice.text = wordCup.viceScore
    }
}
