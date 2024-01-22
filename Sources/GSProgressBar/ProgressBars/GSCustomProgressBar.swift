//
//  SwiftUIView.swift
//  
//
//  Created by Dor Ditchi on 22/01/2024.
//

import SwiftUI

struct GSCustomProgressBar: View {
    let path: Path
    @Binding var progress: CGFloat
    let trackLineWidth: CGFloat
    let fillLineWidth: CGFloat
    
    var body: some View {
        ZStack {
            ScaledPath(path: path)
                .stroke(.gray, lineWidth: trackLineWidth)
                .padding(trackLineWidth/2)
                .shadow(color:.blue, radius: 5)
            ScaledPath(path: path)
                .trim(from: 0, to: progress)
                .stroke(.blue, style: StrokeStyle(lineWidth: fillLineWidth, lineCap: .round))
                .padding(trackLineWidth/2)
        }
    }
}


#Preview {
    GSCustomProgressBar(path: Path(), progress: .constant(0.4), trackLineWidth: 6, fillLineWidth: 4)
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
