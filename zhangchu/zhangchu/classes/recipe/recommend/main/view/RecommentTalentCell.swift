//
//  RecommentTalentCell.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/10/31.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class RecommentTalentCell: UITableViewCell {
    
    var cellArray:[RecipeRecommendWidgetData]?
    
    var clickClosure:RecipClickClosure?{
        didSet{
            shorwData()
        }
    }
    
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var fansLabel: UILabel!
    
    
    
    func shorwData()
    {
        //
        if cellArray?.count > 0
        {
            let imgData = cellArray![0]
            if imgData.type == "image"
            {
                imgView.kf_setImageWithURL(NSURL(string: imgData.content!), placeholderImage: UIImage(named: "sdefaultImage"))
            }
        }
        //
        if cellArray?.count > 1
        {
            let nameData = cellArray![1]
            if nameData.type == "text"
            {
                nameLabel.text = nameData.content
            }
        }
        //
        if cellArray?.count > 2
        {
            let descData = cellArray![2]
            if descData.type == "text"
            {
                descLabel.text = descData.content
            }
        }
        //
        if cellArray?.count > 3
        {
            let fansData = cellArray![3]
            if fansData.type == "text"
            {
                fansLabel.text = fansData.content
            }
        }
        //
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        addGestureRecognizer(tap)
    }
    
    //创建cell
    class func createTalentCell(tableView: UITableView, atIndexPath indexPath:NSIndexPath, cellArray:[RecipeRecommendWidgetData]?) ->RecommentTalentCell
    {
        let cellID = "recommentTalentCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? RecommentTalentCell
        if cell == nil
        {
            cell = NSBundle.mainBundle().loadNibNamed("RecommentTalentCell", owner: nil, options: nil).last as? RecommentTalentCell
        }
        cell?.cellArray = cellArray!
        return cell!
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgView.layer.cornerRadius = 35
        imgView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
