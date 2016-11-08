//
//  RecipIngredientsView.swift
//  zhangchu
//
//  Created by 苏宁 on 2016/11/1.
//  Copyright © 2016年 suning. All rights reserved.
//

import UIKit

class RecipIngredientsView: UIView {

    var clickClosure:RecipClickClosure?
    
    //数据
    var model:RecipIngredientsModel?{
        didSet{
            //set方法调用之后会调用这里的方法
            if model != nil
            {
                tableView?.reloadData()
            }
        }
    }
    //
    private var tableView :UITableView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        
        addSubview(tableView!)
        
        tableView?.snp_makeConstraints(closure: {
            [weak self](make) in
            make.edges.equalTo(self!)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension RecipIngredientsView:UITableViewDataSource,UITableViewDelegate
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if model?.data?.data?.count > 0
        {
            row = (model?.data?.data?.count)!
        }
        return row
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let tmpModel = model!.data?.data![indexPath.row]
        
        return RecipIngredientsCell.heightForCellWithModel(tmpModel!)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellID = "recipIngredientsCellID"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? RecipIngredientsCell
        if cell == nil
        {
            cell = RecipIngredientsCell(style: .Default, reuseIdentifier: cellID)
        }
        cell!.cellModel = model?.data?.data![indexPath.row]
        
        //
        cell?.clickClosure = clickClosure
        cell?.selectionStyle = .None
        
        return cell!
        
//        return UITableViewCell()
    }
}