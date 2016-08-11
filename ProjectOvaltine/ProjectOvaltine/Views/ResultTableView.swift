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
//        // not implemented
//    }
    
//    override func indexPathForCell(cell: UITableViewCell) -> NSIndexPath? {
//        return indexPathForCell(cell)
//       //not implemented
//    }
    
    override func dequeueReusableCellWithIdentifier(identifier: String) -> UITableViewCell? {
        let resultCell = ResultCell()
        let cell = UITableViewCell.init(style:UITableViewCellStyle.Default, reuseIdentifier: resultCell.reuseIdentifier)
        return cell
    }
    
//    override func cellForRowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell? {
//        self.indexPathForCell(cell:UITableViewCell)
//        
//        //not implemented
//    }
    
}
