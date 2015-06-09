//
//  PathSegment.swift
//  ThoughtPad
//
//  Created by Daniel Scanlon on 6/9/15.
//  Copyright (c) 2015 Present. All rights reserved.
//

import UIKit

class PathSegment {
   
    // MARK: Public State
    var points: [CGPoint] = []
    
    // MARK: Public State -> Dynamic Getters
    var originPoint: CGPoint? { return 0 < points.count ? points[0] : nil }
    var controlPoint1: CGPoint? { return 1 < points.count ? points[1] : nil }
    var controlPoint2: CGPoint? { return 2 < points.count ? points[2] : nil }
    var controlPoint3: CGPoint? { return 4 < points.count ? points[4] : nil }
    var endPoint: CGPoint? {
        if let controlPoint2 = controlPoint2, controlPoint3 = controlPoint3 {
            let endPointX: CGFloat = (controlPoint2.x + controlPoint3.x)/2
            let endPointY: CGFloat = (controlPoint2.y + controlPoint3.y)/2
        
            return CGPointMake(endPointX, endPointY)
        }
        
        return nil
    }
    var bezierPath: UIBezierPath {
        var bezierPath = UIBezierPath()
        
        if let originPoint = originPoint {
            bezierPath.moveToPoint(originPoint)
        }
        
        // If segment has origin, end, and all control points, render bezier curve
        // from origin to end point with control points.  If segment has less than 
        // origin, end, and all control points, render line from origin point to 
        // points in segment.
        if let originPoint = originPoint,
            controlPoint1 = controlPoint1,
            controlPoint2 = controlPoint2,
            controlPoint3 = controlPoint3,
            endPoint = endPoint {
                bezierPath.addCurveToPoint(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        } else {
            for point in points {
                bezierPath.addLineToPoint(point)
            }
        }
        
        return bezierPath
    }
    
    // MARK: Init
    init(points: [CGPoint]? = nil) {
        if let points = points {
            for point in points {
                appendPoint(point)
            }
        }
    }
    
    // MARK: Public mutation methods
    func appendPoint(point: CGPoint) {
        points.append(point)
    }
    
}
