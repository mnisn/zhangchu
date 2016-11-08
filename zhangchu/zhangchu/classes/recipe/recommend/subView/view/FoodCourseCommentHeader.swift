//
//  FoodCourseCommentHeader.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/11/4.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class FoodCourseCommentHeader: UIView {

    @IBOutlet weak var label: UILabel!
    
    func config(num:String)
    {
        label.text = "共\(num)条评论"
    }
    
    @IBAction func btnClick(sender: UIButton) {
    }

}
