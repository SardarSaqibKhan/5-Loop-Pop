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

struct SettingsScenes {

    // MARK: - Global Scene Settings
    struct Global {
        struct FontColor {
            static let leaberboardCellText = "#c2ad96"
            static let leaberboardBackgroundAlpha: CGFloat = 0.35 //From 0.0 to 1.0
            static let leaberboardBackground = "#ffffff"
        }
    }
    // MARK: - Game Scene Settings
    struct Game {
        struct Size {
            static let background = CGSize.withPercent(100, height: 100)
            static let interfaceHolder = CGSize.withPercent(200, height: 200)
            static let pauseBackground = CGSize.withPercent(100, height: 100)
            static let coinsIndicator = CGSize.withPercentScaled(4, height: 4)
            static let buttonPause = CGSize.withPercentScaled(roundByWidth: 10)
            static let buttonRestart = CGSize.withPercentScaled(roundByWidth: 10)
            static let buttonMenu = CGSize.withPercentScaled(roundByWidth: 10)
            static let buttonContinue = CGSize.withPercentScaled(roundByWidth: 12)
            static let ball = CGSize.withPercentScaled(8.4, height: 8.4)
            static let circle = CGSize.withPercentScaled(85.2, height: 85.2)
            static let explosion = CGSize.withPercentScaled(roundByWidth: 1)
            static let coin = CGSize.withPercentScaled(roundByWidth: 5)
        }
        struct Position {
            static let background = CGPoint.withPercent(50, y: 50)
            static let interfaceHolder = CGPoint.withPercent(0, y: 0)
            static let pauseBackground = CGPoint.withPercent(50, y: 50)
            static let coinsIndicator = CGPoint.withPercent(84, y: 90)
            static let buttonPause = CGPoint.withPercent(10, y: 90)
            static let button_Restart_Menu_Continue = CGPoint.withPercent(50, y: 50)
            static let space_Button_Restart_Menu_Continue = SettingsGlobal.width * 0.0175
            static let labelScoreWithCoins = CGPoint.withPercent(50, y: 90)
            static let labelScoreNoCoins = CGPoint.withPercent(86, y: 90)
            static let labelCoins = CGPoint.withPercent(86.5, y: 90)
            static let labelLevel = CGPoint.withPercent(50, y: 82)
            static let ball = CGPoint.withPercent(0, y: 0)
            static let ballFromCenter = SettingsGlobal.width / 100 * 41
            static let circle = CGPoint.withPercent(50, y: 50)
            static let coin = CGPoint.withPercent(50, y: 50)
            static let textPause = CGPoint.withPercent(50, y: 74)
        }
        struct ZPosition {
            static let background: CGFloat = 0
            static let interfaceHolder: CGFloat = 100
            static let pauseBackground: CGFloat = 500
            static let coinsIndicator: CGFloat = 1
            static let buttonPause: CGFloat = 499
            static let buttonRestart: CGFloat = 501
            static let buttonMenu: CGFloat = 501
            static let buttonContinue: CGFloat = 501
            static let labelScore: CGFloat = 2
            static let labelCoins: CGFloat = 2
            static let labelLevel: CGFloat = 2
            static let ball: CGFloat = 10
            static let explosion: CGFloat = 11
            static let circle: CGFloat = 9
            static let coin: CGFloat = 8
            static let textPause: CGFloat = 501
        }
        struct FontSize {
            static let pauseTitle: CGFloat = 45
            static let labelScore: CGFloat = 50
            static let labelCoins: CGFloat = 16
            static let labelLevel: CGFloat = 20
        }
        struct FontColor {
            static let pauseTitle = "#ffffff"
            static let labelScore = "#ffffff"
            static let labelCoins = "#ffffff"
            static let labelLevel = "#ffffff"
        }
    }
    // MARK: - Menu Scene Settings
    struct Menu {
        struct Size {
            static let background = CGSize.withPercent(100, height: 100)
            static let logo = CGSize.withPercentScaled(94.1, height: 37.5)
            static let coinsIndicator = CGSize.withPercentScaled(4, height: 4)
            static var buttonStart = CGSize.withPercentScaled(roundByWidth: 32)
            static let buttonStartIPad = CGSize.withPercentScaled(roundByWidth: 25)
            static let buttonStore = CGSize.withPercentScaled(roundByWidth: 12)
            static let buttonRateUs = CGSize.withPercentScaled(roundByWidth: 10)
            static let buttonTutorial = CGSize.withPercentScaled(roundByWidth: 10)
            static let buttonGameCenter = CGSize.withPercentScaled(roundByWidth: 10)
            static let buttonSettings = CGSize.withPercentScaled(roundByWidth: 10)
            static let indicatorButtonStore = CGSize.withPercentScaled(roundByWidth: 3.4)
        }
        struct Position {
            static let background = CGPoint.withPercent(50, y: 50)
            static let logo = CGPoint.withPercent(50, y: 74)
            static let coinsIndicator = CGPoint.withPercent(5, y: 10.25)
            static let buttonStart = CGPoint.withPercent(50, y: 39)
            static let buttonStore = CGPoint.withPercent(74, y: 39)
            static let buttons_RateUs_Tutorial_GameCenter_Settings = CGPoint.withPercent(50, y: 25)
            static let space_Buttons_RateUs_Tutorial_GameCenter_Settings = SettingsGlobal.width * 0.012
            static let indicatorButtonStore = CGPoint.withPercentScaledByWidth(4.9, y: 4.9)
            static let labelBestScore = CGPoint.withPercent(3, y: 13.5)
            static let labelCoins = CGPoint.withPercent(8, y: 10.25)
            static let labelWorldBestScoreName = CGPoint.withPercent(97, y: 10.25)
            static let labelWorldBestScoreValue = CGPoint.withPercent(97, y: 13.25)
        }
        struct ZPosition {
            static let background: CGFloat = 0
            static let logo: CGFloat = 1
            static let coinsIndicator: CGFloat = 1
            static let buttonStart: CGFloat = 2
            static let buttonStore: CGFloat = 2
            static let buttonRateUs: CGFloat = 2
            static let buttonTutorial: CGFloat = 2
            static let buttonGameCenter: CGFloat = 2
            static let buttonSettings: CGFloat = 2
            static let indicatorButtonStore: CGFloat = 1
            static let labelBestScore: CGFloat = 3
            static let labelCoins: CGFloat = 3
            static let labelWorldBestScoreName: CGFloat = 3
            static let labelWorldBestScoreValue: CGFloat = 3
        }
        struct FontSize {
            static let labelBestScore: CGFloat = 16
            static let labelCoins: CGFloat = 16
            static let labelWorldBestScoreName: CGFloat = 16
            static let labelWorldBestScoreValue: CGFloat = 16
        }
        struct FontColor {
            static let labelBestScore = "#ffffff"
            static let labelCoins = "#ffffff"
            static let labelWorldBestScoreName = "#ffffff"
            static let labelWorldBestScoreValue = "#ffffff"
        }
    }
    // MARK: - End Scene Settings
    struct End {
        struct Size {
            static let background = CGSize.withPercent(100, height: 100)
            static let logo = CGSize.withPercentScaled(94.1, height: 37.5)
            static let coinsIndicator = CGSize.withPercentScaled(roundByWidth: 4)
            static let buttonMenu = CGSize.withPercentScaled(roundByWidth: 10)
            static let buttonRestart = CGSize.withPercentScaled(roundByWidth: 12)
            static let buttonShare = CGSize.withPercentScaled(roundByWidth: 10)
            static let buttonGameCenter = CGSize.withPercentScaled(roundByWidth: 10)
            static let buttonStore = CGSize.withPercentScaled(roundByWidth: 12)
            static let indicatorButtonStore = CGSize.withPercentScaled(roundByWidth: 3.4)
        }
        struct Position {
            static let background = CGPoint.withPercent(50, y: 50)
            static let logo = CGPoint.withPercent(50, y: 74)
            static let coinsIndicator = CGPoint.withPercent(82.5, y: 45)
            static let labelScore = CGPoint.withPercent(50, y: 17)
            static let labelBestScore = CGPoint.withPercent(50, y: 14)
            static let labelCoins = CGPoint.withPercent(85, y: 45)
            static let indicatorButtonStore = CGPoint.withPercentScaledByWidth(4.9, y: 4.9)
            static var button_Menu_Restart = CGPoint.withPercent(16, y: 30)
            static var space_button_Menu_Restart = SettingsGlobal.width * 0.0175
            static var button_Share_GameCenter = CGPoint.withPercent(84, y: 30)
            static var space_button_Share_GameCenter = SettingsGlobal.width * 0.0175
            static let buttonStore = CGPoint.withPercent(84, y: 51.5)
        }
        struct ZPosition {
            static let background: CGFloat = 0
            static let logo: CGFloat = 1
            static let coinsIndicator: CGFloat = 2
            static let labelScore: CGFloat = 3
            static let labelBestScore: CGFloat = 3
            static let labelCoins: CGFloat = 3
            static let buttonMenu: CGFloat = 2
            static let buttonRestart: CGFloat = 2
            static let buttonStore: CGFloat = 2
            static let buttonShare: CGFloat = 2
            static let buttonGameCenter: CGFloat = 2
            static let indicatorButtonStore: CGFloat = 1
        }
        struct FontSize {
            static let labelScore: CGFloat = 16
            static let labelBestScore: CGFloat = 16
            static let labelCoins: CGFloat = 16
        }
        struct FontColor {
            static let labelScore = "#ffffff"
            static let labelBestScore = "#ffffff"
            static let labelCoins = "#ffffff"
        }
    }
    // MARK: - Settings Scene Settings
    struct Settings {
        struct Size {
            static let background = CGSize.withPercent(100, height: 100)
            static let switchSound = CGSize.withPercentScaled(16, height: 8)
            static let switchMusicMenu = CGSize.withPercentScaled(16, height: 8)
            static let switchMusicGame = CGSize.withPercentScaled(16, height: 8)
            static let switchNotification = CGSize.withPercentScaled(16, height: 8)
            static let switchSoundDot = CGSize.withPercentScaled(6, height: 6)
            static let switchMusicDot = CGSize.withPercentScaled(6, height: 6)
            static let switchNotificationDot = CGSize.withPercentScaled(6, height: 6)
            static let buttonBack = CGSize.withPercentScaled(roundByWidth: 10)
        }
        struct Position {
            static let background = CGPoint.withPercent(50, y: 50)
            static let switch_Sound_Music_Notification = CGPoint.withPercent(67, y: 50)
            static let space_Sound_Music_Notification = SettingsGlobal.width * 0.045
            static let switchDotOn = CGPoint.withPercent(4, y: 0)
            static let buttonBack = CGPoint.withPercent(50, y: 20)
            static let textSettings = CGPoint.withPercent(50, y: 86)
            static let label_Sound_Music_Notification = CGPoint.withPercent(56, y: 50)
        }
        struct ZPosition {
            static let background: CGFloat = 0
            static let switchSound: CGFloat = 1
            static let switchMusicMenu: CGFloat = 1
            static let switchMusicGame: CGFloat = 1
            static let switchNotification: CGFloat = 1
            static let switchDot: CGFloat = 1
            static let buttonBack: CGFloat = 3
            static let textSettings: CGFloat = 5
            static let labelSound: CGFloat = 2
            static let labelMusicMenu: CGFloat = 2
            static let labelMusicGame: CGFloat = 2
            static let labelNotification: CGFloat = 2
        }
        struct FontSize {
            static let title: CGFloat = 45
            static let labelSound: CGFloat = 19
            static let labelMusicMenu: CGFloat = 19
            static let labelMusicGame: CGFloat = 19
            static let labelNotification: CGFloat = 19
        }
        struct FontColor {
            static let title = "#ffffff"
            static let labelSound = "#ffffff"
            static let labelMusicMenu = "#ffffff"
            static let labelMusicGame = "#ffffff"
            static let labelNotification = "#ffffff"
        }
    }
    // MARK: - Store Scene Settings
    struct Store {
        struct Size {
            static let background = CGSize.withPercent(100, height: 100)
            static let panelBuyResultBack = CGSize.withPercent(100, height: 100)
            static let panelBuyResult = CGSize.withPercentScaled(92.3, height: 48)
            static let buttonBuyResultClose = CGSize.withPercentScaled(20, height: 9.5)
            static let coinsIndicator = CGSize.withPercentScaled(roundByWidth: 4)
            static let buttonBack = CGSize.withPercentScaled(roundByWidth: 10)
            static let buttonSkinNext = CGSize.withPercentScaled(11, height: 11)
            static let buttonSkinPrevious = CGSize.withPercentScaled(11, height: 11)
            static let buttonSelector = CGSize.withPercentScaled(30, height: 13)
            static let buttonRemoveAds = CGSize.withPercentScaled(35, height: 10)
            static let buttonRestorePurchases = CGSize.withPercentScaled(35, height: 10)
        }
        struct Position {
            static let background = CGPoint.withPercent(50, y: 50)
            static let panelBuyResultBack = CGPoint.withPercent(50, y: 50)
            static let panelBuyResult = CGPoint.withPercent(0, y: 0)
            static let buttonBuyResultClose = CGPoint.withPercent(0, y: -3)
            static let coinsIndicator = CGPoint.withPercent(46, y: 79)
            static let buttonBack = CGPoint.withPercent(50, y: 20)
            static let buttonSkinNext = CGPoint.withPercent(80, y: 50)
            static let buttonSkinPrevious = CGPoint.withPercent(20, y: 50)
            static let buttonSelector = CGPoint.withPercent(50, y: 33)
            static let skinHolder = CGPoint.withPercent(50, y: 50)
            static let skinHolderSkinShift = SettingsGlobal.width * 0.23
            static let skinHolderSkinShiftNonSelectedByY = SettingsGlobal.width * 0.15
            static let buttonRemoveAds = CGPoint.withPercent(26.5, y: 10.2)
            static let buttonRestorePurchases = CGPoint.withPercent(73.5, y: 10.2)
            static let buttonRemoveAdsIfOnOnlyInApps = CGPoint.withPercent(26.5, y: 45)
            static let buttonRestorePurchasesIfOnOnlyInApps = CGPoint.withPercent(73.5, y: 45)
            static let textStore = CGPoint.withPercent(50, y: 86)
            static let labelCoins = CGPoint.withPercent(49, y: 79)
            static let labelSkinSelector = CGPoint.withPercentScaledByWidth(0, y: -2.0)
            static let labelPanelResultMessage = CGPoint.withPercentScaledByWidth(0, y: 8.2)
            static let labelPanelResultButtonClose = CGPoint.withPercentScaledByWidth(0, y: -1.75)
            static let labelButtonRemoveAds = CGPoint.withPercentScaledByWidth(0, y: -1.85)
            static let labelButtonRestorePurchases = CGPoint.withPercentScaledByWidth(0, y: -1.85)
        }
        struct ZPosition {
            static let background: CGFloat = 0
            static let panelBuyResultBack: CGFloat = 100
            static let panelBuyResult: CGFloat = 1
            static let buttonBuyResultClose: CGFloat = 1
            static let coinsIndicator: CGFloat = 2
            static let buttonBack: CGFloat = 1
            static let buttonSkinNext: CGFloat = 9
            static let buttonSkinPrevious: CGFloat = 9
            static let buttonSelector: CGFloat = 9
            static let skinHolder: CGFloat = 4
            static let buttonRemoveAds: CGFloat = 25
            static let buttonRestorePurchases: CGFloat = 25
            static let textStore: CGFloat = 10
            static let labelCoins: CGFloat = 3
            static let labelPanelResultMessage: CGFloat = 2
        }
        struct FontSize {
            static let title: CGFloat = 45
            static let labelCoins: CGFloat = 16
            static let labelSkinSelector: CGFloat = 20
            static let labelPanelResultMessage: CGFloat = 25
            static let labelPanelResultButtonClose: CGFloat = 16
            static let labelButtonRemoveAds: CGFloat = 17
            static let labelButtonRestorePurchases: CGFloat = 17
        }
        struct FontColor {
            static let title = "#ffffff"
            static let labelCoins = "#ffffff"
            static let labelSkinSelector = "#ffffff"
            static let labelPanelResultMessage = "#acacac"
            static let labelPanelResultButtonClose = "#acacac"
            static let labelButtonRemoveAds = "#ffffff"
            static let labelButtonRestorePurchases = "#ffffff"
        }
    }
    // MARK: - Tutorial Scene Settings
    struct Tutorial {
        struct Size {
            static let background = CGSize.withPercent(100, height: 100)
            static let indicatorCloseTutorial = CGSize.withPercentScaled(100, height: 14.3)
            static let textFieldContent1Widht = SettingsGlobal.width * 0.80
            static let textFieldContent2Widht = SettingsGlobal.width * 0.40
            static let textFieldContent3Widht = SettingsGlobal.width * 0.40
        }
        struct Position {
            static let background = CGPoint.withPercent(50, y: 50)
            static let labelCloseMessage = CGPoint.withPercent(50, y: 5)
            static let textFieldContent1 = CGPoint.withPercent(50, y: 25)
            static let textFieldContent2 = CGPoint.withPercent(20, y: 66)
            static let textFieldContent3 = CGPoint.withPercent(76, y: 79)
            static let textFieldContent1SpaceBetweenLabels = SettingsGlobal.width * 0.05
            static let textFieldContent2SpaceBetweenLabels = SettingsGlobal.width * 0.1
            static let textFieldContent3SpaceBetweenLabels = SettingsGlobal.width * 0.1
        }
        struct ZPosition {
            static let background: CGFloat = 0
            static let indicatorCloseTutorial: CGFloat = 2
            static let labelCloseMessage: CGFloat = 5
            static let textFieldContent1: CGFloat = 5
            static let textFieldContent2: CGFloat = 5
            static let textFieldContent3: CGFloat = 5
        }
        struct FontSize {
            static let labelCloseMessage: CGFloat = 22
            static let textFieldContent1: CGFloat = 26
            static let textFieldContent2: CGFloat = 16
            static let textFieldContent3: CGFloat = 16
        }
        struct FontColor {
            static let labelCloseMessage = "#ffffff"
            static let textFieldContent1 = "#ffffff"
            static let textFieldContent2 = "#ffffff"
            static let textFieldContent3 = "#ffffff"
        }
    }
}
