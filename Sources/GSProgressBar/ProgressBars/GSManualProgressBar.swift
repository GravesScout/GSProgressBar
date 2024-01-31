//
//  GSManualProgressBar.swift
//
//
//  Created by Graves Scout on 29/01/2024.
//

import SwiftUI

public struct GSManualProgressBar: View {
    public let type: GSProgressBarType
    public let trackLineWidth: CGFloat
    public let fillLineWidth: CGFloat
    @Binding public var progress: CGFloat
    var trackColor: Color
    var progressColor: Color
    var shadowColor: Color
    let showShadow: Bool
    
    
    public init(type: GSProgressBarType,
                trackLineWidth: CGFloat,
                fillLineWidth: CGFloat,
                showShadow: Bool,
                progress: Binding<CGFloat>,
                trackColor: Color = .gray,
                progressColor: Color = .blue,
                shadowColor: Color = .blue
    ) {
        self.type = type
        self.trackLineWidth = trackLineWidth
        self.fillLineWidth = fillLineWidth
        self.trackColor = trackColor
        self.progressColor = progressColor
        self.shadowColor = shadowColor
        self.showShadow = showShadow
        _progress = progress
    }
    
    public var body: some View {
        switch type {
        case .bar:
            GSLinearProgressBar(progress: $progress,
                                trackLineWidth: trackLineWidth,
                                fillLineWidth: fillLineWidth,
                                cornerRadius: 16,
                                trackColor: trackColor,
                                progressColor: progressColor,
                                shadowColor: shadowColor,
                                showShadow: showShadow)
        case .circular:
            GSCircularProgressBar(progress: $progress,
                                  trackLineWidth: trackLineWidth,
                                  fillLineWidth: fillLineWidth,
                                  trackColor: trackColor,
                                  progressColor: progressColor,
                                  shadowColor: shadowColor,
                                  showShadow: showShadow)
        case .customPath(let path):
            GSCustomProgressBar(path:path,
                                progress: $progress,
                                trackLineWidth: trackLineWidth,
                                fillLineWidth: fillLineWidth,
                                trackColor: trackColor,
                                progressColor: progressColor,
                                shadowColor: shadowColor,
                                showShadow: showShadow)
        }
    }
}

#Preview(".bar progressBar") {
    GSManualProgressBar(type: .bar, trackLineWidth: 16, fillLineWidth: 14, showShadow: true, progress: .constant(40))
}

#Preview(".circular progressBar") {
    GSManualProgressBar(type: .circular, trackLineWidth: 16, fillLineWidth: 14, showShadow: true, progress: .constant(40))
}
