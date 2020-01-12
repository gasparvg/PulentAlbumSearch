//
//  SearchAlbumService.swift
//  PulentFinder
//
//  Created by Gaspar Valenzuela on 11-01-20.
//  Copyright © 2020 Gaspar Valenzuela. All rights reserved.
//

import Foundation

import Alamofire
import AlamofireImage


class SearchAlbumService{
    
    public static func searchAlbumWithName(withName name: String?, withPage page:String?, _ completion: @escaping (_ success: Bool, _ result: Array<Any>?, _ error: Error?) -> ()){
    
        
        let linkPart1 = "https://itunes.apple.com/search?term=in+"
        let linkPart2 = "&mediaType=music&limit="
        
        var url:String =  linkPart1 + (name ?? "")
         url = url + linkPart2 + (page ?? "")
        
        Alamofire.request(url).responseJSON
        { response in switch response.result {
          
          case .success(let JSON):
            
             let results = ((JSON as! NSDictionary)["results"]) as? Array<Any> ?? Array()
             completion(true, results, nil)
             
            case .failure(let error):
                completion(false, [] as Array<Any>, error)
         }
        }
    }
    
    public static func getImage(fromUrl url: String, _ completion: @escaping (_ success: Bool, _ result: UIImage?, _ error: Error?) -> ()){
     
        Alamofire.request(url,method: .get).responseImage { response in
           
            guard let image = response.result.value else {
        
                completion(false, nil, response.error)
                return
            }
            
            completion(true, image, nil)
        }
    }
}
