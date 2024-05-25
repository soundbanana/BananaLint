//
//  NSImage.swift
//  BananaLint
//
//  Created by Danil Chemaev on 2024/05/11.
//
//

import Cocoa

extension NSImage {
    func withTintColor(_ tintColor: NSColor) -> NSImage {
        if self.isTemplate == false {
            return self
        }

        let image = self.copy() as! NSImage
        image.lockFocus()

        tintColor.set()
        __NSRectFillUsingOperation(NSRect(origin: .zero, size: image.size), .sourceAtop)

        image.unlockFocus()
        image.isTemplate = false

        return image
    }
}
