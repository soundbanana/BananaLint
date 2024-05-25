//
//  Defaults.Keys.swift
//  BananaLint
//
//  Created by Danil Chemaev on 2024/04/26.
//  
//

import Foundation
import Defaults

extension Defaults.Keys {
    private static let groupUserDefaults = UserDefaults(suiteName: "group.com.soundbanana.BananaLint")
    private static let userDefaults = UserDefaults.standard

    static let swiftlintPathMode = Defaults.Key<FilePathMode>("swiftlintPathMode", default: .default, suite: groupUserDefaults ?? userDefaults)
    static let swiftlintPath = Defaults.Key<String>("swiftlintPath", default: DEFINE.defaultSwiftLintPath, suite: groupUserDefaults ?? userDefaults)

    static let shouldLaunchAtLogin = Defaults.Key<Bool>("shouldLaunchAtLogin", default: false)
    static let shouldOpenWindowWhenLaunch = Defaults.Key<Bool>("shouldOpenWindowWhenLaunch", default: true)
}
