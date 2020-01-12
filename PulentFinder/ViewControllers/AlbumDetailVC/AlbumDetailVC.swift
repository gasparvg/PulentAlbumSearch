//
//  AlbumDetailVC.swift
//  PulentFinder
//
//  Created by Gaspar Valenzuela on 11-01-20.
//  Copyright © 2020 Gaspar Valenzuela. All rights reserved.
//

import UIKit

class AlbumDetailVC: UIViewController {

    
    @IBOutlet weak var art100x100ImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
   
    var albumDetail:Album! = nil
    var pagination = 20
    
    //MARK: Config
    
    func config100x100Image(){
            
        SearchAlbumService.getImage(fromUrl: albumDetail.artworkUrl100!){ (success, result, error) in
            
            self.art100x100ImageView.image = result
        }
    }
    
    func configLabels(){
        
        albumNameLabel.text = albumDetail.collectionName
        artistNameLabel.text = albumDetail.artistName
    }
    
    //MARK: Services
    
    func configMusicTableView(){
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config100x100Image()
        configLabels()
    }
}
