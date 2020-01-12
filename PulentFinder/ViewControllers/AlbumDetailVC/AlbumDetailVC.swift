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
   
    @IBOutlet weak var musicTableView: UITableView!
    
    var albumDetail:Track! = nil
    var pagination = 20
    var player : AVPlayer?
    var noPreview = false
    var tracks:Array<Track> = []
    var hideShowMore = true
    
    //MARK: TableView
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return self.tracks.count;
        }
        
        return 0
    }
    
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
      
        if section == 1{
            
            return 44.0
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
          
        if hideShowMore != true{
            
            return 2
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.section == 0{
            
            let cell = self.musicTableView.dequeueReusableCell(withIdentifier: "TrackCell") as! TrackTableViewCell
                   cell.configureCell(withTrack: self.tracks[indexPath.row])
                   return cell
        }
        
        let cell = self.musicTableView.dequeueReusableCell(withIdentifier: "Cell")!
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        if hideShowMore != true{
           
            guard section == 1 else { return nil }

            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44.0))
            let doneButton = UIButton(frame: CGRect(x: 0, y: 5, width: 130, height: 34.0))
            // here is what you should add:
            doneButton.center = footerView.center

            doneButton.setTitle("Mostrar mas", for: .normal)
            doneButton.backgroundColor = .lightGray
            doneButton.layer.cornerRadius = 10.0
            footerView.addSubview(doneButton)
            return footerView
        }
        
        return nil
    }
    
    @IBAction func closeAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        player?.pause()
    }
    
    
    func loadSong(radioURL: String) {

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
