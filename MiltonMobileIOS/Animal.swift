//
//  Animal.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit

@objc
class Animal {
    
    let title: String
    let creator: String
    let image: UIImage?
 
    init(title: String, creator: String, image: UIImage?) {
        self.title = title
        self.creator = creator
        self.image = image
    }
    
    class func allCats() -> Array<Animal> {
        return [ Animal(title: "FLIK", creator: "", image: UIImage(named: "1329_logo.jpg")),
                 Animal(title: "SAA", creator: "", image: UIImage(named: "1329_logo.jpg")),
                 Animal(title: "Mailbox", creator: "", image: UIImage(named: "1329_logo.jpg")),
                 Animal(title: "Settings", creator: "", image: UIImage(named: "1329_logo.jpg"))]
    }
}