//
//  ChallengeUserTableViewCell.swift
//  FinalAssessment
//
//  Created by Kyle Gorter on 3/17/17.
//  Copyright © 2017 Kyle Gorter. All rights reserved.
//

import UIKit

class ChallengeUserTableViewCell: UITableViewCell {

    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var displayImageView: UIImageView!
    var delegate : ChallengeUserTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    }

protocol  ChallengeUserTableViewCellDelegate {
    func didTapUnchallenge(cell : ChallengeUserTableViewCell)
}

