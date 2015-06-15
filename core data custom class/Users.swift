//
//  Users.swift
//  core data custom class
//
//  Created by Aria Cundick on 6/15/15.
//  Copyright (c) 2015 Code on the Cawb. All rights reserved.
//

import UIKit
import CoreData

//objc(Users) allows objc sensitive  parts of xcode to detect this class by the name "Users"
@objc(Users)
class Users: NSManagedObject {
    @NSManaged var username:String
    @NSManaged var password:String
   
}
