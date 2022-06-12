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
import AVFoundation

/**
 It's singletone class
 Use this class for playing some sound and music in game.
 It's already recognise current game settings and if user turn off sounds game will not played it.
 */
open class Sound {
    
    static let preload = Sound()
    private init() {}
    // MARK: - Sounds
    open var targetScene: SKScene?
    /** Enum with list of possible sounds.*/
    public enum Name {
        case buttonPress
        case tumblerClick
        case getPoint
        case getCoin
        case smash1
        case smash2
    }
    //Preloaded sounds action for scene
    internal let buttonPress = SKAction.playSoundFileNamed("buttonPress.mp3", waitForCompletion: false)
    internal let tumblerClick = SKAction.playSoundFileNamed("tumblerClick.mp3", waitForCompletion: false)
    internal let getPoint = SKAction.playSoundFileNamed("getPoint.mp3", waitForCompletion: false)
    internal let getCoin = SKAction.playSoundFileNamed("getCoin.mp3", waitForCompletion: false)
    internal let smash1 = SKAction.playSoundFileNamed("smash1.mp3", waitForCompletion: false)
    internal let smash2 = SKAction.playSoundFileNamed("smash2.mp3", waitForCompletion: false)
    /** It's interface for playing sounds.*/
    open func playSound(_ name: Name) {
        if UserDefaults.standard.bool(forKey: "PlaySounds") {
            switch name {
            case .buttonPress: targetScene?.run(Sound.preload.buttonPress)
            case .tumblerClick: targetScene?.run(Sound.preload.tumblerClick)
            case .getPoint: targetScene?.run(Sound.preload.getPoint)
            case .getCoin: targetScene?.run(Sound.preload.getCoin)
            case .smash1: targetScene?.run(Sound.preload.smash1)
            case .smash2: targetScene?.run(Sound.preload.smash2)
            }
        }
    }
    /** Change settings of sounds. Possible to play or not*/
    open func changeStateSound() { UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: "PlaySounds"), forKey: "PlaySounds")}
    // MARK: - Music
    public enum MusicTypes {
        case menu
        case game
    }
    private var musicPlayerMenu: AVAudioPlayer?
    private var musicPlayerGame: AVAudioPlayer?
    private var currentMusicType = MusicTypes.menu
    /**
     Create music and play it if it's possible by settings.
     Better for use in launch game part of app.
     */
    open func initMusic() {
        do {
            musicPlayerMenu = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "backgroundMenu.mp3", withExtension: nil)!)
            musicPlayerGame = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "backgroundGame.mp3", withExtension: nil)!)
            musicPlayerMenu!.numberOfLoops = -1
            musicPlayerGame!.numberOfLoops = -1
            musicPlayerMenu!.prepareToPlay()
            musicPlayerGame!.prepareToPlay()
            resumeMusic()
        } catch { Debugger.printNow(textToPrint: "Not can create AVAudioPlayer for music")}
    }
    /** Use this function for pause music in game*/
    func pauseMusic() {
        musicPlayerMenu!.pause()
        musicPlayerGame!.pause()
    }
    /** Use this function for resume music playing.*/
    func resumeMusic() {
            pauseMusic()
            switch currentMusicType {
            case .menu:
                if UserDefaults.standard.bool(forKey: "PlayMusicMenu") {
                    musicPlayerMenu!.play()
                }
            case .game:
                if UserDefaults.standard.bool(forKey: "PlayMusicGame") {
                    musicPlayerGame!.play()
                }
            }
    }
    func musicSwitch(toMusicType musicType: MusicTypes) {
        currentMusicType = musicType
        resumeMusic()
    }
    /**
     Change playing setting for music.
     If you change settings it's function make pause or contine to play music.
     */
    open func changeStateMusic(withType type: MusicTypes) {
        if type == .menu {
            UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: "PlayMusicMenu"), forKey: "PlayMusicMenu")
        }
        else {
            UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: "PlayMusicGame"), forKey: "PlayMusicGame")
        }
        resumeMusic()
    }
}
