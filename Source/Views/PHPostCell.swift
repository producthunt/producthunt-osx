//
//  PHPostCell.swift
//  ProductHunt
//
//  Created by Vlado on 3/15/16.
//  Copyright © 2016 ProductHunt. All rights reserved.
//

import Cocoa
import Kingfisher

class PHPostCell: NSTableCellView {

    @IBOutlet weak var thumbnailImageView: KPCScaleToFillNSImageView!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var taglineLabel: NSTextField!
    @IBOutlet weak var seenView: PHSeenView!
    @IBOutlet weak var voteImageView: NSImageView!
    @IBOutlet weak var voteCountLabel: NSTextField!
    @IBOutlet weak var commentImageView: NSImageView!
    @IBOutlet weak var commentsCountLabel: NSTextField!
    @IBOutlet weak var timeAgoLabel: NSTextField!
    @IBOutlet weak var twitterButton: PHButton!
    @IBOutlet weak var facebookButton: PHButton!

    fileprivate let cursor = NSCursor.pointingHand
    fileprivate var model: PHPostViewModel?
    fileprivate var post: PHPost?
    fileprivate var trackingArea: NSTrackingArea?
    fileprivate var mouseInside = false {
        didSet {
            updateUI()
        }
    }

    class func view(_ tableView: NSTableView, owner: AnyObject?, subject: AnyObject?) -> NSView {
        let view = tableView.makeView(withIdentifier: convertToNSUserInterfaceItemIdentifier("postCellIdentifier"), owner: owner) as! PHPostCell

        if let post = subject as? PHPost {
            view.setPost(post)
        }

        return view
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        trackingArea = nil
        mouseInside = false
        twitterButton.resetTrackingArea()
    }

    override func resetCursorRects() {
        addCursorRect(bounds, cursor: cursor)
        cursor.set()
    }

    fileprivate func commonInit() {
        wantsLayer = true

        thumbnailImageView.wantsLayer = true
        thumbnailImageView.layer?.masksToBounds = true
        thumbnailImageView.layer?.cornerRadius = 3

        twitterButton.setImages("icon-twitter", highlitedImage: "icon-twitter-hovered")
        facebookButton.setImages("icon-facebook", highlitedImage: "icon-facebook-hovered")

        taglineLabel.textColor          = NSColor.ph_grayColor()
        voteCountLabel.textColor        = NSColor.ph_grayColor()
        commentsCountLabel.textColor    = NSColor.ph_grayColor()
        timeAgoLabel.textColor          = NSColor.ph_grayColor()

        voteImageView.image     = NSImage(named: "icon-upvote")!.tintedImageWithColor(NSColor.ph_grayColor())
        commentImageView.image  = NSImage(named: "comment-icon")!.tintedImageWithColor(NSColor.ph_grayColor())
    }

    fileprivate func setPost(_ post: PHPost?) {
        self.post = post

        guard let post = post else {
            return
        }

        model = PHPostViewModel(withPost: post, store: store)
        updateUI()
    }

    fileprivate func updateUI() {
        guard let model = model else {
            return
        }

        layer?.backgroundColor = mouseInside ? NSColor.ph_highlightColor().cgColor : NSColor.ph_whiteColor().cgColor

        seenView.isHidden = model.isSeen

        titleLabel.stringValue          = model.title
        taglineLabel.stringValue        = model.tagline
        voteCountLabel.stringValue      = model.votesCount
        commentsCountLabel.stringValue  = model.commentsCount
        timeAgoLabel.stringValue        = model.createdAt

        thumbnailImageView.kf.setImage(with: model.thumbnailUrl, placeholder: NSImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)

        twitterButton.isHidden = !mouseInside
        facebookButton.isHidden = !mouseInside
    }

    fileprivate func createTrackingAreaIfNeeded() {
        if trackingArea == nil {
            trackingArea = NSTrackingArea(rect: CGRect.zero, options: [NSTrackingArea.Options.inVisibleRect, NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.activeAlways], owner: self, userInfo: nil)
        }
    }

    override func updateTrackingAreas() {
        super.updateTrackingAreas()

        createTrackingAreaIfNeeded()

        if !trackingAreas.contains(trackingArea!) {
            addTrackingArea(trackingArea!)
        }
    }

    override func mouseEntered(with theEvent: NSEvent) {
        mouseInside = true
    }

    override func mouseExited(with theEvent: NSEvent) {
        mouseInside = false
    }

    @IBAction func toggleTwitterShare(_ sender: AnyObject) {
        PHShareAction.sharedInstance.performTwitter(post)
    }

    @IBAction func toggleFacebookShare(_ sender: AnyObject) {
        PHShareAction.sharedInstance.performFacebook(post)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSUserInterfaceItemIdentifier(_ input: String) -> NSUserInterfaceItemIdentifier {
	return NSUserInterfaceItemIdentifier(rawValue: input)
}
