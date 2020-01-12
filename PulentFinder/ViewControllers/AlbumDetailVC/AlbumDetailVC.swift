//
//  AlbumDetailVC.swift
//  PulentFinder
//
//  Created by Gaspar Valenzuela on 11-01-20.
//  Copyright © 2020 Gaspar Valenzuela. All rights reserved.
//

import UIKit
import AVKit

class AlbumDetailVC: UIViewController {

    
    @IBOutlet weak var art100x100ImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
   
    var albumDetail:Album! = nil
    var pagination = 20
    var player : AVPlayer?
    var noPreview = false
    
    
    //MARK: Album preview
    
    
    
    @IBAction func closeAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        player?.pause()
    }
    
    
    func loadRadio(radioURL: String) {

        guard let url = URL.init(string: radioURL) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
    }
    
    //MARK: Config
    
    func configAlbumPreview(){
        
        guard let url = URL.init(string: albumDetail.previewUrl ?? "" ) else {
            noPreview = true
            return }
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
    }
    
    func config100x100Image(){
            
        SearchAlbumService.getImage(fromUrl: albumDetail.artworkUrl100!){ (success, result, error) in
            
            self.art100x100ImageView.image = result
        }
    }
    
    func configLabels(){
        
        albumNameLabel.text = albumDetail.collectionName
        artistNameLabel.text = albumDetail.artistName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.black
        
        if noPreview == false{
            
            player?.play()
        }
        
    }
    
    //MARK: life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config100x100Image()
        configLabels()
        configAlbumPreview()
    }
}
