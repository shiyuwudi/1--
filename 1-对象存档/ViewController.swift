//
//  ViewController.swift
//  1-对象存档
//
//  Created by apple2 on 16/1/4.
//  Copyright © 2016年 shiyuwudi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var one_piece:Anime?
    let path = NSHomeDirectory() + "/Documents/animations"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        archive()
//        resume()
    }
    
    func archive(){
        one_piece = Anime.init(name: "one piece", chapters: 640, lastUpdate: NSDate.init(), comment: ["shiyu":"good fighting anime!"])
        let dragonBall = Anime.init(name: "Dragon-Balls", chapters: 1000, lastUpdate: NSDate(), comment: ["young shiyu":"too expensive to rent DVD"])
//        let animes = [one_piece, dragonBall]
        
        print(NSHomeDirectory())
        assert(dragonBall != nil)
        NSKeyedArchiver.archiveRootObject(dragonBall!, toFile: path)
    }
    
    func resume(){
        let maybe_anime = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? Anime
        if let anime = maybe_anime{
            print(anime)
        }else{
            print("no anime archived!")
        }
    }
}

class Anime:NSObject,NSCoding {
    
    var name:NSString?
    var chapters:NSInteger = 0
    var lastUpdate:NSDate?
    var comment:NSDictionary?
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeInteger(chapters, forKey: "chapters")
        aCoder.encodeObject(lastUpdate, forKey: "lastUpdate")
        aCoder.encodeObject(comment, forKey: "comment")
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as? NSString
        self.chapters = aDecoder.decodeIntegerForKey("chapters")
        self.lastUpdate = aDecoder.decodeObjectForKey("lastUpdate") as? NSDate
        self.comment = aDecoder.decodeObjectForKey("comment") as? NSDictionary
    }
    
    @objc override init(){
        
    }
    
    @objc init?(name:String, chapters:Int, lastUpdate:NSDate, comment:[String:String]){
        self.name = name
        self.chapters = chapters
        self.lastUpdate = lastUpdate
        self.comment = comment
    }
}