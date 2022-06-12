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

// MARK: - Delegate
/** Delegate protocol for SwitchNode class. Switch node it's interface type object.*/
protocol BallNodeDelegate: class {
    /** Use it for compleate some action after changing switch state.*/
    func ballFinishedMovingWithoutCollision()
}

class BallNode: SimpleSprite {
    var delegate: BallNodeDelegate?
    var body = SimpleSprite(texture: GraphicPreloadsGame.preload.ball1, size: SettingsScenes.Game.Size.ball, position: .zero, zPosition: 0.1)
    let particleSystem = SKEmitterNode(fileNamed: "PlayerParticle.sks")
    var currentColor = 0
    var inRow = false
    var inMoveNow = false
    var isAvailableToContact = true
    // MARK: - Initialisations
    /** Initialisation of player node.*/
    init(withScene currentScene: GameScene?) {
        super.init(texture: GraphicPreloadsGame.preload.transparent, size: SettingsScenes.Game.Size.ball, position: SettingsScenes.Game.Position.ball, zPosition: SettingsScenes.Game.ZPosition.ball)
        addChild(body)
        if currentScene != nil {
            particleSystem?.targetNode = currentScene
            body.addChild(particleSystem!)
        }
        body.physicsBody = SKPhysicsBody(circleOfRadius: body.size.width / 2)
        body.physicsBody?.affectedByGravity = false
        body.physicsBody?.usesPreciseCollisionDetection = true
        body.physicsBody?.mass = 99999
        body.physicsBody?.categoryBitMask = SettingsPhysicsBody.Id.ball
        body.physicsBody?.collisionBitMask = SettingsPhysicsBody.Id.ball
        body.physicsBody?.contactTestBitMask = SettingsPhysicsBody.Id.ball
        animateCreation()
    }
    /** If your custom init function not can run compiler call this function.*/
    required init?(coder aDecoder: NSCoder) { fatalError("PlayerNode init(coder:) has not been implemented")}
    // MARK: - Ball state
    /** This function load current selected skin to player node.*/
    func setRandomColor() {
        set(color: Int(from: 1, to: 4))
    }
    func set(color byId: Int) {
        currentColor = byId
        refreshColor()
    }
    private func refreshColor() {
        switch currentColor {
        case 2: body.texture = GraphicPreloadsGame.preload.ball2
        case 3: body.texture = GraphicPreloadsGame.preload.ball3
        case 4: body.texture = GraphicPreloadsGame.preload.ball4
        default: body.texture = GraphicPreloadsGame.preload.ball1
        }
    }
    // MARK: - Your features
    func shoot(withSpeed speed: Double) {
        if !inMoveNow {
            inMoveNow = true
            body.run(SKAction.sequence([
                    SKAction.moveTo(y: SettingsScenes.Game.Position.ballFromCenter * 3, duration: speed),
                    SKAction.perform(#selector(shootIsFinished), onTarget: self)
            ]))
        }
    }
    @objc func shootIsFinished() {
        if delegate != nil {
            delegate?.ballFinishedMovingWithoutCollision()
        }
    }
    func setIsInstantInRow() {
        inRow = true
        body.physicsBody?.categoryBitMask = SettingsPhysicsBody.Id.ballInRow
        body.set(positionY: SettingsScenes.Game.Position.ballFromCenter)
    }
    func animateCreation() {
        body.run(SKAction.sequence([
                    SKAction.scale(to: 0.0, duration: 0.0),
                    SKAction.scale(to: 1.0, duration: 0.05)]))
    }
    func remove() {
        particleSystem?.isPaused = true
        body.physicsBody = nil
        body.run(SKAction.sequence([
                    SKAction.scale(to: 0.0, duration: 0.05),
                    SKAction.removeFromParent()]))
    }
}
