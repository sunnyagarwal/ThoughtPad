//
//  CanvasView.swift
//  ThoughtPad
//
//  Created by Daniel Scanlon on 6/5/15.
//  Copyright (c) 2015 Present. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    var paths: [Path] = []

    // MARK: Overrides
    override func drawRect(rect: CGRect) {
        // Render all paths' bezier paths
        for path: Path in paths {
            // Set stroke color
            UIColor.blackColor().setStroke()
            
            // Apply stroke color to point sequence bezier path
            path.bezierPath.stroke()
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        // Create new current point sequence, originating at touch point
        let point = self.getTouchPoint(touches)
        self.createNewCurrentPath(point)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        
        // Add line to point of touch to latest bezier path
        let point = self.getTouchPoint(touches)
        self.appendCurrentPath(point)
        
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        super.touchesCancelled(touches, withEvent: event)
        println("Touches cancelled...")
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        println("Touches ended...")
        println("End of path:", paths.last)
    }
    
    // MARK: Private Methods
    private func createNewCurrentPath(initialPoint: CGPoint) {
        // Create new path, originating at touch point
        let path = Path(initialPoint: initialPoint)
        
        // Append new path to paths
        paths.append(path)
    }
    
    private func appendCurrentPath(point: CGPoint) {
        // Get current path from paths
        var path = paths.last
        
        // Append point to current path
        path?.appendPoint(point)
        
        // Re-render this view
        self.setNeedsDisplay()
    }
    
    // MARK: Private Helpers
    private func getTouchPoint(touches: Set<NSObject>) -> CGPoint {
        // Cast first touch to UITouch; get point of touch in this view
        let touch = touches.first as! UITouch
        let point = touch.locationInView(self)
        
        return point
    }

}
