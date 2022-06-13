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

class SettingsScene: GlobalScene, SwitchNodeDelegate {
    // MARK: Nodes
    private let background = BackgroundNode()
    private let switchSound = SwitchNode(texture: GraphicPreloadsInterface.preload.switch_Body, size: SettingsScenes.Settings.Size.switchSound, zPosition: SettingsScenes.Settings.ZPosition.switchSound, textureDot: GraphicPreloadsInterface.preload.switch_Dot, sizeDot: SettingsScenes.Settings.Size.switchSoundDot, positionDot: SettingsScenes.Settings.Position.switchDotOn, zPositionDot: SettingsScenes.Settings.ZPosition.switchDot)
    private let switchMusicMenu = SwitchNode(texture: GraphicPreloadsInterface.preload.switch_Body, size: SettingsScenes.Settings.Size.switchMusicMenu, zPosition: SettingsScenes.Settings.ZPosition.switchMusicMenu, textureDot: GraphicPreloadsInterface.preload.switch_Dot, sizeDot: SettingsScenes.Settings.Size.switchMusicDot, positionDot: SettingsScenes.Settings.Position.switchDotOn, zPositionDot: SettingsScenes.Settings.ZPosition.switchDot)
    private let switchMusicGame = SwitchNode(texture: GraphicPreloadsInterface.preload.switch_Body, size: SettingsScenes.Settings.Size.switchMusicGame, zPosition: SettingsScenes.Settings.ZPosition.switchMusicGame, textureDot: GraphicPreloadsInterface.preload.switch_Dot, sizeDot: SettingsScenes.Settings.Size.switchMusicDot, positionDot: SettingsScenes.Settings.Position.switchDotOn, zPositionDot: SettingsScenes.Settings.ZPosition.switchDot)
    private let buttonBack = ButtonNode(defaultWithType: .back)
    private let labelSound = SimpleLabel(text: NSLocalizedString("settingsScene_settingPlaySounds", comment: ""), fontSize: SettingsScenes.Settings.FontSize.labelSound, fontColorHex: SettingsScenes.Settings.FontColor.labelSound, position: SettingsScenes.Settings.Position.label_Sound_Music_Notification, zPosition: SettingsScenes.Settings.ZPosition.labelSound)
    private let labelMusicMenu = SimpleLabel(text: NSLocalizedString("settingsScene_settingPlayMenuNusic", comment: ""), fontSize: SettingsScenes.Settings.FontSize.labelMusicMenu, fontColorHex: SettingsScenes.Settings.FontColor.labelMusicMenu, position: SettingsScenes.Settings.Position.label_Sound_Music_Notification, zPosition: SettingsScenes.Settings.ZPosition.labelMusicMenu)
    private let labelMusicGame = SimpleLabel(text: NSLocalizedString("settingsScene_settingPlayGameMusic", comment: ""), fontSize: SettingsScenes.Settings.FontSize.labelMusicGame, fontColorHex: SettingsScenes.Settings.FontColor.labelMusicGame, position: SettingsScenes.Settings.Position.label_Sound_Music_Notification, zPosition: SettingsScenes.Settings.ZPosition.labelMusicGame)
    private let textSettings = LogoSmallNode(withType: .settings)
    // MARK: - Scene life cycle
    override func didMove(to view: SKView) {
        setInterface()
    }
    // MARK: - Work with interface
    private func setInterface() {
        ///Setting node
        labelSound.horizontalAlignmentMode = .right
        labelMusicMenu.horizontalAlignmentMode = .right
        labelMusicGame.horizontalAlignmentMode = .right
        labelSound.setShadowDefault()
        labelMusicMenu.setShadowDefault()
        labelMusicGame.setShadowDefault()
        InterfaceExtention.put(nodesWithArray: [switchSound, switchMusicMenu, switchMusicGame], atPosition: SettingsScenes.Settings.Position.switch_Sound_Music_Notification, withSpaceBetween: SettingsScenes.Settings.Position.space_Sound_Music_Notification, andSortHorizontal: false)
        InterfaceExtention.mirrored(nodesToMirror: [labelSound, labelMusicMenu, labelMusicGame], fromNodes: [switchSound, switchMusicMenu, switchMusicGame], byX: false)
        textSettings.setInterfaceSize()
        switchSound.setSwitchState(UserDefaults.standard.bool(forKey: "PlaySounds"))
        switchMusicMenu.setSwitchState(UserDefaults.standard.bool(forKey: "PlayMusicMenu"))
        switchMusicGame.setSwitchState(UserDefaults.standard.bool(forKey: "PlayMusicGame"))
        switchSound.delegate = self
        switchMusicMenu.delegate = self
        switchMusicGame.delegate = self
        switchSound.setShadowDefault()
        switchMusicMenu.setShadowDefault()
        switchMusicGame.setShadowDefault()
        ///Add nodes to view
        addChild([background, switchSound, switchMusicMenu, switchMusicGame, buttonBack, labelSound, labelMusicMenu, labelMusicGame, textSettings])
    }
    // MARK: - Logic
    /**
     This method it's delegate from SwitchNode class.
     If you try to change state of switch system call this method.
     Use it for change some game settings in game.
     */
    func switchStateIsChanged(_ sender: SwitchNode) {
        //Change states for some buttons
        switch sender {
        case switchSound: Sound.preload.changeStateSound()
        case switchMusicMenu: Sound.preload.changeStateMusic(withType: .menu)
        case switchMusicGame: Sound.preload.changeStateMusic(withType: .game)
        default: print("SettingsScenes - changeSwitchStatIsWasDone")
        }
    }
    // MARK: - Input
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            ///Check press to switch
            switchSound.changeSwitchState(ifInLocation: location)
            switchMusicMenu.changeSwitchState(ifInLocation: location)
            switchMusicGame.changeSwitchState(ifInLocation: location)
            ///Check press to button
            touchDownButtons(atLocation: location)
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            ///Change button state to simple
            touchUpAllButtons()            
            buttonBack.actionChangeScene(ifInLocation: location, withTransition: .pushLeft)
        }
    }
}
