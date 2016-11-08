//
//  FoodCourseCommentModel.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/11/4.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit
import SwiftyJSON

class FoodCourseCommentModel: NSObject {
    
    var code:String?
    var msg:String?
    var version:String?
    var timestamp:NSNumber?
    var data:FoodCourseCommentData?
    
    class func parseData(data:NSData) ->FoodCourseCommentModel
    {
        let json = JSON(data: data)
        let model = FoodCourseCommentModel()
        
        model.code = json["code"].string
        model.data = FoodCourseCommentData.parseData(json["data"])
        model.msg = json["msg"].string
        model.timestamp = json["timestamp"].number
        model.version = json["version"].string
        
        return model
    }

}

class FoodCourseCommentData:NSObject
{
    var page:String?
    var size:String?
    var total:String?
    var count:String?
    var data:[FoodCourseCommentDataData]?
    
    class func parseData(json:JSON) ->FoodCourseCommentData
    {
        let model = FoodCourseCommentData()
        
        var array = [FoodCourseCommentDataData]()
        for (_,subJson) in json["data"]
        {
            let subModel = FoodCourseCommentDataData.parse(subJson)
            array.append(subModel)
        }
        model.data = array
        
        model.page = json["page"].string
        model.size = json["size"].string
        model.total = json["total"].string
        model.count = json["count"].string

        return model
    }
}

class FoodCourseCommentDataData:NSObject
{
    var id:String?
    var user_id:String?
    var type:String?
    var relate_id:String?
    var content:String?
    
    var create_time:String?
    var parent_id:String?
    var parents:[FoodCourseCommentDataData]?
    var nick:String?
    var head_img:String?
    
    var istalent:NSNumber?
    
    class func parse(json:JSON) ->FoodCourseCommentDataData
    {
        let model = FoodCourseCommentDataData()
        
        var array = [FoodCourseCommentDataData]()
        for (_,subJson) in json["data"]
        {
            let subModel = FoodCourseCommentDataData.parse(subJson)
            array.append(subModel)
        }
        model.parents = array
        
        model.id = json["id"].string
        model.user_id = json["user_id"].string
        model.type = json["type"].string
        model.relate_id = json["relate_id"].string
        model.content = json["content"].string
        
        model.create_time = json["create_time"].string
        model.parent_id = json["parent_id"].string
        model.nick = json["nick"].string
        model.head_img = json["head_img"].string
        model.istalent = json["istalent"].number
        
        return model
    }
    
}









