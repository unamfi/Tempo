//
//  FoldingTable.swift
//  Angel Hack
//
//  Created by Julio César Guzman on 5/7/16.
//  Copyright © 2016 Julio Guzman. All rights reserved.
//

import Foundation
import FoldingCell

let kFoldingCellReuseIdentifier = "FoldingCell"

class DemoCell: FoldingCell {
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
}


class MainTableViewController: UITableViewController {
    
    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 488
    let kRowsCount = 10
    var cellHeights = [CGFloat]()

    override func viewDidLoad() {
        super.viewDidLoad()
        createCellHeightsArray()
    }
    
    // MARK: configure
    
    func createCellHeightsArray() {
        for _ in 0...kRowsCount {
            cellHeights.append(kCloseCellHeight)
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kRowsCount
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell is DemoCell {
            let demoCell = cell as! DemoCell
            let cellShouldBeClosed = cellHeights[indexPath.row] == kCloseCellHeight
            if cellShouldBeClosed {
                demoCell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                demoCell.selectedAnimation(true, animated: false, completion: nil)
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kFoldingCellReuseIdentifier, forIndexPath: indexPath)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    // MARK: Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCell
        if cell.isAnimating() {
            return
        }
        var duration = 0.0
        let cellIsOpen = cellHeights[indexPath.row] == kCloseCellHeight
        if cellIsOpen {
            // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            // close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
}

