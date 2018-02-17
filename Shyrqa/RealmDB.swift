//
//  RealmDB.swift
//  Shyrqa
//
//  Created by Алпамыс on 19.07.17.
//  Copyright © 2017 Алпамыс. All rights reserved.
//

import UIKit
import RealmSwift

class ParsedText: Object {
    dynamic var text = ""
}

class FavoriteSongs: Object{
    dynamic var favoriteSongTitle = ""
    dynamic var favoriteSongLyrics = ""
}

class RealmSongs: Object {
    dynamic var songTitle = ""
    dynamic var songLyrics = ""
}
