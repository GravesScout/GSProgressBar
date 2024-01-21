//
//  SwiftUIView.swift
//  
//
//  Created by Dor Ditchi on 27/12/2023.
//

import SwiftUI
import Combine

struct GSCircularProgressBar: View {
    @Binding private var progress: CGFloat

    init(progress: Binding<CGFloat>) {
        _progress = progress
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray,lineWidth: 16)
                .shadow(color:.blue, radius: 5)
            Circle()
                .trim(from: 0, to: progress)
                .rotation(.degrees(-90))
                .stroke(.blue, style: StrokeStyle(lineWidth: 14, lineCap: .round))
            
        }
    }
}

#Preview {
    SwiftUIView()
}
