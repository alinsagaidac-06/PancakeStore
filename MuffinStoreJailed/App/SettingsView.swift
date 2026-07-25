//
//  SettingsView.swift
//  PancakeStore
//
//  Created by lunginspector on 1/11/26.
//

import SwiftUI
import PartyUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    
    @AppStorage("autoCleanApp") var autoCleanApp: Bool = true
    @AppStorage(AppLanguage.storageKey) private var languageCode: String = AppLanguage.english.rawValue

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        AppInfoCell(build: "Beta 1")
                        HStack {
                            Button {
                                openURL(URL(string: "https://jailbreak.party/discord")!)
                            } label: {
                                ButtonLabel(text: Localization.string("action.discord"), icon: "discord", useImage: true)
                            }
                            .buttonStyle(TranslucentButtonStyle(color: .discord))

                            Button {
                                openURL(URL(string: "https://github.com/jailbreakdotparty/PancakeStore")!)
                            } label: {
                                ButtonLabel(text: Localization.string("action.github"), icon: "github", useImage: true)
                            }
                            .buttonStyle(TranslucentButtonStyle(color: .github))
                        }

                        Button {
                            openURL(URL(string: "https://jailbreak.party/")!)
                        } label: {
                            ButtonLabel(text: Localization.string("action.website"), icon: "globe")
                        }
                        .buttonStyle(TranslucentButtonStyle())
                    }
                } header: {
                    HeaderLabel(text: Localization.string("section.about.title"), icon: "info.circle")
                }

                Section {
                    Toggle(isOn: $autoCleanApp) {
                        Text("settings.autoClean.title")
                        Text("settings.autoClean.subtitle")
                    }

                    Button("action.cleanDocuments") {
                        cleanUp()
                    }
                } header: {
                    HeaderLabel(text: Localization.string("section.data.title"), icon: "loupe")
                }

                Section {
                    VStack(spacing: 12) {
                        ForEach(AppLanguage.allCases) { language in
                            Button {
                                select(language)
                            } label: {
                                HStack {
                                    Text(language.displayNameKey)
                                    Spacer()
                                    if language.rawValue == languageCode {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundStyle(.tint)
                                    }
                                }
                            }
                            .buttonStyle(TranslucentButtonStyle())
                        }
                    }
                } header: {
                    HeaderLabel(text: Localization.string("section.language.title"), icon: "globe")
                }

                Section {
                    LinkCreditCell(image: Image("mineek"), name: "mineek", description: Localization.string("credits.mineek"), url: "https://github.com/mineek")
                    LinkCreditCell(image: Image("lunginspector"), name: "lunginspector", description: Localization.string("credits.lunginspector"), url: "https://github.com/lunginspector")
                    LinkCreditCell(image: Image("skadz"), name: "Skadz", description: Localization.string("credits.skadz"), url: "https://github.com/skadz108")
                } header: {
                    HeaderLabel(text: Localization.string("section.credits.title"), icon: "star")
                }
            }
            .navigationTitle("settings.title")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

private extension SettingsView {
    func select(_ language: AppLanguage) {
        Haptic.shared.play(.soft)
        languageCode = language.rawValue
        Localization.setLanguage(language)
    }
}
