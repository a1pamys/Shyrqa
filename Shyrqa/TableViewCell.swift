//
//  TableViewCell.swift
//  Shyrqa
//
//  Created by Алпамыс on 18.07.17.
//  Copyright © 2017 Алпамыс. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewCell: UITableViewCell {
    
    let realm = try! Realm()
    var songTitle = ""
    var songLyrics = ""
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var songAuthorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        songImageView.layer.borderWidth = 1
        songImageView.layer.borderColor = UIColor.lightGray.cgColor
        myView.layer.borderWidth = 1
        myView.layer.borderColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowOffset = CGSize.init(width: 7, height: 7)
        shadowView.layer.shadowRadius = 7
        shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds.offsetBy(dx: 7, dy: 7)).cgPath
//        shadowView.layer.shouldRasterize = true
    }

    @IBAction func favoriteButtonPressed(_ sender: Any) {
        if favoriteButton.imageView?.image == UIImage(named: "f24") {
            favoriteButton.setImage(UIImage(named: "fN24"), for: .normal)
            do {
                let songToDelete = realm.objects(FavoriteSongs.self).filter("favoriteSongTitle == '\(songTitle)'")
                try realm.write {
                    realm.delete(songToDelete)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            favoriteButton.setImage(UIImage(named: "f24"), for: .normal)
            do {
                try realm.write {
                    let db = FavoriteSongs()
                    db.favoriteSongTitle = songTitle
                    db.favoriteSongLyrics = songLyrics
                    realm.add(db)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
