//
//  SourceEditorCommand.swift
//  BananaLint
//
//  Created by Danil Chemaev on 2024/04/22.
//  
//

import Foundation
import XcodeKit
import Defaults

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    class var commandIdentifier: String {
        let bundleID = Bundle.main.bundleIdentifier ?? "com.soundbanana.BananaLint.XcodeEx"
        return bundleID + "." + className()
    }

    class var commandDefinitions: [XCSourceEditorCommandDefinitionKey: Any] {
        [
            .nameKey: "",
            .classNameKey: className(),
            .identifierKey: Self.commandIdentifier
        ]
    }

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) {}
}
