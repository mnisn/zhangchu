//
//  RecipIngredientsModel.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/11/2.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecipIngredientsModel: NSObject {
    
    var code:String?
    var data:RecipIngredientsData?
    var msg:String?
    var timestamp:NSNumber?
    var version:String?

    class func parseData(data:NSData) ->RecipIngredientsModel
    {
        let json = JSON(data: data)
        let model = RecipIngredientsModel()
        
        model.code = json["code"].string
        model.data = RecipIngredientsData.parseData(json["data"])
        model.msg = json["msg"].string
        model.timestamp = json["timestamp"].number
        model.version = json["version"].string
        
        return model
    }
}

class RecipIngredientsData:NSObject
{
    var id:NSNumber?
    var text:String?
    var name:String?
    var data:[RecipIngredientsType]?
    
    class func parseData(json:JSON) ->RecipIngredientsData
    {
        let model = RecipIngredientsData()
        
        var array = [RecipIngredientsType]()
        for (_,subJson) in json["data"]
        {
            let typeModel = RecipIngredientsType.parse(subJson)
            array.append(typeModel)
        }
        model.data = array
        model.id = json["id"].number
        model.text = json["text"].string
        model.name = json["name"].string
        
        return model
    }
}

class RecipIngredientsType:NSObject
{
    var data:[RecipIngredientsSubType]?
    var id:String?
    var text:String?
    var image:String?
    
    class func parse(json:JSON) ->RecipIngredientsType
    {
        let model = RecipIngredientsType()
        var array = [RecipIngredientsSubType]()
        for (_,subJson) in json["data"]
        {
            let typeModel = RecipIngredientsSubType.parse(subJson)
            array.append(typeModel)
        }
        
        model.data = array
        model.id = json["id"].string
        model.text = json["text"].string
        model.image = json["image"].string
        
        return model
    }
}

class RecipIngredientsSubType:NSObject
{
    var id:String?
    var text:String?
    var image:String?
    
    class func parse(json:JSON) ->RecipIngredientsSubType
    {
        let model = RecipIngredientsSubType()
        model.id = json["id"].string
        model.text = json["text"].string
        model.image = json["image"].string
        return model
    }
}





