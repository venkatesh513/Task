//
//  Names.swift
//  Task
//
//  Created by Venkatesh Bathina on 16/07/19.
//  Copyright © 2019 Venkatesh Bathina. All rights reserved.
//

import Foundation
class Names: NSObject {
    var name = String()
    var date = Int()
    var refKey = String()
    init(_ data: [String:AnyObject]) {
        self.name = data["name"] as? String ?? ""
        self.date = data["date"] as? Int ?? Int()
        self.refKey = data["refKey"] as? String ?? ""
    }
}
