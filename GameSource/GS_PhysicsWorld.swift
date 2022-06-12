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
    /** Create physic world.*/
    func createPhysicsWorld() {
        /// Create gravity vector and add phisics world delegates to scene object
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
    }
    /** Its will be called when physicbody has contact.*/
    func didBegin(_ contact: SKPhysicsContact) {
        /// Get contact bodys
        let bodyFirst = contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask ? contact.bodyA : contact.bodyB
        let bodySecond = contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask ? contact.bodyB : contact.bodyA
        /// Recognise first body categorys
        switch bodyFirst.categoryBitMask {
        case SettingsPhysicsBody.Id.ball:
            guard let contactTo = bodySecond.node as? SKSpriteNode else {return}
            player(contactTo: contactTo, withContactPoint: contact.contactPoint)
        default:
            break
        }
    }
    // MARK: Different contact types by first body node
    fileprivate func player(contactTo contactNode: SKSpriteNode, withContactPoint contactPoint: CGPoint) {
        if circle.currentBall.isAvailableToContact {
            circle.currentBall.isAvailableToContact = false
            switch contactNode.physicsBody?.categoryBitMask {
            case SettingsPhysicsBody.Id.ballInRow:
                /// Contact with enemy
                setAnimationExplosion(toPosition: contactPoint)
                guard  let ballInRow = contactNode.parent as? BallNode else {
                    return
                }
                circle.ballCatch(ballInRow: ballInRow)
            default:
                break
            }
        }
    }
}
