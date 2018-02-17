//
//  LyricsViewController.swift
//  Shyrqa
//
//  Created by Алпамыс on 17.07.17.
//  Copyright © 2017 Алпамыс. All rights reserved.
//

import UIKit
import RealmSwift
import EasyPeasy

class LyricsViewController: UIViewController {
    
    var songTitle = ""
    var songLyrics = ""
    var isFavorite = false
    let realm = try! Realm()
    
    private lazy var scrollView : UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.bounces = false
        scrollV.showsHorizontalScrollIndicator = false
        scrollV.showsVerticalScrollIndicator = false
        scrollV.isScrollEnabled = true
        return scrollV
    }()
    
    private lazy var lyricsLabel : UILabel = {
        let lyricsL = UILabel()
        lyricsL.text = ""
        lyricsL.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold)
        lyricsL.font = UIFont(name: "Gill Sans", size: 14)
        lyricsL.numberOfLines = 0
        return lyricsL
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        setupViews()
        setupConstraints()
        setBackground()
        super.viewDidLoad()
        self.title = "Shyrqa"

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "fN24"), style: .plain, target: self, action: #selector(LyricsViewController.addToFavorites(_:)))
        let result = realm.objects(FavoriteSongs.self).filter("favoriteSongTitle == '\(songTitle)'")
        if( result.count != 0) {
            isFavorite = true
            navigationItem.rightBarButtonItem?.image = UIImage(named: "f24")
        }
        titleLabel.text = songTitle
        lyricsLabel.text = songLyrics
        scrollView.contentSize = CGSize(width:self.view.frame.size.width, height: lyricsLabel.frame.height)
    }
    
    func setBackground(){
        let backgroundImageView = UIImageView(image: UIImage(named: "bg4"))
        backgroundImageView.frame = view.frame
        backgroundImageView.alpha = 0.15
        backgroundImageView.contentMode = .scaleAspectFit
        view.addSubview(backgroundImageView)
        view.sendSubview(toBack: backgroundImageView)
    }
    
    @IBAction func backButton(_ sender: Any) {
//        navigationController?.dismiss(animated: true)
        navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: - views
    func setupViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(lyricsLabel)
    }
    
    //MARK: - EasyPeasy
    func setupConstraints(){
        scrollView <- [
        Top(8).to(titleLabel),
        Left(0),
        Right(0),
        Bottom(0)
        ]
        lyricsLabel <- [
        Top(0),
        Bottom(0),
        Right(5),
        Left(30)
        ]
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }

    func addToFavorites(_ sender: Any) {
        if isFavorite{
            navigationItem.rightBarButtonItem?.image = UIImage(named: "fN24")
            do {
                let songToDelete = realm.objects(FavoriteSongs.self).filter("favoriteSongTitle == '\(songTitle)'")
                try realm.write {
                    realm.delete(songToDelete)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(named: "f24")
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
        isFavorite = !isFavorite
    }
    
}
