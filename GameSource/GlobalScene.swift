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

class GlobalScene: SKScene {
    
    /** It's enum with all scenes in game. You can add some new scenes, and case to this enum. Also you need to decribe you scene like same in getScene() function.*/
    enum SceneName: Int {
        case menu = 0
        case settings = 2
        case game = 4
        case end = 5
    }
    /** It's enum with all possible animations for transition scene. You can add new case, after it you need describe this transition in getSceneTransition() function.*/
    enum TransitionName {
        case fade
        case pushUp
        case pushDown
        case pushLeft
        case pushRight
        case moveUp
        case moveDown
        case moveLeft
        case moveRight
        case without
    }
    /** Thats array store all buttons on current scene. We use it when we try to touch up buttons.*/
    fileprivate var arrayWithButtons = [ButtonNode]()
    // MARK: - Make screenshot
    /**
     This function make screenshot of you game scene. In default it's use for sharing function.
     - returns: This function save compleate screenshot in NSUserDefuaults by key "ScreenShot", you can get it by this key.
     */
    func makeScreenshot() {
        ///Create the image
        UIGraphicsBeginImageContext(CGSize(width: frame.size.width, height: frame.size.height))
        view?.drawHierarchy(in: frame, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        ///Save screen shot
        UserDefaults.standard.set(image!.pngData(), forKey: "ScreenShot")
    }
    // MARK: - Scenes controller
    /**
     Current function helped to you with changing scenes during game.
     - parameter nameScene: It's name of scene what you need to go, it's enum object decribed in GlobalScene.
     - parameter nameTransition: It's name of type changing your game scene. You can see all animations in GlobalScene.
     */
    func loadScene(_ nameScene: SceneName, withTransitionName nameTransition: TransitionName) {
        ///Save current loaded scene
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "_currentSceneLoaded"), forKey: "_previousSceneLoaded")
        UserDefaults.standard.set(nameScene.rawValue, forKey: "_currentSceneLoaded")
        ///Create scene and transition
        let scene = getScene(nameScene)
        let transition = getSceneTransition(nameTransition)
        ///Load scene components
        Sound.preload.targetScene = scene
        ///Show new scene
        if transition != nil { view?.presentScene(scene, transition: transition!)}
        else { view?.presentScene(scene)}
        ///Clean old scene after show new
        Timer.scheduledTimer(timeInterval: SettingsGlobal.WorkWithScenes.speedOfChangeScene, target: self, selector: #selector(cleanOldScene), userInfo: nil, repeats: false)
    }
    /**
     Current function get scene from SceneName enum.
     - parameter name: It's scene name from enum SceneName.
     - returns: SKScene object for change scene.
     */
    fileprivate func getScene(_ name: SceneName) -> SKScene {
        switch name {
        case .menu: return MenuScene(size: size)
        case .settings: return SettingsScene(size: size)
        case .game: return GameScene(size: size)
        case .end: return EndScene(size: size)
        }
    }
    /**
     Current function get transition from TransionName enum.
     - parameter name: It's transition name from enum TransitionName.
     - returns: SKTransition object with animation for change scene.
     */
    fileprivate func getSceneTransition(_ name: TransitionName) -> SKTransition? {
        switch name {
        case .fade: return SKTransition.fade(withDuration: SettingsGlobal.WorkWithScenes.speedOfChangeScene)
        case .pushUp: return SKTransition.push(with: SKTransitionDirection.up, duration: SettingsGlobal.WorkWithScenes.speedOfChangeScene)
        case .pushDown: return SKTransition.push(with: SKTransitionDirection.down, duration: SettingsGlobal.WorkWithScenes.speedOfChangeScene)
        case .pushLeft: return SKTransition.push(with: SKTransitionDirection.left, duration: SettingsGlobal.WorkWithScenes.speedOfChangeScene)
        case .pushRight: return SKTransition.push(with: SKTransitionDirection.right, duration: SettingsGlobal.WorkWithScenes.speedOfChangeScene)
        case .moveUp: return SKTransition.moveIn(with: SKTransitionDirection.up, duration: SettingsGlobal.WorkWithScenes.speedOfChangeScene)
        case .moveDown: return SKTransition.moveIn(with: SKTransitionDirection.down, duration: SettingsGlobal.WorkWithScenes.speedOfChangeScene)
        case .moveLeft: return SKTransition.moveIn(with: SKTransitionDirection.left, duration: SettingsGlobal.WorkWithScenes.speedOfChangeScene)
        case .moveRight: return SKTransition.moveIn(with: SKTransitionDirection.right, duration: SettingsGlobal.WorkWithScenes.speedOfChangeScene)
        default: return nil
        }
    }
    /** Call this for get current loaded scene*/
    public static func getCurrentLoadedScene() -> GlobalScene.SceneName {
        return GlobalScene.SceneName(rawValue: UserDefaults.standard.integer(forKey: "_currentSceneLoaded"))!
    }
    public static func getPreviousLoadedScene() -> GlobalScene.SceneName {
        return GlobalScene.SceneName(rawValue: UserDefaults.standard.integer(forKey: "_previousSceneLoaded"))!
    }
    /** Call this for compare scenes*/
    public static func nowLoaded(sceneName name: GlobalScene.SceneName) -> Bool {
        return name == getCurrentLoadedScene() ? true : false
    }
    /** This function helped to clean old scene from something nodes and actions*/
    @objc func cleanOldScene() {
        removeAllChildren()
        removeAllActions()
        removeFromParent()
        Debugger.printNow(textToPrint: "Old scene is been cleaned")
    }
    // MARK: - Custom Add Child
    /** This func can help you add nodes from array to your scene.*/
    func addChild(_ nodes: [SKNode]) {
        for value in nodes {
            if value.isKind(of: ButtonNode.self) {
                guard let buttonNode = value as? ButtonNode else {return}
                addChild(buttonNode)

            }
            else { addChild(value)}
        }
    }
    /** Current function helped with adding new buttons to scene. It's store all buttons in array.*/
    func addChild(_ button: ButtonNode) {
        arrayWithButtons.append(button)
        super.addChild(button)
    }
    // MARK: - Buttons touch
    /** We can call this func for change all buttons state on scene to simple.*/
    func touchUpAllButtons() {
        for button in arrayWithButtons { button.touchUp()}
    }
    /** Touch down button at location.*/
    func touchDownButtons(atLocation location: CGPoint) {
        for button in arrayWithButtons { button.touchDown(ifInLocation: location)}
    }
}
