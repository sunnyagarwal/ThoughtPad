//
//  Path.swift
//  ThoughtPad
//
//  Created by Daniel Scanlon on 6/5/15.
//  Copyright (c) 2015 Present. All rights reserved.
//

import UIKit

class Path {

    // MARK: Public State
    var segments: [PathSegment] = []
    var bezierPath: UIBezierPath {
        var bezierPath = UIBezierPath()
        
        for segment in segments {
            if let originPoint = segment.originPoint {
                bezierPath.moveToPoint(originPoint)
            }
            
            bezierPath.appendPath(segment.bezierPath)
        }
        
        return bezierPath
    }
    
    // MARK: Init
    init(initialPoint: CGPoint) {
        appendPoint(initialPoint)
        
        bezierPath.lineWidth = 2
    }
    
    // MARK: Private Mutation Methods
    private func getCurrentSegment() -> PathSegment {
        if let currentSegment = segments.last {
            if let currentSegmentEndPoint = currentSegment.endPoint, currentSegmentControlPoint3 = currentSegment.controlPoint3 {
                return createNewSegment(points: [currentSegmentEndPoint, currentSegmentControlPoint3])
            } else {
                return currentSegment
            }
        }
        
        return createNewSegment()
    }
    
    private func createNewSegment(points: [CGPoint]? = nil) -> PathSegment {
        // Create new path segment & append it to segments
        let newSegment = PathSegment(points: points)
        segments.append(newSegment)
        
        return newSegment
    }
    
    // MARK: Public mutation methods
    func appendPoint(point: CGPoint) {
        // Get current segment & append point to it
        let currentSegment = getCurrentSegment()
        currentSegment.appendPoint(point)
    }
    
}
