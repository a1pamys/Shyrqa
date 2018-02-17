//
//  ViewController.swift
//  Shyrqa
//
//  Created by Алпамыс on 16.07.17.
//  Copyright © 2017 Алпамыс. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    var searching = false
    let realm = try! Realm()
    var mySongs: [Song]?
    var searchedSongs: [Song]?
    var matrixOfSongs = [(String,[Song])]()
    var indeces: [String] = []
    let searchController = UISearchController(searchResultsController: nil)
    var favoriteBarButton: UIBarButtonItem?
    var searchButton: UIBarButtonItem?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
//        let dateFormatter : DateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let date = Date()
//        let sinceDate: Date =
//        let dateString = dateFormatter.string(from: date)
//        let interval = date.timeIntervalSince(date)
//        print(date)
//        print(dateString)
//        print(interval)
//        
        self.title = "Shyrqa"
        //        Downloader.getText()
        //        mySongs = Formatter.removeTrash()
        //        removeTrashSongs(songs: mySongs!)
        tableView.separatorColor = UIColor.clear
        setSearchController()
        mySongs = FilteredSongs.getSongs()
        matrixOfSongs = Formatter.connectLetterToSong(Songs: mySongs!, indeces: &indeces)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func setSearchController(){
        favoriteBarButton = UIBarButtonItem(title: "Избранное", style: .plain, target: self, action: #selector(ViewController.favoriteButtonPressed(_:)))
        searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBarButtonPressed(_:)))
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.setValue("Отмена", forKey: "_cancelButtonText")
        searchController.searchBar.isHidden = true
        searchController.searchBar.placeholder = "Найти"
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationItem.rightBarButtonItem = favoriteBarButton
        navigationItem.leftBarButtonItem = searchButton
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15)], for: .normal)
    }
    
    func removeTrashSongs(songs: [Song]){
        for song in songs {
            do {
                try realm.write {
                    let db = RealmSongs()
                    db.songTitle = song.title!
                    db.songLyrics = song.lyrics!
                    realm.add(db)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func searchBarButtonPressed(_ sender: Any) {
        searchController.searchBar.isHidden = !searchController.searchBar.isHidden
        navigationItem.titleView = searchController.searchBar
        navigationItem.rightBarButtonItem = nil
        navigationItem.leftBarButtonItem = nil
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: 0, height: 30)
        UIView.animate(withDuration: 0.2) {
            self.searchController.searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        }
    }
    
    func favoriteButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "mainToFav", sender: nil)
    }
    
    func hideSearchbar(){
        searchController.searchBar.isHidden = true
        searchController.searchBar.text! = ""
        self.searchController.searchBar.frame = CGRect(x: 0, y: 0, width: 0, height: 30)
        navigationItem.leftBarButtonItem = searchButton
        navigationItem.rightBarButtonItem = favoriteBarButton
        navigationItem.titleView = nil
        navigationItem.title = "Shyrqa"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lyricsSegue" {
            if let indexPath = tableView.indexPathForSelectedRow{
                //                let lyricsNC = segue.destination as! UINavigationController
                //                let lyricsVC = lyricsNC.topViewController as! LyricsViewController
                let lyricsVC = segue.destination as! LyricsViewController
                if !searching {
                    lyricsVC.songTitle = matrixOfSongs[indexPath.section].1[indexPath.row].title!
                    lyricsVC.songLyrics = matrixOfSongs[indexPath.section].1[indexPath.row].lyrics!
                } else {
                    lyricsVC.songTitle = (searchedSongs?[indexPath.row].title!)!
                    lyricsVC.songLyrics = (searchedSongs?[indexPath.row].lyrics!)!
                }
            }
        }
        hideSearchbar()
    }
}

extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searching {
            return 1
        }
        return indeces.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return (searchedSongs?.count)!
        }
        return matrixOfSongs[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! TableViewCell
        cell.selectionStyle = .none
        cell.layer.backgroundColor = UIColor.clear.cgColor
        var songAuthor = ""
        var songName = ""
        var songTitle = ""
        var separator = ""
        
        if searching {
            if (searchedSongs?[indexPath.row].title?.contains(" - "))! {
                separator = " - "
            } else if (searchedSongs?[indexPath.row].title?.contains(" — "))! {
                separator = " — "
            } else if (searchedSongs?[indexPath.row].title?.contains("-"))! {
                separator = "-"
            } else if (searchedSongs?[indexPath.row].title?.contains(" – "))! {
                separator = " – "
            }
            let filteredArr = searchedSongs?[indexPath.row].title?.components(separatedBy: separator)
            if (filteredArr?.count)! > 1 {
                songAuthor = (filteredArr?[0])!
                songName = (filteredArr?[1])!
            } else {
                songAuthor = ""
                songName = (searchedSongs?[indexPath.row].title)!
            }
            if (searchedSongs?[indexPath.row].title?.contains("А — Студио — Я Просто Люблю Ее "))! {
                songAuthor = "А — Студио"
                songName = "Я Просто Люблю Ее"
            } else if (searchedSongs?[indexPath.row].title?.contains("На — на — Бозжорға"))! {
                songAuthor = "На — на"
                songName = "Бозжорға"
            } else if (searchedSongs?[indexPath.row].title?.contains("Ақ-Қуан"))!{
                songAuthor = "Ақ-Қуан"
                songName = "Көгершінім"
            } else if (searchedSongs?[indexPath.row].title?.contains("Бір досың керек екен"))!{
                songAuthor = "Айқын"
                songName = "Бір досың керек екен"
            } else if (searchedSongs?[indexPath.row].title?.contains("Дос — Мұқасан — Алматы Түні "))!{
                songAuthor = "Дос — Мұқасан"
                songName = "Алматы Түні "
            } else if (searchedSongs?[indexPath.row].title?.contains("Жанарым — ай "))!{
                songAuthor = ""
                songName = "Жанарым — ай"
            }
            songTitle = (searchedSongs?[indexPath.row].title)!
            cell.songTitle = (searchedSongs?[indexPath.row].title)!
            cell.songLyrics = (searchedSongs?[indexPath.row].lyrics)!
            cell.songNameLabel.text = songName
            cell.songAuthorLabel.text = songAuthor
        } else {
            if (matrixOfSongs[indexPath.section].1[indexPath.row].title?.contains(" - "))! {
                separator = " - "
            } else if (matrixOfSongs[indexPath.section].1[indexPath.row].title?.contains(" — "))! {
                separator = " — "
            } else if (matrixOfSongs[indexPath.section].1[indexPath.row].title?.contains("-"))! {
                separator = "-"
            } else if (matrixOfSongs[indexPath.section].1[indexPath.row].title?.contains(" – "))! {
                separator = " – "
            }
            let matrixArr = matrixOfSongs[indexPath.section].1[indexPath.row].title?.components(separatedBy: separator)
            if (matrixArr?.count)! > 1 {
                songAuthor = (matrixArr?[0])!
                songName = (matrixArr?[1])!
            } else {
                songAuthor = ""
                songName = (matrixOfSongs[indexPath.section].1[indexPath.row].title)!
            }
            if (matrixOfSongs[indexPath.section].1[indexPath.row].title?.contains("А — Студио — Я Просто Люблю Ее "))! {
                songAuthor = "А — Студио"
                songName = "Я Просто Люблю Ее"
            } else if (matrixOfSongs[indexPath.section].1[indexPath.row].title?.contains("На — на — Бозжорға"))! {
                songAuthor = "На — на"
                songName = "Бозжорға"
            } else if (matrixOfSongs[indexPath.section].1[indexPath.row].title?.contains("Ақ-Қуан"))!{
                songAuthor = "Ақ-Қуан"
                songName = "Көгершінім"
            } else if (matrixOfSongs[indexPath.section].1[indexPath.row].title?.contains("Бір досың керек екен"))!{
                songAuthor = "Айқын"
                songName = "Бір досың керек екен"
            } else if (matrixOfSongs[indexPath.section].1[indexPath.row].title?.contains("Дос — Мұқасан — Алматы Түні "))!{
                songAuthor = "Дос — Мұқасан"
                songName = "Алматы Түні "
            } else if (matrixOfSongs[indexPath.section].1[indexPath.row].title?.contains("Жанарым — ай "))!{
                songAuthor = ""
                songName = "Жанарым — ай"
            }
            songTitle = (matrixOfSongs[indexPath.section].1[indexPath.row].title)!
            cell.songTitle = (matrixOfSongs[indexPath.section].1[indexPath.row].title)!
            cell.songLyrics = (matrixOfSongs[indexPath.section].1[indexPath.row].lyrics)!
            cell.songNameLabel.text = songName
            cell.songAuthorLabel.text = songAuthor
        }
        let currentSong = realm.objects(FavoriteSongs.self).filter("favoriteSongTitle == '\(songTitle)'")
        if currentSong.count != 0 {
            cell.favoriteButton.setImage(UIImage(named: "f24"), for: .normal)
        } else {
            cell.favoriteButton.setImage(UIImage(named: "fN24"), for: .normal)
        }
        
        cell.songImageView.contentMode = .scaleAspectFit
        cell.songImageView.clipsToBounds = true
        
        if (songAuthor.contains("Айқын") || songAuthor.contains("Айкын")) && !songAuthor.contains("Шакеев") {
            cell.songImageView.image = UIImage(named: "aikyn")
        } else if songAuthor.contains("Абай") && !songAuthor.contains("Бегей") && !songTitle.contains("Аяла"){
            cell.songImageView.image = UIImage(named: "abai")
        } else if songAuthor.contains("101") {
            cell.songImageView.image = UIImage(named: "101")
        } else if songAuthor.contains("Давай") {
            cell.songImageView.image = UIImage(named: "All")
        } else if songAuthor.contains("Айдарбек") {
            cell.songImageView.image = UIImage(named: "Aidarbek")
        } else if songAuthor.contains("Азия") {
            cell.songImageView.image = UIImage(named: "aziya")
        } else if songAuthor.contains("Студио") {
            cell.songImageView.image = UIImage(named: "studio")
        } else if songAuthor.contains("Ажар") {
            cell.songImageView.image = UIImage(named: "azhar")
        } else if songAuthor.contains("АБК") {
            cell.songImageView.image = UIImage(named: "abk")
        } else if songAuthor.contains("Аламан") {
            cell.songImageView.image = UIImage(named: "alaman")
        } else if songAuthor.contains("Окапов") {
            cell.songImageView.image = UIImage(named: "ali")
        } else if songAuthor.contains("Алтынай") {
            cell.songImageView.image = UIImage(named: "altynai")
        } else if songAuthor.contains("Сыпабеков") {
            cell.songImageView.image = UIImage(named: "aman")
        } else if songAuthor.contains("Арай тобы") {
            cell.songImageView.image = UIImage(named: "arai")
        } else if songAuthor.contains("Арнау") {
            cell.songImageView.image = UIImage(named: "arnau")
        } else if songAuthor.contains("Пердешов") {
            cell.songImageView.image = UIImage(named: "asan")
        } else if songAuthor.contains("Жүнісбеков") {
            cell.songImageView.image = UIImage(named: "askar")
        } else if songAuthor.contains("Керімбекова") {
            cell.songImageView.image = UIImage(named: "akbota")
        } else if songAuthor.contains("Жеменей") {
            cell.songImageView.image = UIImage(named: "akylbek")
        } else if songAuthor == "Батыр" || songAuthor.contains("Батырхан") {
            cell.songImageView.image = UIImage(named: "batyr")
        } else if songAuthor.contains("Қорған") {
            cell.songImageView.image = UIImage(named: "korgan")
        } else if songAuthor.contains("Бүркіт") || songAuthor.contains("Беркут") {
            cell.songImageView.image = UIImage(named: "berkut")
        } else if songAuthor.contains("терек") {
            cell.songImageView.image = UIImage(named: "baiterek")
        } else if songAuthor.contains("Жанай") {
            cell.songImageView.image = UIImage(named: "gadil")
        } else if songAuthor.contains("Молданазар") {
            cell.songImageView.image = UIImage(named: "molda")
        } else if songAuthor.contains("Домино") {
            cell.songImageView.image = UIImage(named: "domino")
        } else if songAuthor.contains("Болат") {
            cell.songImageView.image = UIImage(named: "bolatov")
        } else if songAuthor.contains("Ернар") {
            cell.songImageView.image = UIImage(named: "aidarov")
        } else if songAuthor.contains("Нұр Мұқасан") || songAuthor.contains("Нұр-Мұқасан"){
            cell.songImageView.image = UIImage(named: "defaultPic")
        } else if songAuthor.contains("Достар") {
            cell.songImageView.image = UIImage(named: "dostar")
        } else if songAuthor.contains("Мұқасан") || songAuthor.contains("Досмұқасан") && !songAuthor.contains(("Нұр")) {
            cell.songImageView.image = UIImage(named: "mukasan")
        } else if songAuthor.contains("рмаш") {
            cell.songImageView.image = UIImage(named: "kurmaw")
        } else if songAuthor.contains("Қарақат") && !(songAuthor.contains("Болманов")){
            cell.songImageView.image = UIImage(named: "karakat")
        } else if songAuthor.contains("Каспий") {
            cell.songImageView.image = UIImage(named: "kaspii")
        } else if songAuthor.contains("Кайрат") || songAuthor.contains("Нұртас") {
            cell.songImageView.image = UIImage(named: "kairat")
        } else if songAuthor.contains("Заман") {
            cell.songImageView.image = UIImage(named: "zaman")
        } else if songAuthor.contains("Жексен") {
            cell.songImageView.image = UIImage(named: "zhuba")
        } else if songAuthor.contains("ттер") {
            cell.songImageView.image = UIImage(named: "zhigitter")
        } else if songAuthor.contains("Ауып") {
            cell.songImageView.image = UIImage(named: "zhiger")
        } else if songAuthor.contains("ржанов") {
            cell.songImageView.image = UIImage(named: "erkin")
        } else if songAuthor.contains("Үмбетов") {
            cell.songImageView.image = UIImage(named: "kanat")
        } else if songAuthor.contains("Түнтеков") {
            cell.songImageView.image = UIImage(named: "tuntekov")
        } else if songAuthor.contains("Ералиева") {
            cell.songImageView.image = UIImage(named: "yeraliyeva")
        } else if songAuthor.contains("Садуа") {
            cell.songImageView.image = UIImage(named: "sadvakasova")
        } else if songAuthor.contains("Исабек") && !songAuthor.contains("айрат") {
            cell.songImageView.image = UIImage(named: "makpal")
        } else if songAuthor.contains("Беспаев") {
            cell.songImageView.image = UIImage(named: "meirambek")
        } else if songAuthor.contains("Меломен") && (!songAuthor.contains("азиев") && !songAuthor.contains("Музарт")) {
            cell.songImageView.image = UIImage(named: "melomen")
        } else if songAuthor.contains("Музарт") && !songAuthor.contains("Меломен") {
            cell.songImageView.image = UIImage(named: "muzart")
        } else if songAuthor.contains("нарлан") {
            cell.songImageView.image = UIImage(named: "munarlan")
        } else if songAuthor.contains("Кермен") {
            cell.songImageView.image = UIImage(named: "kapkarawka")
        } else if songAuthor.contains("Әлімжан") {
            cell.songImageView.image = UIImage(named: "alimzhan")
        } else if songAuthor.contains("нербаев") {
            cell.songImageView.image = UIImage(named: "onerbayev")
        } else if songAuthor.contains("Батырқұлов") {
            cell.songImageView.image = UIImage(named: "batyrkulov")
        } else if songAuthor.contains("Орда") {
            cell.songImageView.image = UIImage(named: "orda")
        } else if songAuthor.contains("Понти") {
            cell.songImageView.image = UIImage(named: "ponti")
        } else if songAuthor.contains("Рахат") {
            cell.songImageView.image = UIImage(named: "rakhat")
        } else if songAuthor.contains("Ринго") {
            cell.songImageView.image = UIImage(named: "ringo")
        } else if songAuthor.contains("Ибрагимов") {
            cell.songImageView.image = UIImage(named: "serik")
        } else if songAuthor.contains("Майғазиев") && (!songAuthor.contains("Меломен") && !songAuthor.contains("Шамшынар")){
            cell.songImageView.image = UIImage(named: "saken")
        } else if songAuthor.contains("Досымов"){
            cell.songImageView.image = UIImage(named: "dosymov")
        } else if songAuthor.contains("Тоқтар"){
            cell.songImageView.image = UIImage(named: "toqtar")
        } else if songAuthor.contains("анбай") && !songAuthor.contains("Julik"){
            cell.songImageView.image = UIImage(named: "turganbai")
        } else if songAuthor.contains("Төреғали") {
            cell.songImageView.image = UIImage(named: "toregali")
        } else if songAuthor.contains("Шәмші"){
            cell.songImageView.image = UIImage(named: "shamshi")
        } else if songAuthor.contains("JCS"){
            cell.songImageView.image = UIImage(named: "jcs")
        } else if songAuthor.contains("Pascal"){
            cell.songImageView.image = UIImage(named: "pascal")
        } else {
            cell.songImageView.image = UIImage(named: "defaultPic")
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "lyricsSegue", sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! == "" {
            searching = false
            searchedSongs = mySongs
        } else {
            searching = true
            searchedSongs = mySongs?.filter({ ($0.title?.lowercased().contains(searchController.searchBar.text!.lowercased()))! })
        }
        self.tableView.reloadData()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearchbar()
    }
}

