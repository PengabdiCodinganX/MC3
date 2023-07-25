//
//  ChatBubble.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 19/07/23.
//

import Foundation
import SwiftUI

struct ChatBubble: Shape {
    var alignment: MascotAlignment
    
    func path(in rect: CGRect) -> Path {
        switch alignment {
        case .horizontal:
            return HorizontalChatBubble(rect)
        case .vertical:
            return VerticalChatBubble(rect)
        }
    }
}

func HorizontalChatBubble(_ rect: CGRect) -> Path {
        var path = Path()
        
        let w = rect.width
        let h = rect.height
        let controlWidth = min(w, h) * 0.1
        let triangleHeight = h * 0.1
        
        path.move(to: CGPoint(x: controlWidth, y: controlWidth - triangleHeight)) // Top left
        path.addLine(to: CGPoint(x: w - controlWidth, y: controlWidth - triangleHeight)) // Top right
        path.addArc(center: CGPoint(x: w - controlWidth, y: controlWidth + controlWidth - triangleHeight), radius: controlWidth, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false) // Top right rounded corner

        path.addLine(to: CGPoint(x: w, y: h - controlWidth)) // Right side line
        path.addArc(center: CGPoint(x: w - controlWidth, y: h - controlWidth), radius: controlWidth, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false) // Bottom right rounded corner

        path.addLine(to: CGPoint(x: controlWidth, y: h)) // Bottom left
        path.addArc(center: CGPoint(x: controlWidth, y: h - controlWidth), radius: controlWidth, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false) // Bottom left rounded corner

        path.addLine(to: CGPoint(x: controlWidth - triangleHeight, y: h - triangleHeight - controlWidth - controlWidth)) // Line to start of triangle on bottom
        path.addLine(to: CGPoint(x: -triangleHeight, y: h / 2)) // Triangle point
        path.addLine(to: CGPoint(x: controlWidth - triangleHeight, y: controlWidth + controlWidth + triangleHeight)) // Line to end of triangle on bottom

        path.addLine(to: CGPoint(x: 0, y: controlWidth + controlWidth)) // Left side line
        path.addArc(center: CGPoint(x: controlWidth, y: controlWidth + controlWidth - triangleHeight), radius: controlWidth, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: -90), clockwise: false) // Top left rounded corner

        return path
}

private func VerticalChatBubble(_ rect: CGRect) -> Path {
            var path = Path()
    
            let w = rect.width
            let h = rect.height
            let controlWidth = min(w, h) * 0.1
            let triangleHeight = h * 0.1
    
            path.move(to: CGPoint(x: controlWidth, y: controlWidth - triangleHeight)) // Top left
            path.addLine(to: CGPoint(x: w - controlWidth, y: controlWidth - triangleHeight)) // Top right
            path.addArc(center: CGPoint(x: w - controlWidth, y: controlWidth + controlWidth - triangleHeight), radius: controlWidth, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false) // Top right rounded corner
    
            path.addLine(to: CGPoint(x: w, y: h - controlWidth)) // Right side line
            path.addArc(center: CGPoint(x: w - controlWidth, y: h - controlWidth), radius: controlWidth, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false) // Bottom right rounded corner
    
            path.addLine(to: CGPoint(x: w / 2 + controlWidth + 5, y: h)) // Line to start of triangle on bottom
            path.addLine(to: CGPoint(x: w / 2, y: h + triangleHeight)) // Triangle point
            path.addLine(to: CGPoint(x: w / 2 - controlWidth - 5, y: h)) // Line to end of triangle on bottom
    
            path.addLine(to: CGPoint(x: controlWidth, y: h)) // Bottom left
            path.addArc(center: CGPoint(x: controlWidth, y: h - controlWidth), radius: controlWidth, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false) // Bottom left rounded corner
    
            path.addLine(to: CGPoint(x: 0, y: controlWidth + controlWidth)) // Left side line
            path.addArc(center: CGPoint(x: controlWidth, y: controlWidth + controlWidth - triangleHeight), radius: controlWidth, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: -90), clockwise: false) // Top left rounded corner
    
            return path
}
