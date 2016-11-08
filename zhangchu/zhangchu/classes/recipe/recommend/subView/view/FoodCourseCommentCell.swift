//
//  FoodCourseCommentCell.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/11/4.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class FoodCourseCommentCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func btnClick(sender: UIButton) {
    }
    
    var model:FoodCourseCommentDataData? {
        didSet{
            if model != nil
            {
                //
                imgView.kf_setImageWithURL(NSURL(string: (model?.head_img)!), placeholderImage: UIImage(named: "sdefaultImage"))
                //
                nameLabel.text = model?.nick
                //
                commentLabel.text = model?.content
                //
                timeLabel.text = model?.create_time
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgView.layer.cornerRadius = 30
        imgView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
