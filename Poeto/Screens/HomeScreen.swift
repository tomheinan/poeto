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
    
    private let navAppearance = UINavigationBarAppearance()
    private let fontSize: CGFloat = 18
    private let headerFont = Font.custom("Quicksand-Bold", size: 18)
    private let bodyFont = Font.custom("Quicksand-Regular", size: 18)
    private let stepIconRadius: CGFloat = 48
    
    private var lexiconWordCount: String {
        let wordCount = Lexicon.wordCount()
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let wordCountString = numberFormatter.string(from: NSNumber(value:wordCount)) {
            return wordCountString
        } else {
            return "0"
        }
    }
    
    init() {
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = Constants.Colors.backgroundGreen.uiColor
        navAppearance.titleTextAttributes = [.foregroundColor: Constants.Colors.bodyText.uiColor]
        navAppearance.largeTitleTextAttributes = [.foregroundColor: Constants.Colors.bodyText.uiColor]
        
        if let largeTitleFont = UIFont(name: "Quicksand-Bold", size: 28), let titleFont = UIFont(name: "Quicksand-Bold", size: 20) {
            navAppearance.largeTitleTextAttributes =  [.font : largeTitleFont, .foregroundColor: Constants.Colors.bodyText.uiColor]
            navAppearance.titleTextAttributes =  [.font : titleFont, .foregroundColor: Constants.Colors.bodyText.uiColor]
        }
        
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().compactAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
    }
    
    var body: some View {
        NavigationView {
            List {
                if !keyboardState.isKeyboardEnabled {
                    onboardingSection
                }
                textFieldSection
                settingsSection
                aboutSection
            }
            .scrollContentBackground(.hidden)
            .background(Constants.Colors.backgroundGreen.edgesIgnoringSafeArea(.all))
            .navigationTitle("Poeto")
            .analyticsScreen(name: "home_screen", class: "HomeScreen")
        }
        .navigationViewStyle(.stack)
        
    }
}

extension HomeScreen {
    
    var onboardingSection: some View {
        Section(header: header(text: "komenca instalaĵo"), footer: footer(text: "Antaŭ ol vi povas uzi la klavaron por la unua fojo, vi devas ebligi ĝin en iOS-agordoj.")) {
            onboardingStep(number: 1, text: "Malfermu \"\(NSLocalizedString("Settings", comment: "The word for 'Settings' in the user's locale"))\"")
            onboardingStep(number: 2, text: "Tuŝetu \"\(NSLocalizedString("Keyboard", comment: "The word for 'Keyboard' in the user's locale"))\"")
            onboardingStep(number: 3, text: "Aktivigi Poeton")
            OpenSettingsButton(text: "Malfermi \"\(NSLocalizedString("Settings", comment: "The word for 'Settings' in the user's locale"))\"", fontSize: fontSize, stepIconRadius: stepIconRadius)
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
    
    var aboutSection: some View {
        Section(header: header(text: "Pri ĉi tiu Apo"), footer: starFooter) {
            HStack {
                Text("Versio")
                Spacer()
                Text(Bundle.main.versionNumber!)
                    .font(headerFont)
                    .foregroundStyle(Constants.Colors.backgroundGreen)
            }
            HStack {
                Text("Kunmetaĵo")
                Spacer()
                Text(Bundle.main.buildNumber!)
                    .font(headerFont)
                    .foregroundStyle(Constants.Colors.backgroundGreen)
            }
            HStack {
                Text("Vortkalkulo de leksikono")
                Spacer()
                Text(lexiconWordCount)
                    .font(headerFont)
                    .foregroundStyle(Constants.Colors.backgroundGreen)
            }
        }
        .font(bodyFont)
    }
    
    var starFooter: some View {
        HStack {
            Spacer()
            Image("starLaunch", bundle: nil)
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
            Spacer()
        }
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
                    .fill(Constants.Colors.accentColor)
                    .frame(width: stepIconRadius, height: stepIconRadius)
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0 ))
                Text(String(number))
                    .font(Font.custom("Quicksand-Bold", size: stepIconRadius * 0.5))
                    .foregroundStyle(.white)
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0 ))
            }
            Text(text)
                .font(bodyFont)
                .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0))
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
