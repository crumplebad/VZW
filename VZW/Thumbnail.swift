 //
//  Thumbnail.swift
//  VZW
//
//  Created by Gaonkar, Jay  on 1/19/17.
//  Copyright © 2017 iJay. All rights reserved.
//

import UIKit
import Foundation

/**
*
*/
class Thumbnail: NSObject {

    var name: String
    var link: String
    
    init(dictionary aDictionary:[String:String]) {
        guard let name = aDictionary["name"] else {
            self.name = ""
            self.link = ""
            return
        }
        self.name = name
        guard let link = aDictionary["link"] else {
            self.link = ""
            return
        }
        self.link = link
    }
}
 
/**
*
*/
class ThumbnailViewModel: NSObject {
    private var thumbnail:Thumbnail
    var nameText: String {
        
        return thumbnail.name
    }
    var linkString: String {
        return thumbnail.link
    }
    
    init(thumbnail:Thumbnail) {
        self.thumbnail = thumbnail
    }
}
