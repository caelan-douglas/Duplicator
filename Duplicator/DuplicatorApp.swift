//
//  DuplicatorApp.swift
//  Duplicator
//  Menubar tool for creating multiple instances of applications
//  for apps that don't support multiple windows
//

import SwiftUI
import LaunchAtLogin

@discardableResult
func shell(_ args: String...) -> Int32 {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

func duplicate() {
    let activeApp = NSWorkspace.shared.frontmostApplication
    let appName = activeApp?.localizedName
    // Don't duplicate ourselves
    if activeApp != nil && appName != "Duplicator" {
        shell("open", "-n", activeApp!.bundleURL!.absoluteString)
    }
}

@main
struct DuplicatorApp: App {
    var body: some Scene {
        // create menu bar item
        MenuBarExtra("Duplicator", systemImage: "macwindow.on.rectangle") {
            // duplicator button
            Button(String("Duplicate focused app")) {
                duplicate()
            }.keyboardShortcut("D")
            Divider()
            // quit app button
            LaunchAtLogin.Toggle()
            Button("Quit Duplicator") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("Q")
        }
    }
}
