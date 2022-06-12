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

class ButtonNode: SimpleSprite {
    
    enum ButtonType {
        case start
        case settings
        case back
        case menu
        case restart
        case pause
        case pcontinue
        case skinNext
        case skinPrevious
        case panelResultClose
    }
    
    //Value store button state
    var currentButtonStateIsPressed = false
    var itsForChangingSceneButton: Bool = false
    var changeToSceneName: GlobalScene.SceneName = .menu
    var defaultSize: CGSize = CGSize(width: 0, height: 0)
    var label = SimpleLabel(text: "", fontSize: 14, fontColorHex: "#ffffff", position: CGPoint.zero, zPosition: 1)
    // MARK: - Initialistions
    /**
     Initialisation of button node
     - parameter textureSimpleState: SKTexture object of texture button in up state.
     - parameter texturePressedState: SKTexture object of texture button in pressed state.
     - parameter size: CGSize object with size of node.
     - parameter position: CGPoint object for set position node on scene.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    override init(texture: SKTexture, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(texture: texture, size: size, position: position, zPosition: zPosition)
        defaultSize = size
        
        if SettingsGlobal.isIPad {
            self.size = CGSize(width: defaultSize.width * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object,
                               height: defaultSize.height * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object)
        }
    }
    /**
     Initialisation of button node
     - parameter textureSimpleState: SKTexture object of texture button in up state.
     - parameter texturePressedState: SKTexture object of texture button in pressed state.
     - parameter size: CGSize object with size of node.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    override init(texture: SKTexture, size: CGSize, zPosition: CGFloat) {
        super.init(texture: texture, size: size, zPosition: zPosition)
        defaultSize = size
        if SettingsGlobal.isIPad {
            self.size = CGSize(width: defaultSize.width * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object,
                               height: defaultSize.height * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object)
        }
    }
    /**
     Initialisation of button node for changing scene
     - parameter textureSimpleState: SKTexture object of texture button in up state.
     - parameter texturePressedState: SKTexture object of texture button in pressed state.
     - parameter size: CGSize object with size of node.
     - parameter position: CGPoint object for set position node on scene.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(texture: SKTexture, size: CGSize, position: CGPoint, zPosition: CGFloat, changeToScene: GlobalScene.SceneName) {
        super.init(texture: texture, size: size, position: position, zPosition: zPosition)
        defaultSize = size
        if SettingsGlobal.isIPad {
            self.size = CGSize(width: defaultSize.width * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object,
                               height: defaultSize.height * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object)
        }
        itsForChangingSceneButton = true
        changeToSceneName = changeToScene
    }
    
    /**
     Initialisation of button node for changing scene
     - parameter textureSimpleState: SKTexture object of texture button in up state.
     - parameter texturePressedState: SKTexture object of texture button in pressed state.
     - parameter size: CGSize object with size of node.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(texture: SKTexture, size: CGSize, zPosition: CGFloat, changeToScene: GlobalScene.SceneName) {
        super.init(texture: texture, size: size, zPosition: zPosition)
        defaultSize = size
        if SettingsGlobal.isIPad {
            self.size = CGSize(width: defaultSize.width * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object,
                               height: defaultSize.height * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object)
        }
        itsForChangingSceneButton = true
        changeToSceneName = changeToScene
    }
    /** Initialise default buttons all settings will be loaded automatically*/
    init(defaultWithType type: ButtonType) {
        super.init(texture: GraphicPreloadsInterface.preload.button_Pressed, size: CGSize(width: 0, height: 0), position: CGPoint(x: -10, y: -10), zPosition: -100)
        defaultSize = size
        loadSettings(bySceneName: GlobalScene.getCurrentLoadedScene(), andButtonType: type)
    }
    /** If your custom init function not can run compiler call this function*/
    required init?(coder aDecoder: NSCoder) { fatalError("ButtonNode init(coder:) has not been implemented")}
    // MARK: - Button Label
    func setLabel(withText text: String, andFontSize fontSize: CGFloat, andFontColor fontColor: String, andPosition positionToSet: CGPoint) {
        addChild(label)
        label.verticalAlignmentMode = .baseline
        label.text = text
        label.fontSize = fontSize
        label.fontColor = UIColor(hexString: fontColor)
        label.position = positionToSet
    }
    // MARK: - Button Logic
    /** Private function for animate button by current state*/
    fileprivate func updateButtonStateAnimation() {
        ///Fade
        if SettingsGameProcess.Interface.Button.Fade.on {
            let fadeTo = currentButtonStateIsPressed ? SettingsGameProcess.Interface.Button.Fade.fadeTo : 1.0
            run(SKAction.fadeAlpha(to: fadeTo, duration: SettingsGameProcess.Interface.Button.Fade.speed))
        }
        ///Scaing
        if SettingsGameProcess.Interface.Button.Scaling.on {
            let scaleTo = currentButtonStateIsPressed ? SettingsGameProcess.Interface.Button.Scaling.scaleTo : 1.0
            run(SKAction.scale(to: scaleTo, duration: SettingsGameProcess.Interface.Button.Scaling.speed))
        }
    }
    /** Call this function if user press on button*/
    func touchDown() {
        currentButtonStateIsPressed = true
        updateButtonStateAnimation()
    }
    /** Call this function for recognise current touch contains for this button, and make some actions if yes.*/
    func touchDown(ifInLocation location: CGPoint) { if contains(location) { touchDown()}}
    /** Call this function if user cancel pressed on button*/
    func touchUp() {
        if currentButtonStateIsPressed {
            currentButtonStateIsPressed = false
            Sound.preload.playSound(.buttonPress)
            updateButtonStateAnimation()
        }
    }
    /** Remove current cutton from view for make is not possible miss clicks*/
    func removeFromViewedPoint() { position = CGPoint(x: -9999999, y: -9999999)}
}
