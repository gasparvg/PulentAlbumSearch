//
//  AlbumMapping.swift
//  PulentFinder
//
//  Created by Gaspar Valenzuela on 11-01-20.
//  Copyright © 2020 Gaspar Valenzuela. All rights reserved.
//

import Foundation

class TrackMapping{

    public static func getTracks(fromJson json:Array<Any>, byCollectionId collectionId:String?) -> Array<Track>{
        
        var albums:Array<Track> = []
        for item in json {
           
            
           let album = Track.init(withJson: item as! NSDictionary)
            
            if album.kind != nil && album.kind != "" && album.kind == "song"{
            
                albums.append(album)
            }
        }
      
        //Filtramos las canciones por Album en caso de que venga un collectionId específico
        if collectionId != nil{
            
            let filtered = albums.filter { $0.collectionId!.contains(collectionId ?? "") }
            filtered.forEach { print($0) }
            
            return filtered
        }
        
        return albums
    }
}


