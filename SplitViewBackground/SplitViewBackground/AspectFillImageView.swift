//
//  AspectFillImageView.swift
//  BackgroundImageOSX
//
//  Created by Brian D Keane on 10/5/17.
//  Copyright © 2017 Brian D Keane. All rights reserved.
//

import Cocoa

class AspectFillImageView: NSImageView {
    
    var overlay:NSView?
    var count:Int = 0
    
    override func draw(_ dirtyRect: NSRect)
    {
        super.draw(dirtyRect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // IF the image was set in the storyboard, it must be reset here
        // so that it is in the CALayer instead of the main layer
        if let image = self.image
        {
            self.setImage(image: image)
        }
    }
    
    func setImage(image: NSImage)
    {
        self.image = nil
        self.image = image
    }
    
    override func viewWillDraw()
    {
        if (self.overlay == nil)
        {
            self.addOverlay()
        }
    }
    
    
    func addOverlay()
    {
        if (self.overlay == nil)
        {
            self.autoresizesSubviews = true
            self.overlay = NSView()
            self.overlay!.frame = self.bounds
            self.overlay!.layer = CALayer()
            self.overlay!.translatesAutoresizingMaskIntoConstraints = false
            self.overlay!.autoresizingMask = [.viewHeightSizable, .viewWidthSizable]
            
            let viewLayer:CALayer = CALayer()
            viewLayer.backgroundColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
            self.overlay!.wantsLayer = true
            self.overlay!.layer = viewLayer
            
            self.addSubview(overlay!)
            self.overlay!.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0).isActive = true
            self.overlay!.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
        }
    }
    
    open override var image: NSImage?
        {
        set
        {
            self.layer = CALayer()
            self.layer?.contentsGravity = kCAGravityResizeAspectFill
            self.layer?.contents = newValue
            self.wantsLayer = true
            
            super.image = newValue
        }
        
        get
        {
            return super.image
        }
    }
}
