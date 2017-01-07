//
//  modelClass.swift
//  iOSDeveloperTest
//
//  Created by Ashutosh Kumar Sai on 07/01/17.
//  Copyright © 2017 Ashish Rajendra Kumar Sai. All rights reserved.
//

import Foundation

class model
{
     var myArr = [AnyObject]()


 class func sharedInstance() -> model {
    struct Singleton {
        static var sharedInstance = model()
    }
    return Singleton.sharedInstance
}
}
