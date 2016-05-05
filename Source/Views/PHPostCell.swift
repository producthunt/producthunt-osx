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

    private let cursor = NSCursor.pointingHandCursor()
    private var model: PHPostViewModel?
    private var post: PHPost?
    private var trackingArea: NSTrackingArea?
    private var mouseInside = false {
        didSet {
            updateUI()
        }
    }

    class func view(tableView: NSTableView, owner: AnyObject?, subject: AnyObject?) -> NSView {
        let view = tableView.makeViewWithIdentifier("postCellIdentifier", owner: owner) as! PHPostCell

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

    private func commonInit() {
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

    private func setPost(post: PHPost?) {
        self.post = post

        guard let post = post else {
            return
        }

        model = PHPostViewModel(withPost: post, store: store)
        updateUI()
    }

    private func updateUI() {
        guard let model = model else {
            return
        }

        layer?.backgroundColor = mouseInside ? NSColor.ph_highlightColor().CGColor : NSColor.ph_whiteColor().CGColor

        seenView.hidden = model.isSeen

        titleLabel.stringValue          = model.title
        taglineLabel.stringValue        = model.tagline
        voteCountLabel.stringValue      = model.votesCount
        commentsCountLabel.stringValue  = model.commentsCount
        timeAgoLabel.stringValue        = model.createdAt

        thumbnailImageView.kf_setImageWithURL(model.thumbnailUrl, placeholderImage: NSImage(named: "placeholder"))

        twitterButton.hidden = !mouseInside
        facebookButton.hidden = !mouseInside
    }

    private func createTrackingAreaIfNeeded() {
        if trackingArea == nil {
            trackingArea = NSTrackingArea(rect: CGRect.zero, options: [NSTrackingAreaOptions.InVisibleRect, NSTrackingAreaOptions.MouseEnteredAndExited, NSTrackingAreaOptions.ActiveAlways], owner: self, userInfo: nil)
        }
    }

    override func updateTrackingAreas() {
        super.updateTrackingAreas()

        createTrackingAreaIfNeeded()

        if !trackingAreas.contains(trackingArea!) {
            addTrackingArea(trackingArea!)
        }
    }

    override func mouseEntered(theEvent: NSEvent) {
        mouseInside = true
    }

    override func mouseExited(theEvent: NSEvent) {
        mouseInside = false
    }

    @IBAction func toggleTwitterShare(sender: AnyObject) {
        PHShareAction.sharedInstance.performTwitter(post)
    }

    @IBAction func toggleFacebookShare(sender: AnyObject) {
        PHShareAction.sharedInstance.performFacebook(post)
    }
}
