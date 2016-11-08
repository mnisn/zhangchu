//
//  RecommentTopicCell.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/11/1.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class RecommentTopicCell: UITableViewCell {
    
    var cellArray:[RecipeRecommendWidgetData]?{
        didSet{
            showData()
        }
    }
    var clickClosure:RecipClickClosure?
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    func showData()
    {
        if cellArray?.count > 0
        {
            //
            if cellArray?.count > 0
            {
                let imgData = cellArray![0]
                if imgData.type == "image"
                {
                    imgView.kf_setImageWithURL(NSURL(string: (imgData.content)!), placeholderImage: UIImage(named: "sdefaultImage"))
                }
            }
            //
            if cellArray?.count > 1
            {
                let titleLabelData = cellArray![1]
                if titleLabelData.type == "text"
                {
                    titleLabel.text = titleLabelData.content
                }
            }
            //
            if cellArray?.count > 2
            {
                let descLabelData = cellArray![2]
                if descLabelData.type == "text"
                {
                    descLabel.text = descLabelData.content
                }
            }
            
        }
        
    }
    
    func tapClick()
    {
        if cellArray?.count > 0
        {
            let imgData = cellArray![0]
            if clickClosure != nil && imgData.link != nil
            {
                clickClosure!(imgData.link!)
            }
        }
    }
    
    //创建cell
    class func createTopicCell(tableView: UITableView, atIndexPath indexPath:NSIndexPath, cellArray:[RecipeRecommendWidgetData]?) ->RecommentTopicCell
    {
        let cellID = "recommentTopicCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? RecommentTopicCell
        if cell == nil
        {
            cell = NSBundle.mainBundle().loadNibNamed("RecommentTopicCell", owner: nil, options: nil).last as? RecommentTopicCell
        }
        cell?.cellArray = cellArray!
        return cell!
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        //
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        addGestureRecognizer(tap)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
