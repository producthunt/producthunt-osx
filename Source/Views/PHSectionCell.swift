//
//  PHSectionCell.swift
//  ProductHunt
//
//  Created by Vlado on 3/16/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa

class PHSectionCell: NSTableCellView {

    class func view(_ tableView: NSTableView, owner: AnyObject?, subject: AnyObject?) -> NSView? {
        guard let section = subject as? String else {
            return nil
        }

        let view = tableView.makeView(withIdentifier: convertToNSUserInterfaceItemIdentifier("sectionCellIdentifier"), owner: owner) as! PHSectionCell
        view.textField?.stringValue = section
        return view
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        wantsLayer = true
        layer?.backgroundColor = NSColor.white.cgColor
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSUserInterfaceItemIdentifier(_ input: String) -> NSUserInterfaceItemIdentifier {
	return NSUserInterfaceItemIdentifier(rawValue: input)
}
