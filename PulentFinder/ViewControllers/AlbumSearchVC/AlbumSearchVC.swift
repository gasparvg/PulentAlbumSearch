//
//  AlbumSearchVC.swift
//  PulentFinder
//
//  Created by Gaspar Valenzuela on 11-01-20.
//  Copyright © 2020 Gaspar Valenzuela. All rights reserved.
//

import UIKit
import AVKit

class AlbumSearchVC: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var initialTextView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    var indicator = UIActivityIndicatorView()
    var player : AVPlayer?
    var pagination = 20
    var didUserDeleteChar = false
    var hideShowMore = true
    var isHiddenInitialText = true
    
    var albums:Array<Album> = []
    
    //MARK: - TableView
    
    func activityIndicatorConfiguration() {
        
        indicator = UIActivityIndicatorView(frame: CGRect(x: self.view.center.x, y: self.view.center.y, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.medium
        indicator.color = UIColor.lightGray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let albumDetailVC = AlbumDetailVC()
        albumDetailVC.albumDetail = self.albums[indexPath.row]
        self.navigationController?.pushViewController(albumDetailVC, animated: true)
        searchbar.resignFirstResponder()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return self.albums.count;
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
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "AlbumCell") as! AlbumTableViewCell
                   //cell.configureCell(withAlbum:self.usersData.serverArray[indexPath.row] as! UserDM)
                   cell.configureCell(withAlbum: self.albums[indexPath.row])
                   return cell
        }
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell")!
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
            //doneButton.shadow = true
            //doneButton.addTarget(self, action: #selector(hello(sender:)), for: .touchUpInside)
            footerView.addSubview(doneButton)
            return footerView
        }
        
        return nil
    }
    
    //MARK: configure
    
    
    func configureTableView(){
        
        self.searchbar.delegate = self
         tableView.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: "AlbumCell")
    }
    
    //MARK: Pagination logic
    
    func evaluatePaginationFactor(){
        
        if didUserDeleteChar == true{
            
            pagination = 20
        }
    }
    
    func addMorePressed(){
        
    }
    
    //MARK: Services
    
    func searchAlbums(withName name: String,withPage page: String){
        
        if name.last != " " {
            
            SearchAlbumService.searchAlbumWithName(withName:GeneralHelpers.replaceSpaces(forTextSearch: name), withPage: page){ (success, result, error) in
            
                self.indicator.startAnimating()
                self.indicator.backgroundColor = UIColor.lightGray
                
                if success && error == nil {
                 
                    self.albums =  AlbumMapping.getAlbums(fromJson:result ?? [])
                    self.tableView.reloadData()
                    self.indicator.stopAnimating()
                    self.indicator.hidesWhenStopped = true
                }else{
                
                }
             }
        }
    }
    
    //MARK: Searchbar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int){
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        if searchBar.text == ""{
            
            isHiddenInitialText = false
            
        }
        else{
            
            isHiddenInitialText = true
        }
        
        self.initialTextView.isHidden = isHiddenInitialText
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        switch text {
              
           case "":
           
               didUserDeleteChar = true
               break
               
           default:
               
               break
           }
           
           evaluatePaginationFactor()
        
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchAlbums(withName: searchBar.text!, withPage: String(pagination))
        
    }
    
    override func viewDidLoad() {
       
       super.viewDidLoad()
       
       self.initialTextView.isHidden = isHiddenInitialText
       self.navigationController?.navigationBar.isHidden = true
       configureTableView()
       activityIndicatorConfiguration()
    }

}
