 //
//  FavoriteSongsViewController.swift
//  Shyrqa
//
//  Created by Алпамыс on 24.07.17.
//  Copyright © 2017 Алпамыс. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteSongsViewController: UIViewController {

    let realm = try! Realm()
    var myFavoriteSongs: Results<FavoriteSongs>?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shyrqa"
//        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.clear
        getFavoriteSongs()
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    func getFavoriteSongs(){
        myFavoriteSongs = realm.objects(FavoriteSongs.self).sorted(byKeyPath: "favoriteSongTitle", ascending: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lyricsSegue" {
            if let indexPath = tableView.indexPathForSelectedRow{
//                let lyricsNC = segue.destination as! UINavigationController
//                let lyricsVC = lyricsNC.topViewController as! LyricsViewController
                let lyricsVC = segue.destination as! LyricsViewController
                lyricsVC.songTitle = myFavoriteSongs![indexPath.row].favoriteSongTitle
                lyricsVC.songLyrics = myFavoriteSongs![indexPath.row].favoriteSongLyrics
            }
        }
    }

}

extension FavoriteSongsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (myFavoriteSongs?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! FavoriteSongTableViewCell
        cell.layer.backgroundColor = UIColor.clear.cgColor
        var songAuthor = ""
        var songName = ""
        var separator = ""
        if (myFavoriteSongs?[indexPath.row].favoriteSongTitle.contains(" - "))! {
            separator = " - "
        } else if (myFavoriteSongs?[indexPath.row].favoriteSongTitle.contains(" — "))! {
            separator = " — "
        } else if (myFavoriteSongs?[indexPath.row].favoriteSongTitle.contains("-"))! {
            separator = "-"
        } else if (myFavoriteSongs?[indexPath.row].favoriteSongTitle.contains(" – "))! {
            separator = " – "
        }
        let favoritesArr = myFavoriteSongs?[indexPath.row].favoriteSongTitle.components(separatedBy: separator)
        if (favoritesArr?.count)! > 1 {
            songAuthor = (favoritesArr?[0])!
            songName = (favoritesArr?[1])!
        } else {
            songAuthor = ""
            songName = (myFavoriteSongs?[indexPath.row].favoriteSongTitle)!
        }
        if (myFavoriteSongs?[indexPath.row].favoriteSongTitle.contains("А — Студио — Я Просто Люблю Ее "))! {
            songAuthor = "А — Студио"
            songName = "Я Просто Люблю Ее"
        } else if (myFavoriteSongs?[indexPath.row].favoriteSongTitle.contains("На — на — Бозжорға"))! {
            songAuthor = "На — на"
            songName = "Бозжорға"
        } else if (myFavoriteSongs?[indexPath.row].favoriteSongTitle.contains("Ақ-Қуан"))!{
            songAuthor = "Ақ-Қуан"
            songName = "Көгершінім"
        } else if (myFavoriteSongs?[indexPath.row].favoriteSongTitle.contains("Бір досың керек екен"))!{
            songAuthor = "Айқын"
            songName = "Бір досың керек екен"
        } else if (myFavoriteSongs?[indexPath.row].favoriteSongTitle.contains("Дос — Мұқасан — Алматы Түні "))!{
            songAuthor = "Дос — Мұқасан"
            songName = "Алматы Түні "
        } else if (myFavoriteSongs?[indexPath.row].favoriteSongTitle.contains("Жанарым — ай "))!{
            songAuthor = ""
            songName = "Жанарым — ай"
        }
        cell.favoriteSongAuthorLabel.text = songAuthor
        cell.favoriteSongNameLabel.text = songName
        if (songAuthor.contains("Айқын") || songAuthor.contains("Айкын")) && !songAuthor.contains("Шакеев") {
            cell.songImageView.image = UIImage(named: "aikyn")
        } else if songAuthor.contains("Абай") && !songAuthor.contains("Бегей"){
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

extension FavoriteSongsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "lyricsSegue", sender: indexPath.section)
    }
}
