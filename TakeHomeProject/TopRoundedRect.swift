//
//  TopRoundedRect.swift
//  TakeHomeProject
//
//  Created by Holly on 10/23/24.
//

import SwiftUI
import CoreGraphics

struct TopRoundedRect: Shape {
    
    var cornerRadius: CGFloat = 20
    
    func path(in rect: CGRect) -> Path {
        let effectiveRadius = min(cornerRadius, min(rect.height, rect.width)/2)
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + effectiveRadius))
        path.addRelativeArc(
            center: CGPoint(x: rect.minX + effectiveRadius, y: rect.minY + effectiveRadius),
            radius: effectiveRadius,
            startAngle: .degrees(180),
            delta: .degrees(90))
        path.addLine(to: CGPoint(x: rect.maxX - effectiveRadius, y: rect.minY))
        path.addRelativeArc(
            center: CGPoint(x: rect.maxX - effectiveRadius, y: rect.minY + effectiveRadius),
            radius: effectiveRadius,
            startAngle: .degrees(-90),
            delta: .degrees(90))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        return path
    }
}

#Preview {
    VStack {
        Spacer()
        TopRoundedRect(cornerRadius: 50)
            .fill(Color.purple)
            .frame(width: 200, height: 200)
        Spacer()
    }
}
