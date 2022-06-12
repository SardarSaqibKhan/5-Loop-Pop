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

class GameScene: GlobalScene, SKPhysicsContactDelegate, CircleNodeDelegate {
    // MARK: Values
    var isPlay = false
    var score = 0
    var currentLevel = 1
    var circleSpeed = SettingsGameProcess.Circle.Speed.start
    var ballSpeed = SettingsGameProcess.Ball.Speed.start
    var changeSceneToMenuInPauseMenu = true
    
    // MARK: Recognisers
    var swipeLeft: UISwipeGestureRecognizer?
    var swipeRight: UISwipeGestureRecognizer?
    var swipeDown: UISwipeGestureRecognizer?
    var swipeUp: UISwipeGestureRecognizer?
    // MARK: Nodes
    var currentCamera: SKCameraNode = SKCameraNode()
    var background = BackgroundNode()
    var pauseBackground = SimpleSprite(texture: GraphicPreloadsGame.preload.pauseBackground, size: SettingsScenes.Game.Size.pauseBackground, position: SettingsScenes.Game.Position.pauseBackground, zPosition: SettingsScenes.Game.ZPosition.pauseBackground)
    var interfaceHolder = TransparentSprite(size: SettingsScenes.Game.Size.interfaceHolder, position: SettingsScenes.Game.Position.interfaceHolder, zPosition: SettingsScenes.Game.ZPosition.interfaceHolder)

    var coinsIndicator = SimpleSprite(texture: GraphicPreloadsInterface.preload.coinsIndicator, size: SettingsScenes.Game.Size.coinsIndicator, position: SettingsScenes.Game.Position.coinsIndicator, zPosition: SettingsScenes.Game.ZPosition.coinsIndicator)
    var buttonPause = ButtonNode(defaultWithType: .pause)
    var buttonRestart = ButtonNode(defaultWithType: .restart)
    var buttonMenu = ButtonNode(defaultWithType: .menu)
    var buttonContinue = ButtonNode(defaultWithType: .pcontinue)
    var labelScore = SimpleLabel(text: "0", fontSize: SettingsScenes.Game.FontSize.labelScore, fontColorHex: SettingsScenes.Game.FontColor.labelScore, position: SettingsScenes.Game.Position.labelScoreNoCoins, zPosition: SettingsScenes.Game.ZPosition.labelScore)
    var labelCoins = SimpleLabel(text: String(UserDefaults.standard.integer(forKey: "Coins")), fontSize: SettingsScenes.Game.FontSize.labelCoins, fontColorHex: SettingsScenes.Game.FontColor.labelCoins, position: SettingsScenes.Game.Position.labelCoins, zPosition: SettingsScenes.Game.ZPosition.labelCoins)
    var labelLevel = SimpleLabel(text: NSLocalizedString("gameScene_labelLevel", comment: "") + "1", fontSize: SettingsScenes.Game.FontSize.labelLevel, fontColorHex: SettingsScenes.Game.FontColor.labelLevel, position: SettingsScenes.Game.Position.labelLevel, zPosition: SettingsScenes.Game.ZPosition.labelLevel)
    var textPause = LogoSmallNode(withType: .pause)
    var circle = CircleNode(withScene: nil)
    // MARK: - Scene life cycle
    override func didMove(to view: SKView) {
        ///Init game components
        currentCamera = SKCameraNode()
        camera = currentCamera
        currentCamera.position = CGPoint(x: SettingsGlobal.width / 2, y: SettingsGlobal.height / 2)
        addChild(currentCamera)
        
        labelScore.setShadowDefault()
        labelLevel.setShadowDefault()
        ///Init gestures
        swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(inputSwipeLeft))
        swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(inputSwipeRight))
        swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(inputSwipeDown))
        swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(inputSwipeUp))
        swipeLeft?.direction = UISwipeGestureRecognizer.Direction.left
        swipeRight?.direction = UISwipeGestureRecognizer.Direction.right
        swipeDown?.direction = UISwipeGestureRecognizer.Direction.down
        swipeUp?.direction = UISwipeGestureRecognizer.Direction.up
        view.addGestureRecognizer(swipeLeft!)
        view.addGestureRecognizer(swipeRight!)
        view.addGestureRecognizer(swipeDown!)
        view.addGestureRecognizer(swipeUp!)
        ///Switch music
        Sound.preload.musicSwitch(toMusicType: .game)
        ///Set game
        setInterface()
        createPhysicsWorld()
        ///Start game
        gameStart()
    }
    // MARK: - Game progress
    /** Start game object. Prepare your game object here*/
    fileprivate func gameStart() {
        isPlay = true
        setCircle()
    }
    /** End game method. Save all game results here. */
    func gameOver() {
        if isPlay {
            isPlay = false
            saveScore()
            makeScreenshot()
            view?.gestureRecognizers?.forEach((view?.removeGestureRecognizer)!)
            loadSceneEndWithDelay()
        }
    }
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
    }
    override func didFinishUpdate() {
        ///Follow interface to camera
        if SettingsGameProcess.followCameraToPlayer {
            /*let positionCameraX = SettingsGameProcess.followCameraToPlayerByX ? player.position.x : SettingsGlobal.width / 2
            let positionCameraY = SettingsGameProcess.followCameraToPlayerByY ? player.position.y + ((SettingsGlobal.height / 2) - SettingsScenes.Game.Position.player.y) : SettingsGlobal.height / 2
            let positionCamera = CGPoint(x: positionCameraX, y: positionCameraY)
            
            camera!.position = positionCamera
            interfaceHolder.position = CGPoint(x: currentCamera.position.x - SettingsGlobal.width / 2, y: currentCamera.position.y - SettingsGlobal.height / 2)
            background.position = camera!.position*/
        }
    }
    // MARK: - Inputs
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isPlay {
            for touch in touches {
                //let location = touch.location(in: self)
                let locationInterfaceHolder = touch.location(in: interfaceHolder)
                ///Game inputs
                if !buttonPause.contains(locationInterfaceHolder) && !buttonMenu.contains(locationInterfaceHolder) && !buttonRestart.contains(locationInterfaceHolder) && !buttonContinue.contains(locationInterfaceHolder) {
                    circle.tryToShoot(withSpeed: ballSpeed)
                }
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            ///let location = touch.location(in: self)
            let locationInterfaceHolder = touch.location(in: interfaceHolder)
            ///Interface
            ///Change button state to simple
            touchUpAllButtons()
            if buttonPause.contains(locationInterfaceHolder) {
                pauseGame()
            }
            if scene?.view?.isPaused == true {
                if buttonMenu.contains(locationInterfaceHolder) {
                    continueGame()
                    changeSceneAfterPause(toMenu: true)
                }
                if buttonRestart.contains(locationInterfaceHolder) {
                    continueGame()
                    changeSceneAfterPause(toMenu: false)
                }
                if buttonContinue.contains(locationInterfaceHolder) {
                    continueGame()
                }
            }
        }
    }
    // MARK: Swipe inputs
    @objc func inputSwipeLeft() {
        if isPlay {
        }
    }
    @objc func inputSwipeRight() {
        if isPlay {
        }
    }
    @objc func inputSwipeDown() {
        if isPlay {
        }
    }
    @objc func inputSwipeUp() {
        if isPlay {
        }
    }
}
