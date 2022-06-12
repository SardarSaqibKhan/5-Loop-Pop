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

extension GameScene {
    // MARK: - Pause
    /** Call to show pause menu.*/
    func pauseGame() {
        if isPlay {
            if scene?.view?.isPaused == false {
                Sound.preload.playSound(.buttonPress)
                setInterfacePause()
                Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(makePauseAfterTime), userInfo: nil, repeats: false)
            }
        }
    }
    /** Call this for continue game */
    func continueGame() {
        scene?.view?.isPaused = false
        hideInterfacePause()
        Sound.preload.playSound(.buttonPress)
    }
    /** Go to menu or restart game from pause menu.*/
    func changeSceneAfterPause(toMenu menu: Bool) {
        changeSceneToMenuInPauseMenu = menu
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changeSceneInPauseMenu), userInfo: nil, repeats: false)
    }

    // MARK: - Work with pause function
    @objc func setInterfacePause() {
        interfaceHolder.addChild([pauseBackground, buttonRestart, buttonMenu, buttonContinue, textPause])
        InterfaceExtention.put(nodesWithArray: [buttonRestart, buttonMenu, buttonContinue], atPosition: SettingsScenes.Game.Position.button_Restart_Menu_Continue, withSpaceBetween: SettingsScenes.Game.Position.space_Button_Restart_Menu_Continue, andSortHorizontal: true)
    }
    func hideInterfacePause() {
        pauseBackground.removeFromParent()
        buttonRestart.removeFromParent()
        buttonMenu.removeFromParent()
        buttonContinue.removeFromParent()
        textPause.removeFromParent()
        buttonRestart.removeFromViewedPoint()
        buttonMenu.removeFromViewedPoint()
        buttonContinue.removeFromViewedPoint()
    }
    @objc func makePauseAfterTime() {
        scene?.view?.isPaused = true
    }
    @objc func changeSceneInPauseMenu() {
        isPlay = false
        if changeSceneToMenuInPauseMenu {
            ///Switch music back
            Sound.preload.musicSwitch(toMusicType: .menu)
            ///Change scene
            loadScene(.menu, withTransitionName: .pushRight)
        }
        else { loadScene(.game, withTransitionName: .pushUp)}
    }
}
