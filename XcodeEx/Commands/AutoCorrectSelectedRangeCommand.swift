//
//  AutoCorrectSelectedRangeCommand.swift
//  BananaLint
//
//  Created by Danil Chemaev on 2024/05/08.
//  
//

import Foundation
import XcodeKit
import Defaults

class AutoCorrectSelectedRangeCommand: SourceEditorCommand {
    override class var commandDefinitions: [XCSourceEditorCommandDefinitionKey: Any] {
        [
            .nameKey: "AutoCorrect Selected Range",
            .classNameKey: self.className(),
            .identifierKey: Self.commandIdentifier
        ]
    }

    override func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        let connection = NSXPCConnection(serviceName: DEFINE.bananaLintXPCBundleIdentifier)
        connection.remoteObjectInterface = NSXPCInterface(with: BananaLintXPCProtocol.self)
        connection.resume()

        guard let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange,
              let text = invocation.selectedLine(at: 0),
              let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
                  return
        }

        let tmpFile = url.appendingPathComponent("tmp.swift")
        do {
            try text.write(to: tmpFile, atomically: true, encoding: .utf8)
        } catch {
            completionHandler(error)
            return
        }

        let bananaLintXpc = connection.remoteObjectProxy as! BananaLintXPCProtocol

        bananaLintXpc.setSwiftLintPath(PATH.swiftLintPath, relativePath: Defaults[.swiftlintPathMode] == .relative)
        bananaLintXpc.autocorrectFile(at: tmpFile.path) { isCompleted in
            if isCompleted {
                guard FileManager.default.fileExists(atPath: tmpFile.path),
                      let content = try? String(contentsOf: tmpFile) else {
                          completionHandler(XcodeCommandError.fileNotFound)
                          return
                      }
                let lines = content.components(separatedBy: .newlines)

                let selectedLineCount = selection.end.line - selection.start.line + 1
                lines.enumerated().forEach { index, line in
                    if index < selectedLineCount {
                        invocation.buffer.lines[index + selection.start.line] = line
                    } else {
                        invocation.buffer.lines.insert(line, at: index + selection.start.line)
                    }
                }
                if lines.count < selectedLineCount {
                    (selection.start.line + lines.count...selection.end.line).forEach { index in
                        invocation.buffer.lines[index] = ""
                    }
                }
                bananaLintXpc.xcodeFormatShortcut()
                completionHandler(nil)
            } else {
                completionHandler(XcodeCommandError.swiftlintError)
            }
        }
    }
}
