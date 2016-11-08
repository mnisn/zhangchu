//
//  RecipeService.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/11/3.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class RecipeService: NSObject {

    class func handelEvents(url: String, onViewController vc: UIViewController)
    {
        if url.hasPrefix("app://food_course_series")
        {
            let array = url.componentsSeparatedByString("#")
            if array.count > 1
            {
                let courseid = array[1]
                FoodCourseService.handelFoodCourse(courseid, onViewController: vc)
            }
        }
        else if url.hasPrefix("http://video.szzhangchu.com")
        {
            let array = url.componentsSeparatedByString("#")
            VideoService.playVideo(array.first, onViewController: vc)
        }
    }
}
