//
//  CompassView.swift
//  PoiPoi
//
//  Created by Robert Ahlberg on 2020-10-10.
//

import UIKit

class CompassView: UIView {
  var needleAngle = 0.0 {
    didSet {
      setNeedsDisplay()
    }
  }
  
  
  
  
  override func draw(_ rect: CGRect) {
    let bg = UIBezierPath(rect: rect)
    bg.fill()
    let oval = UIBezierPath(ovalIn: rect)
    UIColor.systemTeal.setFill()
    oval.fill()
    
    // Needle
    let midPoint = CGPoint(x: rect.width / 2, y: rect.height / 2)
    let distance = rect.width / 2
    let endPoint = CGPoint(x: midPoint.x + distance * sin(deg2rad(needleAngle)), y: midPoint.y + distance * cos(deg2rad(needleAngle)))
    
    let needle = UIBezierPath()
    UIColor.systemPink.setStroke()
    needle.lineWidth = 3
    
    
    needle.move(to: midPoint)
    needle.addLine(to: endPoint)
    
    needle.stroke()
  }
  
  func deg2rad(_ number: Double) -> CGFloat {
      return CGFloat(number * .pi / 180)
  }
}
