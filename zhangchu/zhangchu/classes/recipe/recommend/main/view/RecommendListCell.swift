//
//  RecommendListCell.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/10/28.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class RecommendListCell: UITableViewCell {
    
    var clickClosure:RecipClickClosure?
    var listModel:RecipeRecommendWidgetList?{
        didSet{
            config((listModel?.title)!)
        }
    }
    
    @IBOutlet weak var listLabel: UILabel!
    
    func config(text:String)
    {
        listLabel.text = text
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        addGestureRecognizer(tap)
    }

    func tapClick()
    {
        if clickClosure != nil && listModel?.title_link != nil
        {
            clickClosure!((listModel?.title_link)!)
        }
    }
    
    //创建cell
    class func createListCell(tableView: UITableView, atIndexPath indexPath:NSIndexPath, listModel:RecipeRecommendWidgetList?) ->RecommendListCell
    {
        let cellID = "recommendListCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? RecommendListCell
        if cell == nil
        {
            cell = NSBundle.mainBundle().loadNibNamed("RecommendListCell", owner: nil, options: nil).last as? RecommendListCell
        }
        cell?.listModel = listModel!
        return cell!
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
