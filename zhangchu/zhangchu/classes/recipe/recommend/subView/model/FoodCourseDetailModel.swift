//
//  FoodCourseDetailModel.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/11/3.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit
import SwiftyJSON

class FoodCourseDetailModel: NSObject {

    var code:String?
    var msg:String?
    var version:String?
    var timestamp:NSNumber?
    var data:FoodCourseDetailData?
    
    class func parseData(data:NSData) ->FoodCourseDetailModel
    {
        let json = JSON(data: data)
        let model = FoodCourseDetailModel()
        
        model.code = json["code"].string
        model.data = FoodCourseDetailData.parseData(json["data"])
        model.msg = json["msg"].string
        model.timestamp = json["timestamp"].number
        model.version = json["version"].string
        
        return model
    }
}


class FoodCourseDetailData:NSObject
{
    var series_id:String?
    var series_name:String?
    var series_title:String?
    var create_time:String?
    var last_update:String?
    
    var order_no:String?
    var tag:String?
    var episode:NSNumber?
    var series_image:String?
    var share_title:String?
    
    var share_description:String?
    var share_image:String?
    var album:String?
    var album_logo:String?
    var relate_activity:String?
    
    var play:NSNumber?
    var share_url:String?
    
    var data:[FoodCourseDetailDataType]?
    
    class func parseData(json:JSON) ->FoodCourseDetailData
    {
        let model = FoodCourseDetailData()
        
        var array = [FoodCourseDetailDataType]()
        for (_,subJson) in json["data"]
        {
            let seriaModel = FoodCourseDetailDataType.parse(subJson)
            array.append(seriaModel)
        }
        model.data = array
        
        model.series_id = json["series_id"].string
        model.series_name = json["series_name"].string
        model.series_title = json["series_title"].string
        model.create_time = json["create_time"].string
        model.last_update = json["last_update"].string
        
        model.order_no = json["order_no"].string
        model.tag = json["tag"].string
        model.episode = json["episode"].number
        model.series_image = json["series_image"].string
        model.share_title = json["share_title"].string
        
        model.share_description = json["share_description"].string
        model.share_image = json["share_image"].string
        model.album = json["album"].string
        model.album_logo = json["album_logo"].string
        model.relate_activity = json["relate_activity"].string
        
        model.play = json["play"].number
        model.share_url = json["share_url"].string
        
        return model
    }
}

class FoodCourseDetailDataType:NSObject
{
    var course_id:NSNumber?
    var course_video:String?
    var episode:NSNumber?
    var course_name:String?
    var course_subject:String?
    
    var course_image:String?
    var ischarge:String?
    var price:String?
    var video_watchcount:NSNumber?
    var course_introduce:String?
    
    var is_collect:NSNumber?
    var is_like:NSNumber?
    var play:String?
    var share_url:String?
    
    class func parse(json:JSON) ->FoodCourseDetailDataType
    {
        let model = FoodCourseDetailDataType()
        
        model.course_id = json["course_id"].number
        model.course_video = json["course_video"].string
        model.episode = json["episode"].number
        model.course_name = json["course_name"].string
        model.course_subject = json["course_subject"].string
        
        model.course_image = json["course_image"].string
        model.ischarge = json["ischarge"].string
        model.price = json["price"].string
        model.video_watchcount = json["video_watchcount"].number
        model.course_introduce = json["course_introduce"].string
        
        model.is_collect = json["is_collect"].number
        model.is_like = json["is_like"].number
        model.play = json["play"].string
        model.share_url = json["share_url"].string
        
        return model
    }
}











