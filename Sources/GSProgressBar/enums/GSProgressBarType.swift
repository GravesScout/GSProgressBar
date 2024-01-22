//
//  File.swift
//  
//
//  Created by Dor Ditchi on 21/12/2023.
//

import Foundation
import SwiftUI

extension Path: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}

public enum GSProgressBarType: Hashable {
    case linear
    case circular
    case customPath(path: Path)
}
