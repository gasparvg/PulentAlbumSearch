//
//  AlbumMapping.swift
//  PulentFinder
//
//  Created by Gaspar Valenzuela on 11-01-20.
//  Copyright © 2020 Gaspar Valenzuela. All rights reserved.
//

import Foundation

class AlbumMapping{

    public static func getAlbums(fromJson json:Array<Any>) -> Array<Album>{
        
        var albums:Array<Album> = []
        for item in json {
           
           let album = Album.init(withJson: item as! NSDictionary)
            albums.append(album)
        }
        
        return albums
    }
}


