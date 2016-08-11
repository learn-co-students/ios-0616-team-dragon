//
//  ResultTableView.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/11/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class ResultTableView: UITableView {
    
//    override func dequeueReusableCellWithIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        <#code#>
//    }
    
    override func indexPathForCell(cell: UITableViewCell) -> NSIndexPath? {
        <#code#>
    }
    
    override func dequeueReusableCellWithIdentifier(identifier: String) -> UITableViewCell? {
        let cell = UITableViewCell.init(style:UITableViewCellStyle.Default, reuseIdentifier: ResultCell.reuseIdentifier)
        return cell
    }
    
    override func cellForRowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell? {
        code
    }
    
}
