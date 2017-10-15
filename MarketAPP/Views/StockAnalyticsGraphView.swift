//
//  StockAnalyticsGraphView.swift
//  MarketAPP
//
//  Created by Will Cohen on 10/15/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

class StockAnalyticsGraphView: UIView {
    
    var graphPoints: [Float] = []
    let strokeColor = UIColor(red:0.79, green:0.75, blue:0.84, alpha:1.0)
    
    private struct Constants {
        static let margin: CGFloat = 0.0
        static let topBorder: CGFloat = 10
        static let bottomBorder: CGFloat = 20
        static let colorAlpha: CGFloat = 0.3
        static let circleDiameter: CGFloat = 7.5
    }
    
    init(graphPointsInit: [Float], frame: CGRect) {
        self.graphPoints = graphPointsInit
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        //CREATE GRAPH POINTS
        let context = UIGraphicsGetCurrentContext()!
        let colors = [UIColor(red:0.28, green:0.15, blue:0.42, alpha:1.0).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor]
        let colorLocations: [CGFloat] = [0.0, 1.0]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations)!
        
        
        let graphWidth = width
        let columnXPoint = { (column: Float) -> CGFloat in
            let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
            return CGFloat(column) * spacing + Constants.margin + 2
        }
        
        let topBorder = Constants.topBorder
        let bottomBorder = Constants.bottomBorder
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.max()!
        let columnYPoint = { (graphPoint: Float) -> CGFloat in
            let y = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            return graphHeight + topBorder - y
        }
        
        UIColor.white.setFill()
        UIColor.white.setStroke()
        
        let graphPath = UIBezierPath()
        
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
        for point in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(Float(point)), y: columnYPoint(graphPoints[point]))
            graphPath.addLine(to: nextPoint)
        }
        context.saveGState()
        
        // CREATE GRADIENT
        let clippingPath = graphPath.copy() as! UIBezierPath
        clippingPath.addLine(to: CGPoint(x: columnXPoint(Float(graphPoints.count - 1)), y: height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: height))
        clippingPath.close()
        clippingPath.addClip()
        
        let highestYPoint = columnYPoint(maxValue)
        let graphStartPoint = CGPoint(x: 0, y: highestYPoint)
        let graphEndPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient, start: graphStartPoint, end: graphEndPoint, options: [])
        context.restoreGState()
        
        graphPath.lineWidth = 2.0
        strokeColor.setStroke()
        graphPath.stroke()
        
        for i in 0..<graphPoints.count {
            var point = CGPoint(x: columnXPoint(Float(i)), y: columnYPoint(graphPoints[i]))
            point.x -= Constants.circleDiameter / 2
            point.y -= Constants.circleDiameter / 2
            
            let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: Constants.circleDiameter, height: Constants.circleDiameter)))
            strokeColor.setFill()
            circle.fill()
        }
        
    }
    
    
    
}
