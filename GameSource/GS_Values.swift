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

extension GameScene {
    
    // MARK: - Score
    /**
     Use this function for increese score by value.
     - parameter value: Int value for add to you score.
     */
    func increaseScoreBy(_ value: Int) {
        if isPlay {
            score += value
            labelScore.changeTextWithAnimationScaled(withText: score)
            labelScore.setShadowDefault()
        }
    }
    /** Save you current score in NSUserDefaults by key "CurrentScore", "BestScore" and if you set new best score you can check in by bool value with key "_newBestScore".*/
    func saveScore() {
        UserDefaults.standard.set(score, forKey: "CurrentScore")
        if score > UserDefaults.standard.integer(forKey: "BestScore") {
            UserDefaults.standard.set(score, forKey: "BestScore")
            UserDefaults.standard.set(true, forKey: "_newBestScore")
        }
        else {
            UserDefaults.standard.set(false, forKey: "_newBestScore")
        }
    }
    // MARK: - Coins
    /**
     Use this finction for increese coins by value.
     - parameter value: Int value for add to you coins.
     */
    func increaseCoinsBy(_ value: Int) {
        if isPlay {
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "Coins") + value, forKey: "Coins")
            labelCoins.changeTextWithAnimationScaled(withText: String(UserDefaults.standard.integer(forKey: "Coins")))
            
            Sound.preload.playSound(.getCoin)
        }
    }
    // MARK: - Game speed
    /** Use to make game more faster and harder.*/
    func increaseGameSpeeds() {
        if isPlay {
            if circleSpeed > SettingsGameProcess.Circle.Speed.max {
                circleSpeed.decrease(percentage: SettingsGameProcess.Circle.Speed.changeByPercent)
            }
            if ballSpeed > SettingsGameProcess.Ball.Speed.max {
                ballSpeed.decrease(percentage: SettingsGameProcess.Ball.Speed.changeByPercent)
            }
            
            circle.rotateRow(withSpeed: circleSpeed)
        }
    }
    func increaseLevel() {
        currentLevel += 1
        labelLevel.changeTextWithAnimationScaled(withText: NSLocalizedString("gameScene_labelLevel", comment: "") + String(currentLevel))
    }
}
