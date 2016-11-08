//
//  FoodCourseDescCell.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/11/4.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class FoodCourseDescCell: UITableViewCell {
    
    var cellModel:FoodCourseDetailDataType?{
        didSet{
            if cellModel != nil
            {
                showData()
            }
            
        }
    }
    
    func showData()
    {
        titileLabel.text = cellModel?.course_name
        descLabel.text = cellModel?.course_subject
    }
    
    //计算cell的高度
    class func heightForDescCell(model:FoodCourseDetailDataType) ->CGFloat
    {
        let height:CGFloat = 5 + 20 + 5
        let subjectHeight = NSString(string: model.course_subject!).boundingRectWithSize(CGSizeMake(screenWidth, CGFloat.max), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(15)], context: nil).size.height
        return height + subjectHeight + 5 
    }
    
    @IBOutlet weak var titileLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
