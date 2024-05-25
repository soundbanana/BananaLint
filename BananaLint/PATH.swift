//
//  PATH.swift
//  BananaLint
//
//  Created by Danil Chemaev on 2024/04/27.
//  
//

import Foundation
import Defaults

enum PATH {
    static var swiftLintPath: String {
        switch Defaults[.swiftlintPathMode] {
        case .default:
            return DEFINE.defaultSwiftLintPath
        case .relative:
            return Defaults[.swiftlintPath]
        case .custom:
            return Defaults[.swiftlintPath]
        }
    }
}
