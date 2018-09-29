//
//  Post.swift
//  CSChallenge
//
//  Created by Ethan D'Mello on 2018-09-28.
//  Copyright © 2018 Ethan D'Mello. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Post {
    
    var title: String
    
    init?(json:JSON){
        guard let title = json["data"]["title"].string else{
            return nil
        }
    self.title = title
    }
}
