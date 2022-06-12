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

    // MARK: - Animations
    /** Set coin animation move from position to indicator*/
    func setAnimationCoin(fromPosition position: CGPoint) {
        let positionToMoveCoin = interfaceHolder.convert(coinsIndicator.position, to: self)
        
        let coinAnimationNode = SimpleSprite(texture: GraphicPreloadsGame.preload.coin, size: SettingsScenes.Game.Size.coin, position: position, zPosition: SettingsScenes.Game.ZPosition.coin)
        addChild(coinAnimationNode)
        
        coinAnimationNode.run(SKAction.sequence([
            SKAction.move(to: positionToMoveCoin, duration: SettingsGameProcess.Coin.animationCatchSpeed),
            SKAction.removeFromParent()]))
    }
    /** Default explosion animation*/
    func setAnimationExplosion(toPosition positionToSet: CGPoint) {
        ///Get current count of explosion nodes
        let count = Int(from: SettingsGameProcess.Explosion.Count.from, to: SettingsGameProcess.Explosion.Count.to)
        for _ in 0..<count {
            ///Get stats for current node object
            let lifetime = Double(from: SettingsGameProcess.Explosion.Lifetime.from, to: SettingsGameProcess.Explosion.Lifetime.to)
            let scale = CGFloat(from: SettingsGameProcess.Explosion.Scale.from, to: SettingsGameProcess.Explosion.Scale.to)
            let moveToX = Bool.random() ? positionToSet.x + CGFloat(from: 0, to: SettingsGameProcess.Explosion.moveBy) : positionToSet.x - CGFloat(from: 0, to: SettingsGameProcess.Explosion.moveBy)
            let moveToY = Bool.random() ? positionToSet.y + CGFloat(from: 0, to: SettingsGameProcess.Explosion.moveBy) : positionToSet.y - CGFloat(from: 0, to: SettingsGameProcess.Explosion.moveBy)
            let moveTo = CGPoint(x: moveToX, y: moveToY)
            ///Create explosion node
            let object = SimpleSprite(texture: GraphicPreloadsGame.preload.explosion, size: SettingsScenes.Game.Size.explosion, position: positionToSet, zPosition: SettingsScenes.Game.ZPosition.explosion)
            object.setScale(scale)
            addChild(object)
            ///Run animation for explosion node
            object.run(SKAction.sequence([
                SKAction.group([
                    SKAction.scale(to: 0.0, duration: lifetime),
                    SKAction.move(to: moveTo, duration: lifetime)]),
                SKAction.removeFromParent()]))
        }
    }
}
