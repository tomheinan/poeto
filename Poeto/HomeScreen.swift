//
//  HomeScreen.swift
//  Poeto
//
//  Created by Tom Heinan on 2023-12-18.
//

import KeyboardKit
import SwiftUI

struct HomeScreen: View {

    @State
    private var appearance = ColorScheme.light

    @State
    private var isAppearanceDark = false

    @AppStorage("com.keyboardkit.demo.text")
    private var text = ""

    @StateObject
    private var keyboardState = KeyboardStateContext(
        bundleId: "app.poeto.*")

    var body: some View {
        NavigationView {
            List {
                textFieldSection
                editorLinkSection
                stateSection
            }
            .buttonStyle(.plain)
            .navigationTitle("Poeto")
            .onChange(of: isAppearanceDark) { newValue in
                appearance = isAppearanceDark ? .dark : .light
            }
        }
        .navigationViewStyle(.stack)
    }
}

extension HomeScreen {

    var textFieldSection: some View {
        Section(header: Text("Text Field")) {
            TextEditor(text: $text)
                .frame(height: 100)
                .keyboardAppearance(appearance)
                .environment(\.layoutDirection, isRtl ? .rightToLeft : .leftToRight)
                .typesettingLanguage(Locale.Language(identifier: "eo"))
            Toggle(isOn: $isAppearanceDark) {
                Text("Dark appearance")
            }
        }
    }

    var editorLinkSection: some View {
        Section(header: Text("Editor")) {
            NavigationLink {
                TextEditor(text: $text)
                    .padding(.horizontal)
                    .navigationTitle("Editor")
            } label: {
                Label {
                    Text("Full screen editor")
                } icon: {
                    Image(systemName: "doc.text")
                }
            }
        }
    }

    var stateSection: some View {
        Section(header: Text("Keyboard"), footer: footerText) {
            KeyboardStateLabel(
                isEnabled: keyboardState.isKeyboardActive,
                enabledText: "Demo keyboard is active",
                disabledText: "Demo keyboard is not active"
            )
            KeyboardSettingsLink(addNavigationArrow: true) {
                KeyboardStateLabel(
                    isEnabled: keyboardState.isKeyboardEnabled,
                    enabledText: "Demo keyboard is enabled",
                    disabledText: "Demo keyboard not enabled"
                )
            }
            KeyboardSettingsLink(addNavigationArrow: true) {
                KeyboardStateLabel(
                    isEnabled: keyboardState.isFullAccessEnabled,
                    enabledText: "Full Access is enabled",
                    disabledText: "Full Access is disabled"
                )
            }
        }
    }
    
    var footerText: some View {
        Text("You must enable the keyboard in System Settings, then select it with 🌐 when typing.")
    }

    var isRtl: Bool {
        let keyboardId = keyboardState.activeKeyboardBundleIds.first
        return keyboardId?.hasSuffix("rtl") ?? false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
