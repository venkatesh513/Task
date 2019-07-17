//
//  FirebaseDataManager.swift
//  Task
//
//  Created by Venkatesh Bathina on 16/07/19.
//  Copyright © 2019 Venkatesh Bathina. All rights reserved.
//

import Foundation
import Firebase

public class FirebaseDataManager {
    
    static let shared = FirebaseDataManager()
    
    var homeObserverRef: DatabaseReference = {
        return Database.database().reference().child("Names")
    }()
    
    func getNames(key:String,data:[Names], _ completion: @escaping((_ names: [Names]) -> Void), _ failure: @escaping((_ error: String) -> Void)) {
        var ref = self.homeObserverRef.queryOrderedByKey()
        if key != "" {
            ref = ref.queryStarting(atValue: key)
        }
        ref = ref.queryLimited(toFirst:20)
        print(ref)
        ref.observeSingleEvent(of: .value) { (dataSnapshot) in
            if dataSnapshot.value is NSNull {
                failure("No data")
            } else {
                print(dataSnapshot.children.allObjects)
                var names = [Names]()
                for object in dataSnapshot.children.allObjects as? [DataSnapshot] ?? [] {
                    if let name = object.value as? [String:AnyObject] {
                        if key != object.key {
                            names.append(Names.init(name))
                        }
                        
                    }
                }
                if names.count > 0 {
                    completion(names)
                } else {
                    failure("No data")
                }
            }
        }
    }
}
