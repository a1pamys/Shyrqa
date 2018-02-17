//
//  Formatter.swift
//  Shyrqa
//
//  Created by Алпамыс on 21.07.17.
//  Copyright © 2017 Алпамыс. All rights reserved.
//

import UIKit
import RealmSwift

class Formatter {
    
    static func removeTrash() -> [Song]{
        let realm = try! Realm()
        var parsedTexts: Results<ParsedText>?
        var songsArray: [Song] = []
        
        parsedTexts = realm.objects(ParsedText.self).sorted(byKeyPath: "text", ascending: true)
        for realmText in parsedTexts! {
            let textArr = realmText.text.components(separatedBy: "by OlzhasOmar")
            var title = textArr[0]
            var lyrics = textArr[1]
            title = title.replacingOccurrences(of: "\t", with: "")
            title = title.replacingOccurrences(of: "\n", with: "")
            title = title.replacingOccurrences(of: "(аккорды)", with: "")
            lyrics = lyrics.replacingOccurrences(of: "http://kazchords.kz — аккорды и тексты казахстанских песен", with: "")
            lyrics = lyrics.replacingOccurrences(of: "\n\n\n\n\n\n\n\n\n\n\n\n", with: "")
            var i = 1
            for uni in lyrics.unicodeScalars {
                let val = uni.value
                if (val >= 65 && val <= 90) || (val >= 97 && val <= 122) {
                    break
                }
                i += 1
            }
            let index2 = lyrics.index(lyrics.startIndex, offsetBy: i-1)
            lyrics = lyrics.substring(from: index2)
            for uni in lyrics.unicodeScalars {
                let val = uni.value
                if (val >= 65 && val <= 90) || (val >= 97 && val <= 122) {
                    let song = Song(title: title, lyrics: lyrics)
                    if(song.title == "KZ тобы — Шіркін — ай "){
                        continue
                    }
                    songsArray.append(song)
                    break
                }
            }
        }
        return songsArray
    }
    
    static func connectLetterToSong(Songs: [Song], indeces: inout [String]) -> [(String,[Song])]{
        var index = 0
        var matrixOfSongs = [(String,[Song])]()
        indeces = ["1","А","Ә","Б","Г","Ғ","Д","Е","Ж","З","И","К","Қ","Л","М","Н","О","Ө","П","Р","С","Т","У","Ұ","Ү","Ч","Ш","І","A","B","C","D","F","G","J","K","M","N","R","S","X"]
        for letter in indeces{
            matrixOfSongs.append((letter,[]))
            for song in Songs {
                if song.title?.characters.first == letter.characters.first {
                    matrixOfSongs[index].1.append(song)
                }
            }
            index += 1
        }
        return matrixOfSongs
    }
    
}
