//
//  Downloader.swift
//  Shyrqa
//
//  Created by Алпамыс on 21.07.17.
//  Copyright © 2017 Алпамыс. All rights reserved.
//

import UIKit
import RealmSwift

class Downloader {
    
    static func getText(){
        var x = 4051
        
        DispatchQueue.global().async {
            var sucess = 0
            var counter = x
            while x < 4201 {
                let url = URL(string: "http://fastparser.herokuapp.com/parse?site=http://kazchords.kz/?p=\(x)&css=.post-inner")
                
                let session = URLSession(configuration: URLSessionConfiguration.default)
                print("\(x-50)-\(x)")
                session.dataTask(with: url!) { (data, _, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
                        let elements = json["elements"] as! [[String: Any]]
                        counter += 1
                        print(counter)
                        if elements.count != 0 {
                            sucess += 1
                            print("\(sucess) >>>>>>>>")
                        }
                        for element in elements {
                            if let text = element["text"] as? String  {
                                do {
                                    let realm = try Realm()
                                    try realm.write {
                                        let db = ParsedText()
                                        db.text = text
                                        realm.add(db)
                                    }
                                } catch let error {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    } catch let error {
                        print(error.localizedDescription)
                    }
                    }.resume()
                x += 1
            }
        }
    }
    
}

