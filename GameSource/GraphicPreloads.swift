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

// MARK: - Game Scene
/**
 Singletone class
 This class need to preload texture files for better perfomence in game.
 Becouse creating new SKTexture objects requared many device recources.
 Also if we make many objects with same texture we can use one SKTexture object for use less device memories.
 If preloads we create one texture and can use it at many objects
    - Precondition: For getting preloads textures from this class use command like: GraphicPreloadsGame.preload.player1
 */
class GraphicPreloadsGame {
    private static var _preload: GraphicPreloadsGame?
    static var preload: GraphicPreloadsGame {
        if _preload == nil {
            _preload = GraphicPreloadsGame()
            Debugger.printNow(textToPrint: "Compleate loading graphic files for game scene")
        }
        return _preload!
    }
    internal let transparent = SKTexture(сonsideringFiltrationSettingsInProject: "transparent")
    // MARK: Preloaded textures
    internal let background = SKTexture(сonsideringFiltrationSettingsInProject: "backgroundGame")
    internal let pauseBackground = SKTexture(сonsideringFiltrationSettingsInProject: "pauseBackground")
    internal let ball1 = SKTexture(сonsideringFiltrationSettingsInProject: "ball1")
    internal let ball2 = SKTexture(сonsideringFiltrationSettingsInProject: "ball2")
    internal let ball3 = SKTexture(сonsideringFiltrationSettingsInProject: "ball3")
    internal let ball4 = SKTexture(сonsideringFiltrationSettingsInProject: "ball4")
    internal let explosion = SKTexture(сonsideringFiltrationSettingsInProject: "explosion")
    internal let circle = SKTexture(сonsideringFiltrationSettingsInProject: "circle")
    internal let coin = SKTexture(сonsideringFiltrationSettingsInProject: "coin")
}

// MARK: - Other scenes "Interface"
/**
Singletone class
This class need to preload texture files for better perfomence in game.
Becouse creating new SKTexture objects requared many device recources.
Also if we make many objects with same texture we can use one SKTexture object for use less device memories.
If preloads we create one texture and can use it at many objects
    - Precondition: For getting preloads textures from this class use command like: GraphicPreloadsInterface.preload.buttonStart
*/
class GraphicPreloadsInterface {
    private static var _preload: GraphicPreloadsInterface?
    static var preload: GraphicPreloadsInterface {
        if _preload == nil {
            _preload = GraphicPreloadsInterface()
            Debugger.printNow(textToPrint: "Compleate loading interface graphic files")
        }
        return _preload!
    }
    internal let transparent = SKTexture(сonsideringFiltrationSettingsInProject: "transparent")
    // MARK: Preloaded textures
    internal let background = SKTexture(сonsideringFiltrationSettingsInProject: "background")
    internal let background_TutorialScene = SKTexture(сonsideringFiltrationSettingsInProject: "background_TutorialScene")
    internal let logo = SKTexture(сonsideringFiltrationSettingsInProject: "logo")
    internal let coinsIndicator = SKTexture(сonsideringFiltrationSettingsInProject: "coinsIndicator")
    internal let switch_Body = SKTexture(сonsideringFiltrationSettingsInProject: "switch_Body")
    internal let switch_Dot = SKTexture(сonsideringFiltrationSettingsInProject: "switch_Dot")
    internal let button_Back = SKTexture(сonsideringFiltrationSettingsInProject: "button_Back")
    internal let button_Menu = SKTexture(сonsideringFiltrationSettingsInProject: "button_Menu")
    internal let button_Pressed = SKTexture(сonsideringFiltrationSettingsInProject: "button_Pressed")
    internal let button_Restart = SKTexture(сonsideringFiltrationSettingsInProject: "button_Restart")
    internal let button_RestartPause = SKTexture(сonsideringFiltrationSettingsInProject: "button_RestartPause")
    internal let button_Settigns = SKTexture(сonsideringFiltrationSettingsInProject: "button_Settings")
    internal let button_Start = SKTexture(сonsideringFiltrationSettingsInProject: "button_Start")
    internal let button_StartPressed = SKTexture(сonsideringFiltrationSettingsInProject: "button_StartPressed")
    internal let button_Continue = SKTexture(сonsideringFiltrationSettingsInProject: "button_Continue")
    internal let button_Pause = SKTexture(сonsideringFiltrationSettingsInProject: "button_Pause")
    internal let button_PausePressed = SKTexture(сonsideringFiltrationSettingsInProject: "button_PausePressed")
    internal let button_SkinNext = SKTexture(сonsideringFiltrationSettingsInProject: "button_SkinNext")
    internal let button_SkinPrevious = SKTexture(сonsideringFiltrationSettingsInProject: "button_SkinPrevious")
    internal let button_SkinSelector = SKTexture(сonsideringFiltrationSettingsInProject: "button_SkinSelector")
    internal let panelBuyResultBackground = SKTexture(сonsideringFiltrationSettingsInProject: "panelBuyResultBackground")
    internal let panelBuyResult = SKTexture(сonsideringFiltrationSettingsInProject: "panelBuyResult")
    internal let button_BuyResultClose = SKTexture(сonsideringFiltrationSettingsInProject: "button_BuyResultClose")
    internal let skin1 = SKTexture(сonsideringFiltrationSettingsInProject: "player1")
    internal let skin2 = SKTexture(сonsideringFiltrationSettingsInProject: "player2")
    internal let skin3 = SKTexture(сonsideringFiltrationSettingsInProject: "player3")
    internal let skin4 = SKTexture(сonsideringFiltrationSettingsInProject: "player4")
}
