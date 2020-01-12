//
//  AlbumDetailVC.swift
//  PulentFinder
//
//  Created by Gaspar Valenzuela on 11-01-20.
//  Copyright © 2020 Gaspar Valenzuela. All rights reserved.
//

import UIKit
import AVKit

class AlbumDetailVC: UIViewController,UITableViewDataSource, UITableViewDelegate     {

    
    @IBOutlet weak var art100x100ImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoContentView: UIView!
    @IBOutlet weak var scrollContentView: UIView!
    
    var selectedRow = false
    var selectedRowValue:Int?
    var indicator = UIActivityIndicatorView()
   
    @IBOutlet weak var musicTableView: UITableView!
    
    var albumDetail:Track! = nil
    var pagination = 20
    var player : AVPlayer?
    var noPreview = false
    var tracks:Array<Track> = []
    var hideShowMore = true
    
    //MARK: TableView
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        playSong(radioURL: (self.tracks[indexPath.row] as Track).previewUrl ?? "")
        selectedRow = true
        selectedRowValue = indexPath.row
        musicTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return self.tracks.count;
        }
      
        return 0
    }
    
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
      
        if section == 1{
            
            return 64.0
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
            if selectedRow == true && selectedRowValue == indexPath.row{
                
                cell.configureCell(withTrack: self.tracks[indexPath.row], withSelectConfiguration: true)
            }
            else{
                
                cell.configureCell(withTrack: self.tracks[indexPath.row], withSelectConfiguration: false)
            }
            cell.selectionStyle = .none
            return cell
        }
        
        let cell = self.musicTableView.dequeueReusableCell(withIdentifier: "Cell")!
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        if hideShowMore != true{
           
            guard section == 1 else { return nil }

            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44.0))
            let showMoreButton = UIButton(frame: CGRect(x: 0, y: 5, width: 130, height: 34.0))
            // here is what you should add:
            showMoreButton.center = footerView.center

            showMoreButton.setTitle("Mostrar mas", for: .normal)
            showMoreButton.backgroundColor = .lightGray
            showMoreButton.layer.cornerRadius = 10.0
            showMoreButton.addTarget(self, action: #selector(showMore(sender:)), for: .touchUpInside)
            footerView.addSubview(showMoreButton)
            return footerView
        }
        
        return nil
    }
    
    @objc func showMore(sender:UIButton){
           
           pagination+=20
           searchAlbumTracks()
    }
    
    func resizeTable(){
        
        self.tableHeightConstraint.constant = CGFloat((self.tracks.count * 64)) + 44
        scrollContentView.frame.size.height =  infoContentView.frame.size.height + 120 + 44 + CGFloat((self.tracks.count * 64))
        scrollContentView.updateConstraints()
        scrollContentView.layoutIfNeeded()
        musicTableView.contentSize.height = CGFloat((self.tracks.count * 64)) + 44
        self.view.setNeedsUpdateConstraints()
        scrollContentView.setNeedsUpdateConstraints()
        musicTableView.setNeedsUpdateConstraints()
        
    }
    
    @IBAction func closeAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        player?.pause()
    }
    
    
    //MARK: Config
    
    func configureTableView(){
        
        musicTableView.register(UINib(nibName: "TrackTableViewCell", bundle: nil), forCellReuseIdentifier: "TrackCell")
        self.musicTableView.tableFooterView = UIView.init(frame:CGRect.zero)
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
    
    //MARK: Services
    
    func searchAlbumTracks(){
        
            hideShowMore = true
            self.musicTableView.reloadData()
        
            SearchAlbumService.searchAlbumWithName(withName:GeneralHelpers.replaceSpaces(forTextSearch: albumDetail.collectionName!), withPage: String(pagination)){ (success, result, error) in
            
                self.indicator.startAnimating()
                self.indicator.backgroundColor = UIColor.lightGray
                
                if success && error == nil {
                 
                    self.tracks =  AlbumMapping.getAlbums(fromJson:result ?? [],byCollectionId: self.albumDetail.collectionId)
                   
                    
                    if self.tracks.count == 0{
                        
                        self.hideShowMore = true
                        self.musicTableView.reloadData()
                        
                    }
                    else{
                        
                        self.hideShowMore = false
                        self.musicTableView.reloadData()
                        self.indicator.stopAnimating()
                        self.indicator.hidesWhenStopped = true
                        self.resizeTable()
                    }
                }else{
                
                }
             }
    }
    
    //MARK: PlaySong
    
    func playSong(radioURL: String) {

        player?.pause()
        guard let url = URL.init(string: radioURL) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        player?.play()
    }
    
    //MARK: life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.black
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        searchAlbumTracks()
        config100x100Image()
        configLabels()
    }
}
