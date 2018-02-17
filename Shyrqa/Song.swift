//
//  File.swift
//  Shyrqa
//
//  Created by Алпамыс on 16.07.17.
//  Copyright © 2017 Алпамыс. All rights reserved.
//

import UIKit
import RealmSwift

class Song {
    
    var title: String?
    var lyrics: String?
    
    init(title: String, lyrics: String){
        self.title = title
        self.lyrics = lyrics
    }
}
