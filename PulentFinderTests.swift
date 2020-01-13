//
//  PulentFinderTests.swift
//  PulentFinderTests
//
//  Created by Gaspar Valenzuela on 12-01-20.
//  Copyright © 2020 Gaspar Valenzuela. All rights reserved.
//

import XCTest
@testable import PulentFinderTests

class PulentFinderTests: XCTestCase {

    var emptyArray = Array<Any>()
    var successArray = Array<Any>()
    var successTVEpisodeArray = Array<Any>()
    
    func exampleSuccessTrackList(){
        
        let dict = NSMutableDictionary.init()
        
        dict.setValue("track", forKey: "wrapperType")
        dict.setValue("song", forKey: "kind")
        dict.setValue(269570329, forKey: "artistId")
        dict.setValue(309366086, forKey: "collectionId")
        dict.setValue(309564409, forKey: "trackId")
        dict.setValue("Californication", forKey: "artistName")
        dict.setValue("Californication, Season 2", forKey: "collectionName")
        dict.setValue("In Utero", forKey: "trackName")
        dict.setValue("Californication, Season 2", forKey: "collectionCensoredName")
        dict.setValue("In Utero", forKey: "trackCensoredName")
        dict.setValue("https://itunes.apple.com/us/tv-show/californication/id269570329?uo=4", forKey: "artistViewUrl")
        dict.setValue("https://itunes.apple.com/us/tv-season/in-utero/id309366086?i=309564409&uo=4", forKey: "collectionViewUrl")
        dict.setValue("https://itunes.apple.com/us/tv-season/in-utero/id309366086?i=309564409&uo=4", forKey: "trackViewUrl")
        dict.setValue("https://video-ssl.itunes.apple.com/itunes-assets/Video127/v4/55/9c/c8/559cc8bf-4071-4c9a-0181-785b60cba46a/mzvf_5202598431151026236.640x480.h264lc.U.p.m4v", forKey: "previewUrl")
        dict.setValue("https://is1-ssl.mzstatic.com/image/thumb/Music3/v4/69/13/45/69134598-4435-7023-e96e-875fc9374744/source/30x30bb.jpg", forKey: "artworkUrl30")
        dict.setValue("https://is1-ssl.mzstatic.com/image/thumb/Music3/v4/69/13/45/69134598-4435-7023-e96e-875fc9374744/source/60x60bb.jpg", forKey: "artworkUrl60")
        dict.setValue("https://is1-ssl.mzstatic.com/image/thumb/Music3/v4/69/13/45/69134598-4435-7023-e96e-875fc9374744/source/100x100bb.jpg", forKey: "artworkUrl100")
        dict.setValue(19.99, forKey: "collectionPrice")
        dict.setValue(1.99, forKey: "trackPrice")
        dict.setValue(24.99000, forKey: "collectionHdPrice")
        dict.setValue(2.99000, forKey: "trackHdPrice")
        dict.setValue("2008-11-30T08:00:00Z", forKey: "releaseDate")
        dict.setValue("notExplicit", forKey: "collectionExplicitness")
        dict.setValue( "notExplicit", forKey: "trackExplicitness")
        dict.setValue(1, forKey: "discCount")
        dict.setValue(1, forKey: "discNumber")
        dict.setValue(12, forKey: "trackCount")
        dict.setValue(10, forKey: "trackNumber")
        dict.setValue(1704703, forKey: "trackTimeMillis")
        dict.setValue("USA", forKey: "country")
        dict.setValue("USD", forKey: "currency")
        dict.setValue("Comedy", forKey: "primaryGenreName")
        dict.setValue("TV-MA", forKey: "contentAdvisoryRating")
        dict.setValue("Hank nervously awaits medical test results while reflecting on the early days of his romance with Karen, which coincided with a famous grunge rocker's overdose.", forKey: "shortDescription")
        dict.setValue("While Hank nervously awaits the results of his biopsy, he reflects on his relationship with Karen, and we flashback to the beginning of their stormy union - an event that coincides with the tragic overdose of a famous grunge rocker. Meanwhile, Daisy tells Charlie that she's moving out, but Charlie doesn't want to let her go.", forKey: "longDescription")
        
        successArray.append(dict)
        
    }
    
    func exampleSuccessTVEpisodeList(){
        
        let dict = NSMutableDictionary.init()
        
        dict.setValue("track", forKey: "wrapperType")
        dict.setValue("tv-episode", forKey: "kind")
        dict.setValue(269570329, forKey: "artistId")
        dict.setValue(309366086, forKey: "collectionId")
        dict.setValue(309564409, forKey: "trackId")
        dict.setValue("Californication", forKey: "artistName")
        dict.setValue("Californication, Season 2", forKey: "collectionName")
        dict.setValue("In Utero", forKey: "trackName")
        dict.setValue("Californication, Season 2", forKey: "collectionCensoredName")
        dict.setValue("In Utero", forKey: "trackCensoredName")
        dict.setValue("https://itunes.apple.com/us/tv-show/californication/id269570329?uo=4", forKey: "artistViewUrl")
        dict.setValue("https://itunes.apple.com/us/tv-season/in-utero/id309366086?i=309564409&uo=4", forKey: "collectionViewUrl")
        dict.setValue("https://itunes.apple.com/us/tv-season/in-utero/id309366086?i=309564409&uo=4", forKey: "trackViewUrl")
        dict.setValue("https://video-ssl.itunes.apple.com/itunes-assets/Video127/v4/55/9c/c8/559cc8bf-4071-4c9a-0181-785b60cba46a/mzvf_5202598431151026236.640x480.h264lc.U.p.m4v", forKey: "previewUrl")
        dict.setValue("https://is1-ssl.mzstatic.com/image/thumb/Music3/v4/69/13/45/69134598-4435-7023-e96e-875fc9374744/source/30x30bb.jpg", forKey: "artworkUrl30")
        dict.setValue("https://is1-ssl.mzstatic.com/image/thumb/Music3/v4/69/13/45/69134598-4435-7023-e96e-875fc9374744/source/60x60bb.jpg", forKey: "artworkUrl60")
        dict.setValue("https://is1-ssl.mzstatic.com/image/thumb/Music3/v4/69/13/45/69134598-4435-7023-e96e-875fc9374744/source/100x100bb.jpg", forKey: "artworkUrl100")
        dict.setValue(19.99, forKey: "collectionPrice")
        dict.setValue(1.99, forKey: "trackPrice")
        dict.setValue(24.99000, forKey: "collectionHdPrice")
        dict.setValue(2.99000, forKey: "trackHdPrice")
        dict.setValue("2008-11-30T08:00:00Z", forKey: "releaseDate")
        dict.setValue("notExplicit", forKey: "collectionExplicitness")
        dict.setValue( "notExplicit", forKey: "trackExplicitness")
        dict.setValue(1, forKey: "discCount")
        dict.setValue(1, forKey: "discNumber")
        dict.setValue(12, forKey: "trackCount")
        dict.setValue(10, forKey: "trackNumber")
        dict.setValue(1704703, forKey: "trackTimeMillis")
        dict.setValue("USA", forKey: "country")
        dict.setValue("USD", forKey: "currency")
        dict.setValue("Comedy", forKey: "primaryGenreName")
        dict.setValue("TV-MA", forKey: "contentAdvisoryRating")
        dict.setValue("Hank nervously awaits medical test results while reflecting on the early days of his romance with Karen, which coincided with a famous grunge rocker's overdose.", forKey: "shortDescription")
        dict.setValue("While Hank nervously awaits the results of his biopsy, he reflects on his relationship with Karen, and we flashback to the beginning of their stormy union - an event that coincides with the tragic overdose of a famous grunge rocker. Meanwhile, Daisy tells Charlie that she's moving out, but Charlie doesn't want to let her go.", forKey: "longDescription")
        
        successTVEpisodeArray.append(dict)
        
    }
    
    func testGetAlbums(){
        
        exampleSuccessTrackList()
        exampleSuccessTVEpisodeList()
        XCTAssertEqual((TrackMapping.getTracks(fromJson: emptyArray, byCollectionId: nil)).count,0)
        XCTAssertEqual((TrackMapping.getTracks(fromJson: successArray, byCollectionId: nil)).count,1)
        XCTAssertEqual((TrackMapping.getTracks(fromJson: successArray, byCollectionId: "309366086")).count,1)
        XCTAssertEqual((TrackMapping.getTracks(fromJson: successArray, byCollectionId: "309366080")).count,0)
        XCTAssertEqual((TrackMapping.getTracks(fromJson: successArray, byCollectionId: "")).count,0)
    }
    
    override func setUp() {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        testGetAlbums()
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
