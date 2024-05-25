//
//  ViewController.swift
//  BananaLint
//
//  Created by Danil Chemaev on 2024/04/21.
//

import Cocoa
import ServiceManagement
import Defaults

class ViewController: NSViewController {
    // MARK: - Properties

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    // MARK: - Outlets

    @IBOutlet private var swiftlintPathPopUpButton: NSPopUpButton! {
        didSet {
            // Set the initial selection of the PopUpButton based on saved preference
            swiftlintPathPopUpButton.selectItem(at: Defaults[.swiftlintPathMode].rawValue)
        }
    }

    @IBOutlet private var swiftlintPathTextField: NSTextField! {
        didSet {
            // Configure the text field based on saved preference and set the delegate
            swiftlintPathTextField.delegate = self
            if Defaults[.swiftlintPathMode] == .default {
                swiftlintPathTextField.isEditable = false
                swiftlintPathTextField.stringValue = DEFINE.defaultSwiftLintPath
            } else {
                swiftlintPathTextField.stringValue = Defaults[.swiftlintPath]
            }
        }
    }

    @IBOutlet private weak var launchAtLoginCheckBox: NSButton! {
        didSet {
            // Set the initial state of the checkbox based on saved preference
            launchAtLoginCheckBox.state = Defaults[.shouldLaunchAtLogin] ? .on : .off
        }
    }

    @IBOutlet private weak var shouldOpenWindowCheckBox: NSButton! {
        didSet {
            // Set the initial state of the checkbox based on saved preference
            shouldOpenWindowCheckBox.state = Defaults[.shouldOpenWindowWhenLaunch] ? .on : .off
        }
    }

    // MARK: - Actions

    @IBAction private func handleSwiftLintPathButton(_ sender: Any) {
        let selectedIndex = swiftlintPathPopUpButton.indexOfSelectedItem
        Defaults[.swiftlintPathMode] = FilePathMode(rawValue: selectedIndex) ?? .default

        switch selectedIndex {
        case 0:// default
            swiftlintPathTextField.isEditable = false
            swiftlintPathTextField.stringValue = DEFINE.defaultSwiftLintPath
        case 1:// custom
            swiftlintPathTextField.isEditable = true
            swiftlintPathTextField.stringValue = Defaults[.swiftlintPath]
        case 2:// relative
            swiftlintPathTextField.isEditable = true
            swiftlintPathTextField.stringValue = Defaults[.swiftlintPath]
        default:
            break
        }
    }

    @IBAction private func handleLaunchAtLoginCheckBox(_ sender: Any) {
        let shouldLaunchAtLogin = launchAtLoginCheckBox.state == .on
        Defaults[.shouldLaunchAtLogin] = shouldLaunchAtLogin

        SMLoginItemSetEnabled(DEFINE.launcherAppBundleIdentifier as CFString, shouldLaunchAtLogin)
    }

    @IBAction private func handleShouldOpenWindowCheckBox(_ sender: Any) {
        let shouldOpenWindow = shouldOpenWindowCheckBox.state == .on
        Defaults[.shouldOpenWindowWhenLaunch] = shouldOpenWindow
    }
}

extension ViewController: NSTextFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        guard let textField = obj.object as? NSTextField else {
            return
        }

        switch textField {
        case swiftlintPathTextField:
            Defaults[.swiftlintPath] = textField.stringValue
        default:
            break
        }
    }
}
