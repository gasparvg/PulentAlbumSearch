//
//  TrackTableViewCell.swift
//  PulentFinder
//
//  Created by Gaspar Valenzuela on 12-01-20.
//  Copyright © 2020 Gaspar Valenzuela. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(withTrack track:Track,withSelectConfiguration value:Bool?) {
           
           self.trackNameLabel.text = track.trackName
           self.artistNameLabel.text = track.artistName
        
        if value == true{
            
            self.trackNameLabel.textColor = UIColor.green
        }
        else{
            
            self.trackNameLabel.textColor = UIColor.white
        }
    }
    
}
