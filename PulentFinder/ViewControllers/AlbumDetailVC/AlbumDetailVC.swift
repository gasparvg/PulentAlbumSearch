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
    var albumDetail:Album! = nil
    
    
    //MARK: Config
    
    func config100x100Image(){
            
        SearchAlbumService.getImage(fromUrl: albumDetail.artworkUrl100!){ (success, result, error) in
                
            self.art100x100ImageView.image = result
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config100x100Image()
    }
}
