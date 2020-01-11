//
//  Album.swift
//  PulentFinder
//
//  Created by Gaspar Valenzuela on 11-01-20.
//  Copyright © 2020 Gaspar Valenzuela. All rights reserved.
//

import Foundation


class Album{
    
    
    public private(set) var wrapperType : String?
    public private(set) var kind : String?
    public private(set) var artistId : String?
    public private(set) var collectionId : String?
    public private(set) var trackId : String?
    public private(set) var artistName : String?
    public private(set) var collectionName : String?
    public private(set) var collectionCensoredName : String?
    public private(set) var trackCensoredName : String?
    public private(set) var artistViewUrl : String?
    public private(set) var collectionViewUrl : String?
    public private(set) var trackViewUrl : String?
    public private(set) var previewUrl : String?
    public private(set) var artworkUrl30 : String?
    public private(set) var artworkUrl60 : String?
    public private(set) var artworkUrl100 : String?
    public private(set) var collectionPrice : String?
    public private(set) var trackPrice : String?
    public private(set) var collectionHdPrice : String?
    public private(set) var trackHdPrice : String?
    public private(set) var releaseDate : String?
    public private(set) var collectionExplicitness : String?
    public private(set) var trackExplicitness : String?
    public private(set) var discCount : String?
    public private(set) var discNumber : String?
    public private(set) var trackCount : String?
    public private(set) var trackNumber : String?
    public private(set) var trackTimeMillis : String?
    public private(set) var country : String?
    public private(set) var currency : String?
    public private(set) var primaryGenreName : String?
    public private(set) var contentAdvisoryRating : String?
    public private(set) var shortDescription : String?
    public private(set) var longDescription : String?
    
    /*override init(){
        
        super.init()
    }*/
    
    init(withJson dict: NSDictionary) {
        set(json: dict)
    }
    
     func set(json dict: NSDictionary) {
        //super.set(json: dict)
        
        wrapperType = dict.value(forKey: "wrapperType") as? String
        kind = dict.value(forKey: "kind") as? String
        artistId = dict.value(forKey: "artistId") as? String
        artistId = dict.value(forKey: "artistId") as? String
        collectionId = dict.value(forKey: "collectionId") as? String
        trackId = dict.value(forKey: "trackId") as? String
        artistName = dict.value(forKey: "artistName") as? String
        collectionName = dict.value(forKey: "collectionName") as? String
        collectionCensoredName = dict.value(forKey: "collectionCensoredName") as? String
        trackCensoredName = dict.value(forKey: "trackCensoredName") as? String
        artistViewUrl = dict.value(forKey: "artistViewUrl") as? String
        collectionViewUrl = dict.value(forKey: "collectionViewUrl") as? String
        trackViewUrl = dict.value(forKey: "trackViewUrl") as? String
        previewUrl = dict.value(forKey: "previewUrl") as? String
        artworkUrl30 = dict.value(forKey: "artworkUrl30") as? String
        artworkUrl60 = dict.value(forKey: "artworkUrl60") as? String
        artworkUrl100 = dict.value(forKey: "artworkUrl100") as? String
        collectionPrice = dict.value(forKey: "collectionPrice") as? String
        trackPrice = dict.value(forKey: "trackPrice") as? String
        collectionHdPrice = dict.value(forKey: "collectionHdPrice") as? String
        trackHdPrice = dict.value(forKey: "trackHdPrice") as? String
        releaseDate = dict.value(forKey: "releaseDate") as? String
        collectionExplicitness = dict.value(forKey: "collectionExplicitness") as? String
        trackExplicitness = dict.value(forKey: "trackExplicitness") as? String
        discCount = dict.value(forKey: "discCount") as? String
        discNumber = dict.value(forKey: "discNumber") as? String
        trackCount = dict.value(forKey: "trackCount") as? String
        trackNumber = dict.value(forKey: "trackNumber") as? String
        trackTimeMillis = dict.value(forKey: "trackTimeMillis") as? String
        country = dict.value(forKey: "country") as? String
        currency = dict.value(forKey: "currency") as? String
        primaryGenreName = dict.value(forKey: "primaryGenreName") as? String
        contentAdvisoryRating = dict.value(forKey: "contentAdvisoryRating") as? String
        shortDescription = dict.value(forKey: "shortDescription") as? String
        longDescription = dict.value(forKey: "longDescription") as? String
    }
    
}
