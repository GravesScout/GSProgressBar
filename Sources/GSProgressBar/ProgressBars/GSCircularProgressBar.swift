//
//  SwiftUIView.swift
//  
//
//  Created by Dor Ditchi on 27/12/2023.
//

import SwiftUI
import Combine

struct GSCircularProgressBar: View {
    @Binding var progress: CGFloat
    let trackLineWidth: CGFloat
    let fillLineWidth: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray, lineWidth: trackLineWidth)
                .padding(trackLineWidth/2)
                .shadow(color:.blue, radius: 5)
            Circle()
                .trim(from: 0, to: progress)
                .rotation(.degrees(-90))
                .stroke(.blue, style: StrokeStyle(lineWidth: fillLineWidth, lineCap: .round))
                .padding(trackLineWidth/2)
        }
    }
}

#Preview {
    SwiftUIView()
}
