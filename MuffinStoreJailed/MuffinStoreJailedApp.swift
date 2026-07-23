//
//  MuffinStoreJailedApp.swift
//  MuffinStoreJailed
//
//  Created by Mineek on 31/12/2024.
//

import SwiftUI
import UniformTypeIdentifiers

var pipe = Pipe()
var sema = DispatchSemaphore(value: 0)
var weOnADebugBuild: Bool = false
let fm = FileManager.default

@main
struct MuffinStoreJailedApp: App {
    @AppStorage("autoCleanApp") var autoCleanApp: Bool = true
    @AppStorage(AppLanguage.storageKey) private var languageCode: String = AppLanguage.english.rawValue

    init() {
        // Setup log stuff (redirect stdout)
        setvbuf(stdout, nil, _IONBF, 0)
        dup2(pipe.fileHandleForWriting.fileDescriptor, STDOUT_FILENO)
        #if DEBUG
        weOnADebugBuild = true
        #else
        weOnADebugBuild = false
        #endif
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, Locale(identifier: languageCode))
                .onAppear {
                    Localization.setLanguage(AppLanguage(rawValue: languageCode) ?? .english)
                    if autoCleanApp {
                        cleanUp()
                    }
                }
                .onChange(of: languageCode) { newValue in
                    Localization.setLanguage(AppLanguage(rawValue: newValue) ?? .english)
                }
        }
    }
}

// make string compatiable with errors
extension String: @retroactive Error {}

extension FileManager {
    func createDirectoryIfNeeded(at url: URL) throws {
        if !self.fileExists(atPath: url.path) {
            try self.createDirectory(at: url, withIntermediateDirectories: true)
        }
    }
}
