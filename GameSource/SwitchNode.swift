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
protocol SwitchNodeDelegate: class {
    /** Use it for compleate some action after changing switch state.*/
    func switchStateIsChanged(_ sender: SwitchNode)
}

// MARK: - Class
class SwitchNode: SimpleSprite {
    ///Value store switch state.
    var currentSwitchStateIsOn = false
    var itsFirstCreation = true
    var defaultDotOnPosition = CGPoint(x: 0, y: 0)
    var delegate: SwitchNodeDelegate?
    private var dot = SimpleSprite(texture: GraphicPreloadsInterface.preload.switch_Dot, size: CGSize(width: 0, height: 0), position: CGPoint(x: 0, y: 0), zPosition: 1)
    // MARK: - Initialistions
    /**
     Initialisation of switch node.
     - parameter textureOnState: SKTexture object of texture switch in on state.
     - parameter textureOffState: SKTexture object of texture switch in off state.
     - parameter size: CGSize object with size of node.
     - parameter position: CGPoint object for set position node on scene.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(texture: SKTexture, size: CGSize, position: CGPoint, zPosition: CGFloat, textureDot: SKTexture, sizeDot: CGSize, positionDot: CGPoint, zPositionDot: CGFloat) {
        super.init(texture: texture, size: size, position: position, zPosition: zPosition)
        dot = SimpleSprite(texture: textureDot, size: sizeDot, position: positionDot, zPosition: zPositionDot)
        if SettingsGlobal.isIPad {
            self.size = CGSize(width: self.size.width * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object,
                               height: self.size.height * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object)
            dot.size = CGSize(width: dot.size.width * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object,
                               height: dot.size.height * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object)
            dot.position = CGPoint(x: positionDot.x * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object,
                                  y: positionDot.y * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object)
        }
        addChild(dot)
        defaultDotOnPosition = dot.position
    }
    /**
     Initialisation of switch node.
     - parameter textureOnState: SKTexture object of texture switch in on state.
     - parameter textureOffState: SKTexture object of texture switch in off state.
     - parameter size: CGSize object with size of node.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(texture: SKTexture, size: CGSize, zPosition: CGFloat, textureDot: SKTexture, sizeDot: CGSize, positionDot: CGPoint, zPositionDot: CGFloat) {
        super.init(texture: texture, size: size, zPosition: zPosition)
        dot = SimpleSprite(texture: textureDot, size: sizeDot, position: positionDot, zPosition: zPositionDot)
        if SettingsGlobal.isIPad {
            self.size = CGSize(width: self.size.width * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object,
                               height: self.size.height * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object)
            dot.size = CGSize(width: dot.size.width * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object,
                               height: dot.size.height * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object)
            dot.position = CGPoint(x: positionDot.x * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object,
                                  y: positionDot.y * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object)
        }
        addChild(dot)
        defaultDotOnPosition = dot.position
    }
    /** If your custom init function not can run compiler call this function*/
    required init?(coder aDecoder: NSCoder) { fatalError("ButtonNode init(coder:) has not been implemented")}
    // MARK: - Switch Logic
    /** Private function for update texture by current state*/
    private func updateSwitchDotPosition() {
        let moveTo = currentSwitchStateIsOn ? defaultDotOnPosition : CGPoint(x: -defaultDotOnPosition.x, y: defaultDotOnPosition.y)
        let alphaSet = currentSwitchStateIsOn ? SettingsGameProcess.Interface.Switch.Alpha.on : SettingsGameProcess.Interface.Switch.Alpha.off
        if itsFirstCreation {
            itsFirstCreation = false
            dot.position = moveTo
            dot.alpha = alphaSet
        }
        else {
            dot.run(SKAction.group([
                SKAction.sequence([
                    SKAction.scale(to: SettingsGameProcess.Interface.Switch.ChangeStateAnimation.scaleTo, duration: SettingsGameProcess.Interface.Switch.ChangeStateAnimation.speed / 2),
                    SKAction.scale(to: 1.0, duration: SettingsGameProcess.Interface.Switch.ChangeStateAnimation.speed / 2)]),
                SKAction.move(to: moveTo, duration: SettingsGameProcess.Interface.Switch.ChangeStateAnimation.speed),
                SKAction.fadeAlpha(to: alphaSet, duration: SettingsGameProcess.Interface.Switch.ChangeStateAnimation.speed)]))
        }
    }
    /** Change switch state. You can use delegate method for realise some action after changing state some atribut.*/
    func changeSwitchState() {
        currentSwitchStateIsOn = !currentSwitchStateIsOn
        updateSwitchDotPosition()
        Sound.preload.playSound(.tumblerClick)
        ///Send message for delegate method. If current switch object have delegate.
        if delegate != nil { delegate?.switchStateIsChanged(self)}
    }
    /** Call this function for recognise current touch is contains to this switch*/
    func changeSwitchState(ifInLocation location: CGPoint) {
        if contains(location) {
            changeSwitchState()
        }
    }
    /** Set switch state. It's method for setting start state of switch if you load new scene*/
    func setSwitchState(_ isOn: Bool) {
        currentSwitchStateIsOn = isOn
        updateSwitchDotPosition()
    }
}
