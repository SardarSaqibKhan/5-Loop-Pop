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
protocol SkinsHolderNodeDelegate: class {
    /** Use it for compleate some action after changing switch state.*/
    func skinHolderBuyResult(isSuccessfully successfully: Bool)
}

class SkinsHolderNode: TransparentSprite {
    // MARK: - Values
    let basicPosition = SettingsScenes.Store.Position.skinHolder
    let skinShiftX = SettingsScenes.Store.Position.skinHolderSkinShift
    let skinShiftY = SettingsScenes.Store.Position.skinHolderSkinShiftNonSelectedByY
    var skins = [SimpleSprite]()
    var skinHolder = TransparentSprite(position: CGPoint(x: 0, y: 0), zPosition: 0.1)
    var nowSelectedSkin = 0
    var delegate: SkinsHolderNodeDelegate?
    
    // MARK: - Initialisation
    /**
     Initialise node
     - parameter imageName: String value with name of image for node.
     - parameter size: CGSize object for set size of node.
     - parameter position: CGPoint object for set position node on scene.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init() {
        super.init(position: SettingsScenes.Store.Position.skinHolder, zPosition: SettingsScenes.Store.ZPosition.skinHolder)
        addChild(skinHolder)
        loadSkins()
        nowSelectedSkin = UserDefaults.standard.integer(forKey: "CurrentSkin") - 1
        showAtStart()
        updateState()
    }
    /** If your custom init function not can run compiler call this function*/
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleSprite init(coder:) has not been implemented")}
    // MARK: - Work with holder
    /** Load stats for current skin. Size, texture and other stats.*/
    func loadSkins() {
        for i in 0..<SkinValues.textures.count {
            let currentSkinTexture = SkinValues.textures[i]
            let currentSkinSize = SkinValues.size[i]
            let skin = SimpleSprite(texture: currentSkinTexture, size: currentSkinSize, position: CGPoint(x: skinShiftX * CGFloat(i), y: 0), zPosition: 1)
            skinHolder.addChild(skin)
            skins.append(skin)
        }
    }
    /** Update state for this current skin node. Move to correct position in interface set right scale and other stats.*/
    func updateState() {
        removeActionsFromSkins()
        move()
        changeSkinSizes()
        changeSkinPositionsY()
        animateCurrentSelectedSkin()
    }
    
    // MARK: - Animations
    /** Animation moving to right position.*/
    func move() {
        let newXPosition = getPositionXForCurrentSelectedSkin()
        skinHolder.run(SKAction.moveTo(x: newXPosition, duration: SettingsGameProcess.Interface.Store.moveSkinsSpeed))
    }
    
    /** Set corrent size for current skin in interface.*/
    func changeSkinSizes() {
        for i in 0...skins.count - 1 {
            let currentSkinScale = i == nowSelectedSkin ? SettingsGameProcess.Interface.Store.currentSkinScale : SettingsGameProcess.Interface.Store.backgroundSkinScale
            skins[i].run(SKAction.scale(to: currentSkinScale, duration: SettingsGameProcess.Interface.Store.changeSkinsScaleSpeed))
        }
    }
    /** Set correct position for skins by y in interface.*/
    func changeSkinPositionsY() {
        for i in 0...skins.count - 1 {
            var positionY = CGFloat(i - nowSelectedSkin) * skinShiftY
            if positionY < 0 { positionY *= -1}
            skins[i].run(SKAction.moveTo(y: positionY, duration: SettingsGameProcess.Interface.Store.changeYPositionSpeed))
        }
    }
    /** Remove actions from all skins*/
    func removeActionsFromSkins() {
        for i in 0...skins.count - 1 {
            skins[i].zRotation = 0
            skins[i].removeAllActions()
        }
    }
    /** Run animation for current selected skin*/
    func animateCurrentSelectedSkin() {
        skins[nowSelectedSkin].run(SKAction.sequence([
            SKAction.rotateToDegree(-SettingsGameProcess.Interface.Store.AnimateSelectedSkin.rotateToDegree, duration: SettingsGameProcess.Interface.Store.AnimateSelectedSkin.time / 2),
            SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.rotateToDegree(SettingsGameProcess.Interface.Store.AnimateSelectedSkin.rotateToDegree, duration: SettingsGameProcess.Interface.Store.AnimateSelectedSkin.time),
                    SKAction.rotateToDegree(-SettingsGameProcess.Interface.Store.AnimateSelectedSkin.rotateToDegree, duration: SettingsGameProcess.Interface.Store.AnimateSelectedSkin.time)]))]))
    }
    
    /** Run animation at start.*/
    func showAtStart() {
        position = CGPoint(x: basicPosition.x, y: SettingsGlobal.height * 1.5)
        run(SKAction.moveTo(y: basicPosition.y, duration: SettingsGameProcess.Interface.Store.timeToShowSkinHolderAtStart))
    }
    // MARK: - Get some values
    /**
     Get position x for current selected skin.
     - returns: Value with position of current selected skin.
     */
    func getPositionXForCurrentSelectedSkin() -> CGFloat { return -(skinShiftX * CGFloat(nowSelectedSkin))}
    // MARK: - Change skin
    /** Go to next skin*/
    func selectNextSkin() {
        if nowSelectedSkin + 1 <= skins.count - 1 {
            nowSelectedSkin += 1
            updateState()
        }
    }
    
    /** Go to previous skin*/
    func selectPreviousSkin() {
        if nowSelectedSkin - 1 >= 0 {
            nowSelectedSkin -= 1
            updateState()
        }
    }
}
