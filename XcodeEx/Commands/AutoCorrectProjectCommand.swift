//
//  AutoCorrectProjectCommand.swift
//  BananaLint
//
//  Created by Danil Chemaev on 2024/05/08.
//  
//

import Foundation
import XcodeKit
import Defaults

class AutoCorrectProjectCommand: SourceEditorCommand {
    override class var commandDefinitions: [XCSourceEditorCommandDefinitionKey: Any] {
        [
            .nameKey: "AutoCorrect All Files",
            .classNameKey: self.className(),
            .identifierKey: Self.commandIdentifier
        ]
    }

    override func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        let connection = NSXPCConnection(serviceName: DEFINE.bananaLintXPCBundleIdentifier)
        connection.remoteObjectInterface = NSXPCInterface(with: BananaLintXPCProtocol.self)
        connection.resume()

        let bananaLintXpc = connection.remoteObjectProxy as! BananaLintXPCProtocol

        bananaLintXpc.setSwiftLintPath(PATH.swiftLintPath, relativePath: Defaults[.swiftlintPathMode] == .relative)
        bananaLintXpc.autocorrectProject {
            if $0 {
                completionHandler(nil)
            } else {
                completionHandler(XcodeCommandError.swiftlintError)
            }
        }
    }
}
