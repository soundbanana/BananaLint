//
//  AppDelegate.swift
//  BananaLint
//
//  Created by Danil Chemaev on 2024/04/21.
//

import Cocoa
import Defaults

class AppDelegate: NSObject, NSApplicationDelegate {
    private let statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    private let mainBarMenu = NSMenu(title: "BananaLintXcodePlugin")
    var preferenceWindowController: NSWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupMenuBar()

        if Defaults[.shouldOpenWindowWhenLaunch] {
            openPreferences()
        }

        checkPermission()
    }

    func checkPermission() {
        let targetAEDescriptor = NSAppleEventDescriptor(bundleIdentifier: "com.apple.dt.Xcode")
        let status: OSStatus = AEDeterminePermissionToAutomateTarget(targetAEDescriptor.aeDesc, typeWildCard, typeWildCard, true)

        switch status {
        case noErr:
           return
        case OSStatus(errAEEventNotPermitted):
            print("errAEEventNotPermitted")
        case OSStatus(procNotFound):
            print("procNotFound")
            return
        default:
            NSApplication.shared.terminate(self)
        }
    }

    private func setupPreferenceWindow() {
        let storyboard = NSStoryboard(name: "Preference", bundle: nil)
        guard let windowController = storyboard.instantiateInitialController() as? NSWindowController else {
            return
        }
        self.preferenceWindowController = windowController
    }

    private func setupMenuBar() {
        let image = NSImage(systemSymbolName: "screwdriver", accessibilityDescription: nil)
        image?.isTemplate = true
        statusBarItem.button?.image = image

        mainBarMenu.addItem(NSMenuItem(title: "Settings..", action: #selector(openPreferences), keyEquivalent: ","))
        mainBarMenu.addItem(NSMenuItem.separator())
        mainBarMenu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.shared.terminate(_:)), keyEquivalent: "q"))
        statusBarItem.menu = mainBarMenu
    }

    @objc
    func openPreferences() {
        if let windowController = self.preferenceWindowController {
            windowController.showWindow(self)
        } else {
            setupPreferenceWindow()
            self.preferenceWindowController?.showWindow(self)
        }
        NSApp.activate(ignoringOtherApps: true)
    }
}
