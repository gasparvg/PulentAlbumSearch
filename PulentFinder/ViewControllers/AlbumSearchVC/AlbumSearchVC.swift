//
//  AlbumSearchVC.swift
//  PulentFinder
//
//  Created by Gaspar Valenzuela on 11-01-20.
//  Copyright © 2020 Gaspar Valenzuela. All rights reserved.
//

import UIKit

class AlbumSearchVC: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var initialTextView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    var indicator = UIActivityIndicatorView()
    var pagination = 20
    var didUserDeleteChar = false
    var hideShowMore = true
    var isHiddenInitialText = false
    
    var albums:Array<Track> = []
    
    //MARK: - TableView
    
   
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        if targetContentOffset.pointee.y > scrollView.contentOffset.y {
             searchbar.resignFirstResponder()
        }
    }
    
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
        
        searchbar.resignFirstResponder()
        self.navigationController?.present(albumDetailVC, animated: true, completion: nil)
        //self.navigationController?.pushViewController(albumDetailVC, animated: true)
        
        
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
                   cell.configureCell(withTrack: self.albums[indexPath.row])
                   return cell
        }
        
        let cell : UITableViewCell = UITableViewCell(style:UITableViewCell.CellStyle.subtitle, reuseIdentifier:"cell")
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        if hideShowMore != true{
           
            guard section == 1 else { return nil }

            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44.0))
            let showMoreButton = UIButton(frame: CGRect(x: 0, y: 5, width: 130, height: 34.0))
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
        
        evaluatePaginationFactor()
        searchAlbums(withName: searchbar.text ?? "", withPage: String(pagination))
    }
    
    //MARK: configure
    
    
    func configureTableView(){
        
        self.searchbar.delegate = self
         tableView.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: "AlbumCell")
    }
    
    func configureKeyboard(){
        
        UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.dark
        
    }
    //MARK: Pagination logic
    
    func evaluatePaginationFactor(){
        
        if didUserDeleteChar == true{
            
            pagination = 20
        }
        else{
            
            pagination+=20
        }
    }
    
    func addMorePressed(){
        
    }
    
    //MARK: Services
    
    func searchAlbums(withName name: String,withPage page: String){
        
        if name.last != " " {
            
            hideShowMore = true
            self.tableView.reloadData()
            SearchAlbumService.searchAlbumWithName(withName:GeneralHelpers.replaceSpaces(forTextSearch: name), withPage: page){ (success, result, error) in
            
                //self.indicator.startAnimating()
                //self.indicator.backgroundColor = UIColor.lightGray
                
                if success && error == nil {
                 
                    self.albums =  AlbumMapping.getAlbums(fromJson:result ?? [],byCollectionId: nil)
                    self.hideShowMore = false
                    self.tableView.reloadData()
                    //self.indicator.stopAnimating()
                    //self.indicator.hidesWhenStopped = true
                    
                }else{
                
                }
             }
        }
    }
    
    //MARK: Searchbar
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    
        
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        switch text {
              
           case "":
           
               didUserDeleteChar = true
               break
               
           default:
               
                didUserDeleteChar = false
               break
           }
           
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == ""{
            
            isHiddenInitialText = false
            albums.removeAll()
            tableView.reloadData()
            self.tableView.isHidden = true
            
        }
        else{
            
            isHiddenInitialText = true
            searchAlbums(withName: searchBar.text!, withPage: String(pagination))
            self.tableView.isHidden = false
            
        }
        
        self.initialTextView.isHidden = isHiddenInitialText
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
         self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
       
       super.viewDidLoad()
       
       self.initialTextView.isHidden = isHiddenInitialText
       configureTableView()
       configureKeyboard()
       //activityIndicatorConfiguration()
    }

}
