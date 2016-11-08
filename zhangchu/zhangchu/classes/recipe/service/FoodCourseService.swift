//
//  FoodCourseService.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/11/3.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class FoodCourseService: NSObject {

    class func handelFoodCourse(id: String, onViewController vc: UIViewController)
    {
        let ctrl = FoodCourseController()
        ctrl.courseId = id
        
        vc.navigationController?.pushViewController(ctrl, animated: true)
    }
}
