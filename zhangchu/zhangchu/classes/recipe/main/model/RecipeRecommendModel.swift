//
//  RecipeRecommendModel.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/10/24.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecipeRecommendModel: NSObject {

    var code: NSNumber?
    var data: RecipeRecommendData?
    var msg: NSNumber?
    var timestamp: NSNumber?
    var version: String?
    
    //解析
    class func parseData(data:NSData) ->RecipeRecommendModel
    {
        let json = JSON(data:data)
        
        let model = RecipeRecommendModel()
        model.code = json["code"].number
        model.data = RecipeRecommendData.parseModel(json["data"])
        model.msg = json["msg"].number
        model.timestamp = json["timestamp"].number
        model.version = json["version"].string
        
        return model
    }
}

class RecipeRecommendData:NSObject
{
    var bannerArray: [RecipeRecommendBanner]?
    var widgetList: [RecipeRecommendWidgetList]?
    
    //解析
    class func parseModel(json:JSON) ->RecipeRecommendData
    {
        let model = RecipeRecommendData()
        
        //广告数据
        var tmpBannerArray = [RecipeRecommendBanner]()
        for (_,subjson):(String,JSON) in json["banner"]
        {
            let bannerModel = RecipeRecommendBanner.parseModel(subjson)
            tmpBannerArray.append(bannerModel)
        }
        model.bannerArray = tmpBannerArray
        
        //列表数据
        var tmpList = [RecipeRecommendWidgetList]()
        for (_,subjson):(String,JSON) in json["widgetList"]
        {
            let widgetModel = RecipeRecommendWidgetList.parseModel(subjson)
            tmpList.append(widgetModel)
        }
        model.widgetList = tmpList
        
        return model
    }
}

class RecipeRecommendBanner:NSObject
{
    var banner_id: NSNumber?
    var banner_link: String?
    var banner_picture: String?
    
    var banner_title: String?
    var is_link: NSNumber?
    var refer_key: NSNumber?
    
    var type_id: NSNumber?
    
    //解析
    class func parseModel(json:JSON) ->RecipeRecommendBanner
    {
        let model = RecipeRecommendBanner()
        
        model.banner_id = json["banner_id"].number
        model.banner_link = json["banner_link"].string
        model.banner_picture = json["banner_picture"].string
        
        model.banner_title = json["banner_title"].string
        model.is_link = json["is_link"].number
        model.refer_key = json["refer_key"].number
        
        model.type_id = json["type_id"].number
        
        return model
    }
}

class RecipeRecommendWidgetList:NSObject
{
    var desc:String?
    var title:String?
    var title_link:String?
    
    var widget_data:[RecipeRecommendWidgetData]?
    var widget_id:NSNumber?
    var widget_type:NSNumber?
    
    class func parseModel(json:JSON) ->RecipeRecommendWidgetList
    {
        let model = RecipeRecommendWidgetList()
        
        model.desc = json["desc"].string
        model.title = json["title"].string
        model.title_link = json["title_link"].string
        
        var dataArray = [RecipeRecommendWidgetData]()
        for (_,subjson):(String,JSON) in json["widget_data"]
        {
            let subModel = RecipeRecommendWidgetData.parseModel(subjson)
            dataArray.append(subModel)
        }
        model.widget_data = dataArray
        
        model.widget_id = json["widget_id"].number
        model.widget_type = json["widget_type"].number
        
        return model
    
    }
}

class RecipeRecommendWidgetData:NSObject
{
    var id:NSNumber?
    var type:String?
    var content:String?
    var link:String?
    
    class func parseModel(json:JSON) ->RecipeRecommendWidgetData
    {
        let model = RecipeRecommendWidgetData()
        
        model.id = json["id"].number
        model.type = json["type"].string
        model.content = json["content"].string
        model.link = json["link"].string
        
        return model
    }
}










