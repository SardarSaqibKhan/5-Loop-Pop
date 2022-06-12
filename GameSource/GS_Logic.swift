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
    
    // MARK: - Setters
    func setCircle() {
        circle = CircleNode(withScene: self)
        circle.delegate = self
        addChild(circle)
        circle.rotateRow(withSpeed: circleSpeed)
    }
    
    // MARK: - Game actions
    
    func circleRowCollected() {
        if isPlay {
            increaseScoreBy(SettingsGameProcess.Circle.coinForCollectingRow)
            increaseLevel()
            
            Sound.preload.playSound(.getPoint)
        }
    }
    
    func circleCollectBall() {
        if isPlay {
            increaseScoreBy(SettingsGameProcess.Circle.coinForCollectBall)
        }
    }
    
    func circleLimitOfBalls() {
        gameOver()
    }
}
