//
//  BubbleText.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 18/07/23.
//

import SwiftUI

struct ChatBubble: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let w = rect.width
        let h = rect.height
        let controlWidth = min(w, h) * 0.1
        let triangleHeight = h * 0.1
        
        path.move(to: CGPoint(x: controlWidth, y: controlWidth)) // Top left
        path.addLine(to: CGPoint(x: w - controlWidth, y: controlWidth)) // Top right
        path.addArc(center: CGPoint(x: w - controlWidth, y: controlWidth + controlWidth), radius: controlWidth, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false) // Top right rounded corner
        
        path.addLine(to: CGPoint(x: w, y: h - triangleHeight - controlWidth)) // Right side line
        path.addArc(center: CGPoint(x: w - controlWidth, y: h - triangleHeight - controlWidth), radius: controlWidth, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false) // Bottom right rounded corner
        
        path.addLine(to: CGPoint(x: w / 2 + controlWidth + 5, y: h - triangleHeight)) // Line to start of triangle on bottom
        path.addLine(to: CGPoint(x: w / 2, y: h + 2)) // Triangle point
        path.addLine(to: CGPoint(x: w / 2 - controlWidth - 5, y: h - triangleHeight)) // Line to end of triangle on bottom
        
        path.addLine(to: CGPoint(x: controlWidth, y: h - triangleHeight)) // Bottom left
        path.addArc(center: CGPoint(x: controlWidth, y: h - triangleHeight - controlWidth), radius: controlWidth, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false) // Bottom left rounded corner
        
        path.addLine(to: CGPoint(x: 0, y: controlWidth + controlWidth)) // Left side line
        path.addArc(center: CGPoint(x: controlWidth, y: controlWidth + controlWidth), radius: controlWidth, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: -90), clockwise: false) // Top left rounded corner
        
        return path
    }
}

struct BubbleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(Font.custom("SF Pro Rounded", size: 16))
            .kerning(1.4)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding()
            .background(ChatBubble().fill(Color.gray)) // Set the bubble color to gray
    }
}

struct BubbleText_Previews: PreviewProvider {
    static var previews: some View {
        BubbleText(text: "test wqkeonwql enqwlken qwlkenwqlkenwlq keqlkns ql")
    }
}
