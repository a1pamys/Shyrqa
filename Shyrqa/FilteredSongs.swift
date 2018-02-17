//
//  FilteredSongs.swift
//  Shyrqa
//
//  Created by Алпамыс on 28.07.17.
//  Copyright © 2017 Алпамыс. All rights reserved.
//

import UIKit
import RealmSwift

class FilteredSongs {
    
    
    static func getSongs() -> [Song] {
        var songsArr = [Song]()
        let config = Realm.Configuration(
            // Get the URL to the bundled file
            fileURL: Bundle.main.url(forResource: "default", withExtension: "realm"),
            // Open the file in read-only mode as application bundles are not writeable
            readOnly: true)
        // Open the Realm with the configuration
        let realm = try! Realm(configuration: config)
        // Read some data from the bundled Realm
        let songs = realm.objects(RealmSongs.self)
        for song in songs {
            songsArr.append(Song(title: song.songTitle, lyrics: song.songLyrics))
        }
        return songsArr
    }
    
}
