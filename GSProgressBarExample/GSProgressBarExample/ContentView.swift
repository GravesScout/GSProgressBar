//
//  ContentView.swift
//  GSProgressBarExample
//
//  Created by Dor Ditchi on 21/12/2023.
//

import SwiftUI
import GSProgressBar

struct ContentView: View {
    @State var progress: CGFloat = 0.0
    var body: some View {
        ZStack {
            GSProgressBar(type: .circular, sectionsDurations: [
                .init(duration: 3, sectionProportionValue: 0.3, sectionDelay: 2),
                    .init(duration: 1.5, sectionProportionValue: 0.6, sectionDelay: 4),
                .init(duration: 5, sectionProportionValue: 0.1)]) { updatedProgress in
                    progress = updatedProgress
                    
                }
            .frame(width: 150, height: 150)
            Text("\(progress)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
