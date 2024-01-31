//
//  File.swift
//  
//
//  Created by Graves Scout on 27/12/2023.
//

import Foundation

/// The progress bar progress options..
public enum GSAnimationType {
    case linear(duration: CGFloat)
    case sectioned(sections: [GSProgressSectionMetadata])
    case randomized(configuration: GSRandomizedConfiguration)
}
