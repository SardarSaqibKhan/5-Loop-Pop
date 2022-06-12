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

import Foundation

extension ButtonNode {
    
    /**
     This func used for default button initialisator. It's load default settings
     - parameter sceneName: Name of current loaded scene.
     - parameter type: Current button type.
     */
    func loadSettings(bySceneName sceneName: GlobalScene.SceneName, andButtonType type: ButtonType) {
        switch sceneName {
        case .game:
            switch type {
            case .pause:
                texture = GraphicPreloadsInterface.preload.button_Pause
                size = SettingsScenes.Game.Size.buttonPause
                position = SettingsScenes.Game.Position.buttonPause
                zPosition = SettingsScenes.Game.ZPosition.buttonPause
            case .restart:
                texture = GraphicPreloadsInterface.preload.button_RestartPause
                size = SettingsScenes.Game.Size.buttonRestart
                zPosition = SettingsScenes.Game.ZPosition.buttonRestart
            case .menu:
                texture = GraphicPreloadsInterface.preload.button_Menu
                size = SettingsScenes.Game.Size.buttonMenu
                zPosition = SettingsScenes.Game.ZPosition.buttonMenu
            case .pcontinue:
                texture = GraphicPreloadsInterface.preload.button_Continue
                size = SettingsScenes.Game.Size.buttonContinue
                zPosition = SettingsScenes.Game.ZPosition.buttonContinue
            default:
                Debugger.printNow(textToPrint: "Not find default button for this scene and type")
            }
        case .menu:
            switch type {
            case .start:
                texture = GraphicPreloadsInterface.preload.button_Start
                size = SettingsScenes.Menu.Size.buttonStart
                position = SettingsScenes.Menu.Position.buttonStart
                zPosition = SettingsScenes.Menu.ZPosition.buttonStart
                itsForChangingSceneButton = true
                changeToSceneName = .game
            case .settings:
                texture = GraphicPreloadsInterface.preload.button_Settigns
                size = SettingsScenes.Menu.Size.buttonSettings
                zPosition = SettingsScenes.Menu.ZPosition.buttonSettings
                itsForChangingSceneButton = true
                changeToSceneName = .settings
            default:
                Debugger.printNow(textToPrint: "Not find default button for this scene and type")
            }
        case .settings:
            switch type {
            case .back:
                texture = GraphicPreloadsInterface.preload.button_Back
                size = SettingsScenes.Settings.Size.buttonBack
                position = SettingsScenes.Settings.Position.buttonBack
                zPosition = SettingsScenes.Settings.ZPosition.buttonBack
                itsForChangingSceneButton = true
                changeToSceneName = .menu
            default:
                Debugger.printNow(textToPrint: "Not find default button for this scene and type")
            }
        case .end:
            switch type {
            case .menu:
                texture = GraphicPreloadsInterface.preload.button_Menu
                size = SettingsScenes.End.Size.buttonMenu
                zPosition = SettingsScenes.End.ZPosition.buttonMenu
                itsForChangingSceneButton = true
                changeToSceneName = .menu
            case .restart:
                texture = GraphicPreloadsInterface.preload.button_Restart
                size = SettingsScenes.End.Size.buttonRestart
                zPosition = SettingsScenes.End.ZPosition.buttonRestart
                itsForChangingSceneButton = true
                changeToSceneName = .game
            default:
                Debugger.printNow(textToPrint: "Not find default button for this scene and type")
            }
        }
        if SettingsGlobal.isIPad {
            if defaultSize.width == 0 { defaultSize = self.size}
            self.size = CGSize(width: defaultSize.width * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object,
                               height: defaultSize.height * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object)
        }
    }
}
