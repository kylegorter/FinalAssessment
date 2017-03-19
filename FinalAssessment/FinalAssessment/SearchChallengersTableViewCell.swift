//
//  SearchChallengersTableViewCell.swift
//  FinalAssessment
//
//  Created by Kyle Gorter on 3/19/17.
//  Copyright © 2017 Kyle Gorter. All rights reserved.
//

import Foundation
import UIKit

class SearchTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var challengeButton: UIButton! {
        didSet{
            challengeButton.addTarget(self, action: #selector(challenging) , for: .touchUpInside)
        }
    }
    
    var delegate : SearchTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func challenging(){
        delegate?.didTapChallenge(atCell: self)
    }
    
}

protocol SearchTableViewCellDelegate {
    func didTapChallenge(atCell cell: SearchTableViewCell)
}
