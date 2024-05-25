//
//  mian.swift
//  BananaLint
//
//  Created by Danil Chemaev on 2024/05/11.
//
//

import AppKit

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
