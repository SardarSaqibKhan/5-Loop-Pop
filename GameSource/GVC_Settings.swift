/*
 
 Created by TapTapStudio (Alice Vinnik).
 Copyright ©2020 TapTapStudio. All rights reserved.

 ▀▀█▀▀ ░█▀▀█ ▒█▀▀█ ▀▀█▀▀ ░█▀▀█ ▒█▀▀█
 ░▒█░░ ▒█▄▄█ ▒█▄▄█ ░▒█░░ ▒█▄▄█ ▒█▄▄█
 ░▒█░░ ▒█░▒█ ▒█░░░ ░▒█░░ ▒█░▒█ ▒█░░░

 ▒█▀▀▀█ ▀▀█▀▀ ▒█░▒█ ▒█▀▀▄ ▀█▀ ▒█▀▀▀█
 ░▀▀▀▄▄ ░▒█░░ ▒█░▒█ ▒█░▒█ ▒█░ ▒█░░▒█
 ▒█▄▄▄█ ░▒█░░ ░▀▄▄▀ ▒█▄▄▀ ▄█▄ ▒█▄▄▄█
 
 If you want reskin write me.
 Here you can see reskin examples 🌅: https://alicevinnik.wixsite.com/taptapstudio
 Subscribe to my instagram 📷: https://www.instagram.com/taptap_studio/
 Write to my mail 💌: taptap.main@gmail.com
 
*/

import SpriteKit

extension GameViewController {
    // MARK: - Settings
    /** It's first settings when you install game at first time.*/
    func firstLaunchSettings() {
        if !(UserDefaults.standard.bool(forKey: "HasLaunchedOnce")) {
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            
            // Set stats
            /// Music
            UserDefaults.standard.set(true, forKey: "PlaySounds")
            UserDefaults.standard.set(true, forKey: "PlayMusicMenu")
            UserDefaults.standard.set(true, forKey: "PlayMusicGame")

            
            /// Skins
            UserDefaults.standard.set(1, forKey: "CurrentSkin")
            UserDefaults.standard.set(SettingsGameProcess.Coin.atFirstLaunch, forKey: "Coins")
            
            /// Game Process
            UserDefaults.standard.set(0, forKey: "CurrentScore")
            UserDefaults.standard.set(0, forKey: "BestScore")
            
            /// Load skin values
            SkinValues.loadValues()
        }
    }
    
    /** This settings set evey game launch.*/
    func everyLaunchSettings() {
        /// Check game version. Call rateUs message if user open new version of game.
        if String(describing: Bundle.main.infoDictionary!["CFBundleShortVersionString"]) != UserDefaults.standard.string(forKey: "lastLaunchVersion") {
            UserDefaults.standard.set(String(describing: Bundle.main.infoDictionary!["CFBundleShortVersionString"]), forKey: "lastLaunchVersion")
            
        }
        /// Set view values
        guard let view = view as? SKView else {return}
        view.showsFPS = false
        view.showsNodeCount = false
        view.ignoresSiblingOrder = true
        
        /// Detect device and device values
        detectDevice()
        setNewSettingsForCurrentDevice()
        /// Other game stats
        UserDefaults.standard.set(0, forKey: "_currentSceneLoaded")
        /// Preload graphic files
        _ = GraphicPreloadsGame.preload
        _ = GraphicPreloadsInterface.preload
        /// Load world best score and work with gamecenter
        UserDefaults.standard.set(false, forKey: "GC_worldBestScore_PossibleToShow")
        
        /// Create observer
        createObserversToGameSceneController()
    }
    // MARK: - Detect device
    /** Create GameViewController observers.*/
    fileprivate func detectDevice() {
        if UIDevice.current.userInterfaceIdiom == .phone {
            UserDefaults.standard.set(false, forKey: "_isIPad")
            var screenHeight = UIScreen.main.nativeBounds.height
            var screenWidth = UIScreen.main.nativeBounds.width
            if screenWidth > screenHeight {
                let catche = screenHeight
                screenHeight = screenWidth
                screenWidth = catche
            }
            let proportion = Double(screenHeight / screenWidth)
            if proportion < 2.0 {
                Debugger.printNow(textToPrint: "iPhone Simple")
                UserDefaults.standard.set(false, forKey: "_isXPhone")
            }
            else {
                Debugger.printNow(textToPrint: "iPhone X Type")
                UserDefaults.standard.set(true, forKey: "_isXPhone")
            }
        }
        else {
            Debugger.printNow(textToPrint: "iPad")
            UserDefaults.standard.set(false, forKey: "_isXPhone")
            UserDefaults.standard.set(true, forKey: "_isIPad")
        }
    }
    /** Change values for current device.*/
    func setNewSettingsForCurrentDevice() {
        ///If its iPhoneX type
        if SettingsGlobal.isXPhone {
            Debugger.printNow(textToPrint: "Load iPhone X type values")
        }
        ///If its iPad type
        if SettingsGlobal.isIPad {
            Debugger.printNow(textToPrint: "Load iPad type values")
        }
    }
    // MARK: - Observers
    /** Create GameViewController observers.*/
    func createObserversToGameSceneController() {
    }
}
