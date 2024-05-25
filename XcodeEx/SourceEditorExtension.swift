//
//  SourceEditorExtension.swift
//  BananaLint
//
//  Created by Danil Chemaev on 2024/04/22.
//  
//

import Foundation
import XcodeKit

class SourceEditorExtension: NSObject, XCSourceEditorExtension {

    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
        [
            AutoCorrectFileCommand.commandDefinitions,
            AutoCorrectProjectCommand.commandDefinitions,
            AutoCorrectSelectedRangeCommand.commandDefinitions
        ]
    }
}
