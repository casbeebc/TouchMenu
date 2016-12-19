//
//  TouchMenuContentViewController.swift
//  TouchMenu
//
//  Created by brett on 7/15/15.
//  Copyright (c) 2015 DataMingle. All rights reserved.
//

import UIKit

class TouchMenuContentViewController: UIViewController
{
    let pi = CGFloat(M_PI)
    
    let radius = CGFloat(50)
    let labelRadius = CGFloat(65)
    
    var origin: CGPoint
    
    let touchMenuLayer = CAShapeLayer()
    var touchMenuItems: [TouchMenuItem]!
    var touchMenuLayers = [CAShapeLayer]()
    var touchMenuLabels = [UILabel]()
    
    var drawingOffset:CGPoint = CGPoint.zero
    
    weak var touchMenu: TouchMenu!
    weak var touchMenuDelegate: TouchMenuDelegate?
    
    required init(origin: CGPoint)
    {
        self.origin = origin
        
        super.init(nibName: nil, bundle: nil)
        
        view.layer.addSublayer(touchMenuLayer)
        touchMenuLayer.frame = view.bounds
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 2
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleMovement(_ locationInView: CGPoint)
    {
        if touchMenuLayer.path == nil
        {
            return
        }
        
        let drawPath = UIBezierPath(cgPath: touchMenuLayer.path!)
        let locationInTouchMenu = CGPoint(x: locationInView.x + drawingOffset.x, y: locationInView.y + drawingOffset.y)
        
        drawPath.addLine(to: locationInTouchMenu)
        
        touchMenuLayer.path = drawPath.cgPath
        
        let distanceToMenuOrigin = origin.distance(locationInTouchMenu)
        
        let sectionArc = pi / CGFloat(touchMenuItems.count)
        
        let angle = atan2(locationInTouchMenu.y - origin.y, locationInTouchMenu.x - origin.x)
        
        let segmentIndex = Int((angle < 0 ? pi + angle : angle) / sectionArc )
        
        if CGFloat(distanceToMenuOrigin) > radius && segmentIndex >= 0 && segmentIndex < touchMenuItems.count
        {
            
            if let touchMenuItem = touchMenuItems[segmentIndex] as TouchMenuItem? {
                
                if touchMenuLabels[segmentIndex].text == " " + touchMenuItem.label + " " {
                    touchMenuLabels[segmentIndex].layer.backgroundColor = UIColor.yellow.cgColor
                    touchMenuLayers[segmentIndex].strokeColor = UIColor.yellow.cgColor
                } else {
                    touchMenuLabels[segmentIndex].alpha = 0.5
                    touchMenuLayers[segmentIndex].strokeColor = UIColor.lightGray.cgColor
                }
                
                origin = locationInTouchMenu
                
                //openTouchMenu(locationInView, touchMenuItems: subItems, clearPath: false)
            }
            else
            {
                touchMenuDelegate?.menuItemSelected(touchMenu!, menuItem: touchMenuItems[segmentIndex])
                
                closeTouchMenu()
                
                UIView.animate(withDuration: 0.75, animations: {}, completion: {_ in self.touchMenu.close()})
            }
        }
    }
    
    func closeTouchMenu()
    {
        _ = touchMenuLayers.map({ $0.removeFromSuperlayer() })
        _ = touchMenuLabels.map({ $0.removeFromSuperview() })
        
        touchMenuLayers = [CAShapeLayer]()
        touchMenuLabels = [UILabel]()
        
        touchMenuLayer.path = nil
    }
    
    func openTouchMenu(_ locationInView: CGPoint, touchMenuItems: [TouchMenuItem], clearPath: Bool = true)
    {
        self.touchMenuItems = touchMenuItems
        
        drawingOffset = CGPoint(x: origin.x - locationInView.x, y: origin.y - locationInView.y)
        
        let segments = CGFloat(touchMenuItems.count)
        let sectionArc = (pi / segments)
        let paddingAngle = pi * 0.01
        
        touchMenuLayer.strokeColor = UIColor.white.cgColor
        touchMenuLayer.fillColor = nil
        touchMenuLayer.lineWidth = 5
        touchMenuLayer.lineJoin = kCALineJoinRound
        touchMenuLayer.lineCap = kCALineCapRound
        
        if clearPath
        {
            let originCircle = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: origin.x - 4, y: origin.y - 4), size: CGSize(width: 8, height: 8)))
            
            
            touchMenuLayer.path = originCircle.cgPath
        }
        
        for i in 0  ..< touchMenuItems.count 
        {
            let startAngle = ((sectionArc * CGFloat(i)) + paddingAngle) + pi
            let endAngle = ((sectionArc * CGFloat(i + 1)) - paddingAngle) + pi
            
            let subLayer = CAShapeLayer()
            let subLayerPath = UIBezierPath()
            
            subLayer.strokeColor = UIColor.white.cgColor
            subLayer.fillColor = nil
            subLayer.lineCap = kCALineCapRound
            
            subLayer.lineWidth = 4
            
            touchMenuLayer.addSublayer(subLayer)
            
            let midAngle = (startAngle + endAngle) / 2
            
            let label = UILabel()
            label.textColor = UIColor.black
            label.text = " " + touchMenuItems[i].label + " "
            
            touchMenuLabels.append(label)
            
            let labelWidth = label.intrinsicContentSize.width
            let labelHeight = label.intrinsicContentSize.height
            
            let labelXOffsetTweak = (midAngle > pi * 0.45 && midAngle < pi * 0.55) || (midAngle > pi * 1.45 && midAngle < pi * 1.55) ? label.intrinsicContentSize.width / 2 : 15
            
            let labelXOffset = (midAngle > pi * 0.5 && midAngle < pi * 1.5) ? -labelWidth + labelXOffsetTweak : -labelXOffsetTweak
            let labelYOffset = (midAngle > pi) ? -labelHeight : midAngle == pi ? -labelHeight * 0.5 : 0
            
            label.frame = CGRect(origin: CGPoint(
                x: origin.x + labelXOffset + cos(midAngle) * labelRadius,
                y: origin.y + labelYOffset + sin(midAngle) * labelRadius),
                size: CGSize(width: labelWidth, height: labelHeight))
            
            label.layer.backgroundColor = UIColor.white.cgColor
            label.layer.cornerRadius = 4
            label.layer.masksToBounds = false
            label.alpha = 0
            
            subLayerPath.addArc(withCenter: origin, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            // join arc to label
            
            subLayerPath.move(to: CGPoint(
                x: origin.x + cos(midAngle) * radius,
                y: origin.y + sin(midAngle) * radius))
            
            subLayerPath.addLine(to: CGPoint(
                x: origin.x + cos(midAngle) * (labelRadius + 12),
                y: origin.y + sin(midAngle) * (labelRadius + 12)))
            
            subLayer.path = subLayerPath.cgPath
            
            touchMenuLayers.append(subLayer)
            view.addSubview(label)
            
            UIView.animate(withDuration: 0.1, animations: {label.alpha = 1})
        }
    }
}
