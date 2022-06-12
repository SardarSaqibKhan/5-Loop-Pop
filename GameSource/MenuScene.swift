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
import AdSupport

class MenuScene: GlobalScene {
    // MARK: Nodes
    private var worldBestScoreAlreadyShowed = false
    private var indicatorButtonStoreOnScene = false
    private let background = BackgroundNode()
    private let logo = LogoNode(withType: .menu)
    private let coinsIndicator = SimpleSprite(texture: GraphicPreloadsInterface.preload.coinsIndicator, size: SettingsScenes.Menu.Size.coinsIndicator, position: SettingsScenes.Menu.Position.coinsIndicator, zPosition: SettingsScenes.Menu.ZPosition.coinsIndicator)
    private let buttonStart = ButtonNode(defaultWithType: .start)
    private let buttonSettings = ButtonNode(defaultWithType: .settings)
    private let labelBestScore = SimpleLabel(text: NSLocalizedString("menuScene_PlayerBestScore", comment: "") + String(UserDefaults.standard.integer(forKey: "BestScore")), fontSize: SettingsScenes.Menu.FontSize.labelBestScore, fontColorHex: SettingsScenes.Menu.FontColor.labelBestScore, position: SettingsScenes.Menu.Position.labelBestScore, zPosition: SettingsScenes.Menu.ZPosition.labelBestScore)
    private let labelCoins = SimpleLabel(text: String(UserDefaults.standard.integer(forKey: "Coins")), fontSize: SettingsScenes.Menu.FontSize.labelCoins, fontColorHex: SettingsScenes.Menu.FontColor.labelCoins, position: SettingsScenes.Menu.Position.labelCoins, zPosition: SettingsScenes.Menu.ZPosition.labelCoins)
    private let labelWorldBestScoreName = SimpleLabel(text: "", fontSize: SettingsScenes.Menu.FontSize.labelWorldBestScoreName, fontColorHex: SettingsScenes.Menu.FontColor.labelWorldBestScoreName, position: SettingsScenes.Menu.Position.labelWorldBestScoreName, zPosition: SettingsScenes.Menu.ZPosition.labelWorldBestScoreName)
    private let labelWorldBestScoreValue = SimpleLabel(text: "", fontSize: SettingsScenes.Menu.FontSize.labelWorldBestScoreValue, fontColorHex: SettingsScenes.Menu.FontColor.labelWorldBestScoreValue, position: SettingsScenes.Menu.Position.labelWorldBestScoreValue, zPosition: SettingsScenes.Menu.ZPosition.labelWorldBestScoreValue)
    // MARK: - Scene life cycle
    override func didMove(to view: SKView) {
        setInterface()
        runAnimations()
        print(ASIdentifierManager.shared().advertisingIdentifier)
    }
    override func update(_ currentTime: TimeInterval) {
        ///Try to show world best score
        updateLabelWorldBestScore()
    }
    // MARK: - Work with interface
    private func setInterface() {
        labelCoins.horizontalAlignmentMode = .left
        labelBestScore.horizontalAlignmentMode = .left
        labelWorldBestScoreName.horizontalAlignmentMode = .right
        labelWorldBestScoreValue.horizontalAlignmentMode = .right
        labelCoins.setShadowDefault()
        labelBestScore.setShadowDefault()
        labelWorldBestScoreName.setShadowDefault()
        labelWorldBestScoreValue.setShadowDefault()
        labelCoins.setShadowDefault()
        coinsIndicator.setShadowDefault()
        
        let buttonsToSort = [buttonSettings]
        InterfaceExtention.put(nodesWithArray: buttonsToSort,
                               atPosition: SettingsScenes.Menu.Position.buttons_RateUs_Tutorial_GameCenter_Settings,
                               withSpaceBetween: SettingsScenes.Menu.Position.space_Buttons_RateUs_Tutorial_GameCenter_Settings,
                               andSortHorizontal: true)
        logo.setInterfaceSize()
        coinsIndicator.setInterfaceSize()
        ///Add nodes to scene
        addChild([background, logo, buttonStart, buttonSettings, labelBestScore, labelWorldBestScoreName, labelWorldBestScoreValue])
        ///Set coin indicator and run animations
    }
    
    /** Try to load world best score*/
    private func updateLabelWorldBestScore() {
        if !worldBestScoreAlreadyShowed {
            let animationShow = SKAction.sequence([
                SKAction.fadeAlpha(to: 0, duration: 0),
                SKAction.fadeAlpha(to: 1, duration: SettingsGameProcess.Interface.Menu.labelsWorldBestScoreAnimationShowSpeed)])
            if SettingsGlobal.GameCenter.testMode {
                labelWorldBestScoreValue.run(animationShow)
                labelWorldBestScoreName.run(animationShow)
                labelWorldBestScoreValue.text = NSLocalizedString("menuScene_WorldBestScoreValue", comment: "") + "326"
                labelWorldBestScoreName.text = NSLocalizedString("menuScene_WorldBestScoreName", comment: "") + "TapTap"
                labelWorldBestScoreName.setShadowDefault()
                labelWorldBestScoreValue.setShadowDefault()
                worldBestScoreAlreadyShowed = true
            }
            else {
                if !worldBestScoreAlreadyShowed {
                    if UserDefaults.standard.bool(forKey: "GC_worldBestScore_PossibleToShow") {
                        labelWorldBestScoreValue.run(animationShow)
                        labelWorldBestScoreName.run(animationShow)
                        labelWorldBestScoreValue.text = NSLocalizedString("menuScene_WorldBestScoreValue", comment: "") + UserDefaults.standard.string(forKey: "GC_worldBestScore_Value_leaderboard")!
                        labelWorldBestScoreName.text = NSLocalizedString("menuScene_WorldBestScoreName", comment: "") + UserDefaults.standard.string(forKey: "GC_worldBestScore_Name_leaderboard")!
                        labelWorldBestScoreName.setShadowDefault()
                        labelWorldBestScoreValue.setShadowDefault()
                        worldBestScoreAlreadyShowed = true
                    } else {
                        ExternalFunctions.getWorldBestScore()
                    }
                }
            }
        }
    }
    // MARK: - Scene animations
    /** Run start scene animations*/
    private func runAnimations() {
        if SettingsGameProcess.Interface.Menu.sceneInterfaceAnimationOn {
            let buttonStartDefaultPosition = buttonStart.position
            buttonStart.position = CGPoint(x: -100, y: buttonStart.position.y)
            let buttonStartAnimation = SKAction.sequence([
                SKAction.scale(to: SettingsGameProcess.Interface.Menu.StartButton.scaleAtStart, duration: 0),
                SKAction.group([
                    SKAction.rotateByDegree(-360, duration: SettingsGameProcess.Interface.Menu.StartButton.rotationSpeed),
                    SKAction.moveTo(x: buttonStartDefaultPosition.x, duration: SettingsGameProcess.Interface.Menu.StartButton.rotationSpeed)]),
                SKAction.scale(to: 1.0, duration: SettingsGameProcess.Interface.Menu.StartButton.backToNormalTime)])
            let otherButtonAnimation = SKAction.sequence([
                SKAction.wait(forDuration: SettingsGameProcess.Interface.Menu.StartButton.rotationSpeed),
                SKAction.scale(to: SettingsGameProcess.Interface.Menu.buttonsScaleTo, duration: SettingsGameProcess.Interface.Menu.buttonsScaleTime / 2),
                SKAction.scale(to: 1.0, duration: SettingsGameProcess.Interface.Menu.buttonsScaleTime / 2)])
            buttonStart.run(buttonStartAnimation)
            buttonSettings.run(otherButtonAnimation)
        }
    }
    // MARK: - Input
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            touchDownButtons(atLocation: location)
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            ///Change button state to simple
            touchUpAllButtons()
            buttonStart.actionStartGame(ifInLocation: location)
            buttonSettings.actionChangeScene(ifInLocation: location, withTransition: .pushRight)            
        }
    }
}
