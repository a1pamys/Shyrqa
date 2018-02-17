//
//  FavoriteSongTableViewCell.swift
//  Shyrqa
//
//  Created by Алпамыс on 24.07.17.
//  Copyright © 2017 Алпамыс. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteSongTableViewCell: UITableViewCell {

    let realm = try! Realm()
    var songTitle = ""
    var songLyrics = ""
    
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var favoriteSongNameLabel: UILabel!
    @IBOutlet weak var favoriteSongAuthorLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var myView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        songImageView.layer.borderWidth = 1
        songImageView.layer.borderColor = UIColor.lightGray.cgColor
        layer.backgroundColor = UIColor.clear.cgColor
        myView.layer.borderWidth = 1
        myView.layer.borderColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowOffset = CGSize.init(width: 7, height: 7)
        shadowView.layer.shadowRadius = 7
        shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds.offsetBy(dx: 7, dy: 7)).cgPath

        // Initialization code
    }
}
