//
//  SwiftUIView.swift
//  
//
//  Created by Graves Scout on 22/01/2024.
//

import SwiftUI

struct GSCustomProgressBar: View {
    let path: Path
    @Binding var progress: CGFloat
    let trackLineWidth: CGFloat
    let fillLineWidth: CGFloat
    var trackColor: Color
    var progressColor: Color
    var shadowColor: Color
    let showShadow: Bool
    
    var body: some View {
        ZStack {
            ScaledPath(path: path)
                .stroke(trackColor, lineWidth: trackLineWidth)
                .padding(trackLineWidth/2)
                .shadow(color:showShadow ? shadowColor : .clear, radius: showShadow ? 5 : 0)
            ScaledPath(path: path)
                .trim(from: 0, to: progress)
                .stroke(progressColor, style: StrokeStyle(lineWidth: fillLineWidth, lineCap: .round))
                .padding(trackLineWidth/2)
        }
    }
}


#Preview {
    GSCustomProgressBar(path: Path(), progress: .constant(0.4), trackLineWidth: 6, fillLineWidth: 4, trackColor: .gray, progressColor: .blue, shadowColor: .blue, showShadow: true)
}


struct ScaledPath: Shape {
    let path: Path
    func path(in rect: CGRect) -> Path {
        let multiplier = min(rect.width, rect.height)

        // Create an affine transform that uses the multiplier for both dimensions equally.
        let transform = CGAffineTransform(scaleX: multiplier, y: multiplier)

        // Apply that scale and send back the result.
        return path.applying(transform)
    }
}
