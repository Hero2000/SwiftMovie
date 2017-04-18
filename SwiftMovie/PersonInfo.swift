//
//  PersonInfo.swift
//  SwiftMovie
//
//  Created by shawnfeng on 2017/4/18.
//  Copyright © 2017年 test.com. All rights reserved.
//

import Foundation
import UIKit
import HandyJSON
class Cook: HandyJSON {
    var name:String?;
    var age:Int?;//名称
    var phones:Double?;
    required init(){}
    
}

class BasicTypes: HandyJSON {
    var int: Int = 2
    var arr: Array<Int> = []
    var dic: Dictionary<String, Any> = [:]
    var doubleOptional: Double?

    var stringImplicitlyUnwrapped: String!
    
    required init() {}
}

class JsonModel: HandyJSON {
    var int: Int = 2
    var origin: String?
    var headers:Dictionary<String, Any> = [:]
    var url: String?
    
    required init() {}
}

//class phones: HandyJSON {
//    var id:Int?;
//    var name:String?;//名称
//    
//    required init(){}
//    
//}
//
