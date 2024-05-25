//
//  AutoCorrectFileCommand.swift
//  BananaLint
//
//  Created by Danil Chemaev on 2024/05/08.
//  
//

import Foundation
import XcodeKit
import Defaults

class AutoCorrectFileCommand: SourceEditorCommand {
    override class var commandDefinitions: [XCSourceEditorCommandDefinitionKey: Any] {
        [
            .nameKey: "AutoCorrect Current File",
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
        bananaLintXpc.autocorrectCurrentFile { isCompleted in
            if isCompleted {
                completionHandler(nil)
            } else {
                completionHandler(XcodeCommandError.swiftlintError)
            }
        }
    }
}
