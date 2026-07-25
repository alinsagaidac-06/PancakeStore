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

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        AppInfoCell(build: "Beta 2")
                        HStack {
                            Button {
                                openURL(URL(string: "https://jailbreak.party/discord")!)
                            } label: {
                                ButtonLabel(text: String(localized: "action.discord"), icon: "discord", useImage: true)
                            }
                            .buttonStyle(TranslucentButtonStyle(color: .discord))

                            Button {
                                openURL(URL(string: "https://github.com/jailbreakdotparty/PancakeStore")!)
                            } label: {
                                ButtonLabel(text: String(localized: "action.github"), icon: "github", useImage: true)
                            }
                            .buttonStyle(TranslucentButtonStyle(color: .github))
                        }

                        Button {
                            openURL(URL(string: "https://jailbreak.party/")!)
                        } label: {
                            ButtonLabel(text: String(localized: "action.website"), icon: "globe")
                        }
                        .buttonStyle(TranslucentButtonStyle())
                    }
                } header: {
                    HeaderLabel(text: String(localized: "section.about.title"), icon: "info.circle")
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
                    HeaderLabel(text: String(localized: "section.data.title"), icon: "loupe")
                }

                Section {
                    LinkCreditCell(image: Image("mineek"), name: "mineek", description: String(localized: "credits.mineek"), url: "https://github.com/mineek")
                    LinkCreditCell(image: Image("lunginspector"), name: "lunginspector", description: String(localized: "credits.lunginspector"), url: "https://github.com/lunginspector")
                    LinkCreditCell(image: Image("skadz"), name: "Skadz", description: String(localized: "credits.skadz"), url: "https://github.com/skadz108")
                    LinkCreditCell(image: Image("gerda"), name: "gerda", description: String(localized: "credits.localizations.gerda"), url: "https://github.com/ezn1hero")
                } header: {
                    HeaderLabel(text: String(localized: "section.credits.title"), icon: "star")
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
