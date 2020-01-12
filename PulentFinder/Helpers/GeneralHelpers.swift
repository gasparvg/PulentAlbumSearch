//
//  GeneralHelpers.swift
//  PulentFinder
//
//  Created by Gaspar Valenzuela on 11-01-20.
//  Copyright © 2020 Gaspar Valenzuela. All rights reserved.
//

import Foundation


class GeneralHelpers{


    static func replaceSpaces(forTextSearch string:String)->String{
        
        return string.replacingOccurrences(of: " ", with: "+")
    }
}
