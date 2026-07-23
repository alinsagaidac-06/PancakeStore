//
//  Localization.swift
//  MuffinStoreJailed
//

import Foundation
import SwiftUI

enum AppLanguage: String, CaseIterable, Identifiable {
    case english = "en"
    case russian = "ru"

    static let storageKey = "appLanguage"

    var id: String { rawValue }
    var locale: Locale { Locale(identifier: rawValue) }

    var displayNameKey: LocalizedStringKey {
        switch self {
        case .english:
            return LocalizedStringKey("language.english")
        case .russian:
            return LocalizedStringKey("language.russian")
        }
    }
}

enum Localization {
    static func currentLanguage() -> AppLanguage {
        if let stored = UserDefaults.standard.string(forKey: AppLanguage.storageKey),
           let language = AppLanguage(rawValue: stored) {
            return language
        }
        return .english
    }

    static func setLanguage(_ language: AppLanguage) {
        guard currentLanguage() != language else { return }
        UserDefaults.standard.set(language.rawValue, forKey: AppLanguage.storageKey)
    }

    static func bundle(for language: AppLanguage? = nil) -> Bundle {
        let targetLanguage = (language ?? currentLanguage()).rawValue
        if let path = Bundle.main.path(forResource: targetLanguage, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return bundle
        }
        return .main
    }

    static func string(_ key: String, arguments: CVarArg...) -> String {
        let bundle = bundle()
        let format = NSLocalizedString(key, tableName: nil, bundle: bundle, value: key, comment: "")
        guard !arguments.isEmpty else { return format }
        return String(format: format, locale: currentLanguage().locale, arguments: arguments)
    }
}
