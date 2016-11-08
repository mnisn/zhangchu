//
//  FoodCourseVideoCell.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/11/4.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class FoodCourseVideoCell: UITableViewCell {
    
    var playClosure:(String -> ())?
    
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
        imgView.kf_setImageWithURL(NSURL(string: (cellModel?.course_image)!), placeholderImage: UIImage(named: "sdefaultImage"))
        label.text = "\((cellModel?.video_watchcount!)!)次播放"
    }
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func btnClick(sender: UIButton)
    {
        if cellModel?.course_video != nil && playClosure != nil
        {
            playClosure!((cellModel?.course_video)!)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
