//
//  HomeScreen.swift
//  Poeto
//
//  Created by Tom Heinan on 2023-12-18.
//

import KeyboardKit
import SwiftUI
import FirebaseAnalytics
import FirebaseAnalyticsSwift

struct HomeScreen: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage(Constants.Preferences.showHintsKey, store: UserDefaults(suiteName: Constants.AppGroup.appGroupIdentifier))
    var showHints: Bool = true
    
    @StateObject
    private var keyboardState = KeyboardStateContext(bundleId: "app.poeto.*")
    
    @State
    var text: String = ""
    
    private let coloredNavAppearance = UINavigationBarAppearance()
    private let fontSize: CGFloat = 18
    private let headerFont = Font.custom("Quicksand-Bold", size: 18)
    private let bodyFont = Font.custom("Quicksand-Regular", size: 18)
    private let stepIconRadius: CGFloat = 48
    
    init() {
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = Constants.Colors.backgroundGreen.uiColor
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: Constants.Colors.bodyText.uiColor]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: Constants.Colors.bodyText.uiColor]
        
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
        
        if let font = UIFont(name: "Quicksand-Bold", size: 20) {
            UINavigationBar.appearance().largeTitleTextAttributes = [.font : font]
            UINavigationBar.appearance().titleTextAttributes = [.font : font]
        }
        
    }
    
    var body: some View {
        GeometryReader { reader in
            NavigationView {
                VStack(spacing: 0) {
                    Rectangle().frame(height: reader.size.height/3).ignoresSafeArea()
                    List {
                        if !keyboardState.isKeyboardEnabled {
                            onboardingSection
                        }
                        textFieldSection
                        settingsSection
                    }
                    .buttonStyle(.plain)
                    .navigationBarTitle("Poeto")
                    .analyticsScreen(name: "home_screen", class: "HomeScreen")
                    .scrollContentBackground(.hidden)
                    .background(Constants.Colors.backgroundGreen.edgesIgnoringSafeArea(.all))
                    .padding(.top, -60)
                }
                .navigationTitle("Poeto")
                .navigationBarHidden(true)
            }
        }
    }
}

extension HomeScreen {
    
    var onboardingSection: some View {
        Section(header: header(text: "komenca instalaĵo"), footer: footer(text: "Antaŭ ol vi povas uzi la klavaron por la unua fojo, vi devas ebligi ĝin en iOS-agordoj.")) {
            onboardingStep(number: 1, text: "Navigu al \"Agordoj\"")
            onboardingStep(number: 2, text: "Tuŝetu \"Klavarojn\"")
            onboardingStep(number: 3, text: "Aktivigi Poeton")
            OpenSettingsButton(text: "Malfermi agordojn", fontSize: fontSize, stepIconRadius: stepIconRadius)
        }
    }
    
    var textFieldSection: some View {
        Section(header: header(text: "Prova Areo"), footer: footer(text: "Vi povas uzi la tekstan areon supre por provi la klavaron.")) {
            TextEditor(text: $text)
                .frame(height: 100)
                .typesettingLanguage(Locale.Language(identifier: "eo"))
        }
    }
    
    var settingsSection: some View {
        Section(header: header(text: "Preferoj")) {
            Toggle("Montru anglajn sugestojn", isOn: $showHints)
                .onChange(of: showHints) {
                    Analytics.logEvent("set_preference", parameters: ["key":"show_hints", "value":showHints])
                }
        }
        .font(bodyFont)
    }
    
    var footerText: some View {
        Text("You must enable the keyboard in System Settings, then select it with 🌐 when typing.")
    }
    
    func header(text: String) -> some View {
        return Text(text)
            .font(headerFont)
            .foregroundColor(Constants.Colors.bodyText)
    }
    
    func footer(text: String) -> some View {
        return Text(text)
            .font(headerFont)
            .foregroundColor(Constants.Colors.bodyText)
    }
    
    func onboardingStep(number: Int, text: String) -> some View {
        HStack {
            ZStack {
                Circle()
                    .fill(.blue)
                    .frame(width: stepIconRadius, height: stepIconRadius)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0 ))
                Text(String(number))
                    .font(Font.custom("Quicksand-Bold", size: stepIconRadius * 0.5))
                    .foregroundStyle(.white)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0 ))
            }
            Text(text)
                .font(bodyFont)
        }
    }
    
    struct OpenSettingsButton: View {
        @Environment(\.openURL) var openURL
        
        let text: String
        let fontSize: CGFloat
        let stepIconRadius: CGFloat
        
        init(text: String, fontSize: CGFloat, stepIconRadius: CGFloat) {
            self.text = text
            self.fontSize = fontSize
            self.stepIconRadius = stepIconRadius
        }

        var body: some View {
            Button(action: openSettings) {
                Label {
                    Text(text)
                        .font(Font.custom("Quicksand-Regular", size: fontSize))
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0 ))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                } icon: {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: stepIconRadius, height: stepIconRadius)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0 ))
                        .foregroundColor(.white)
                }
            }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
        }

        private func openSettings() {
            Analytics.logEvent("open_settings", parameters: [:])
            openURL(URL(string: UIApplication.openSettingsURLString)!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
