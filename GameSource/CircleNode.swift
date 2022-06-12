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
protocol CircleNodeDelegate: class {
    /** Use it for compleate some action after changing switch state.*/
    func circleRowCollected()
    func circleCollectBall()
    func circleLimitOfBalls()
}

class CircleNode: SimpleSprite, BallNodeDelegate {
    var delegate: CircleNodeDelegate?
    var currentScene: GameScene?
    var rowBallsCount = SettingsGameProcess.Circle.Rows.start
    var firstGen = true
    var row = [BallNode]()
    var currentBall = BallNode(withScene: nil)
    var rotationSpeed = 1.0
    var rotationPointInCurrentRow: CGFloat = 0.0
    var ballHolder = TransparentSprite(position: .zero, zPosition: 0.1)
    // MARK: - Inititalisations
    /**
     Initialisation enemy
     - parameter texture: SKTexture object with texture for enemy.
     - parameter size: CGSize object for set size of enemy.
     - parameter position: CGPoint object for set position node on scene.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(withScene newScene: GameScene?) {
        super.init(texture: GraphicPreloadsGame.preload.circle, size: SettingsScenes.Game.Size.circle, position: SettingsScenes.Game.Position.circle, zPosition: SettingsScenes.Game.ZPosition.circle)
        addChild(ballHolder)
        currentScene = newScene
        generateRow()
        currentBall.inMoveNow = true
        setNewBall()
    }
    /** If your custom init function not can run compiler call this function*/
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleSprite init(coder:) has not been implemented")}
    // MARK: - Your features
    func tryToShoot(withSpeed speed: Double) {
        if !currentBall.inRow {
            currentBall.shoot(withSpeed: speed)
        }
    }
    // MARK: - Work with balls
    func setNewBall() {
        if currentBall.inMoveNow {
            currentBall.removeFromParent()
            currentBall = BallNode(withScene: currentScene)
            currentBall.delegate = self
            currentBall.set(color: row[Int(from: 0, to: row.count - 1)].currentColor)
            addChild(currentBall)
        }
    }
    func generateRow() {
        ///Change values
        if !firstGen {
            increaseValues()
        }
        firstGen = false
        ///Generate
        for _ in 0...rowBallsCount {
            let ball = BallNode(withScene: currentScene)
            ball.setRandomColor()
            ball.setIsInstantInRow()
            ballHolder.addChild(ball)
            row.append(ball)
        }
        //Set in positions
        var rotationBall = CGFloat(from: 0, to: 360)
        rotationPointInCurrentRow = rotationBall
        for ball in row {
            ball.zRotation = CGFloat(degreeToRadian: rotationBall)
            rotationBall += SettingsGameProcess.Circle.rotationDifference
        }
        rotateRow(withSpeed: rotationSpeed)
    }
    func rotateRow(withSpeed speed: Double) {
        rotationSpeed = speed
        ballHolder.removeAllActions()
        ballHolder.run(SKAction.repeatForever(SKAction.rotateByDegree(Bool.random() ? 360 : -360, duration: rotationSpeed)))
    }
    func increaseValues() {
        if rowBallsCount < SettingsGameProcess.Circle.Rows.max {
            rowBallsCount += SettingsGameProcess.Circle.Rows.increaseBy
            if rowBallsCount > SettingsGameProcess.Circle.Rows.max {
                rowBallsCount = SettingsGameProcess.Circle.Rows.max
            }
        }
    }
    // MARK: - Collecting
    func ballCatch(ballInRow targetBall: BallNode) {
        currentBall.removeAllActions()
        //Find id
        var id: Int?
        for i in 0..<row.count {
            if row[i] == targetBall {
                id = i
                break
            }
        }
        if id != nil {
            //Check is before or after target ball
            let positionTargetOnCircle = targetBall.body.convert(targetBall.body.position, to: self)
            let isLeft = currentBall.position.x < positionTargetOnCircle.x ? false : true
            let colorToSet = currentBall.currentColor
            currentBall.remove()
            //Set to holder
            let fakeBall = BallNode(withScene: currentScene)
            fakeBall.set(color: colorToSet)
            fakeBall.body.set(positionY: currentBall.body.position.y)
            fakeBall.setIsInstantInRow()
            ballHolder.addChild(fakeBall)
            fakeBall.run(SKAction.rotateToDegree(rotationPointInCurrentRow + (SettingsGameProcess.Circle.rotationDifference * CGFloat(id!)), duration: 0.0))
            //Add to row
            row.insert(fakeBall, at: isLeft ? id! : id! + 1)
            if row.count >= SettingsGameProcess.Circle.Rows.killAt {
                if delegate != nil {
                    delegate?.circleLimitOfBalls()
                }
            }
            prepareToCollect()
        }
    }
    func prepareToCollect() {
        sortRow()
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(collectBalls), userInfo: nil, repeats: false)
    }
    @objc func collectBalls() {
        var colorLenght = 0
        var colorToCheck = 0
        var findToCollect = false
        if !row.isEmpty {
            for (index, ball) in row.enumerated() {
                if !findToCollect {
                    if index == 0 {
                        colorLenght = 1
                        colorToCheck = ball.currentColor
                    }
                    else {
                        if ball.currentColor == colorToCheck {
                            colorLenght += 1
                        }
                        else {
                            if colorLenght >= SettingsGameProcess.Ball.collectWhenSameAtLine {
                                for _ in 0..<colorLenght {
                                    row[index - colorLenght].removeFromParent()
                                    row.remove(at: index - colorLenght)
                                    if delegate != nil {
                                        delegate?.circleCollectBall()
                                    }
                                }
                                findToCollect = true
                            }
                            else {
                                colorLenght = 1
                                colorToCheck = ball.currentColor
                            }
                        }
                    }
                    if index == row.count - 1 && ball.currentColor == colorToCheck {
                        if colorLenght >= SettingsGameProcess.Ball.collectWhenSameAtLine {
                            for _ in 0..<colorLenght {
                                row.last!.remove()
                                row.removeLast()
                                if delegate != nil {
                                    delegate?.circleCollectBall()
                                }
                            }
                            findToCollect = true
                        }
                    }
                }
            }
            if findToCollect {
                sortRow()
                Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(collectBalls), userInfo: nil, repeats: false)
            }
            else {
                setNewBall()
            }
        }
        else {
            if delegate != nil {
                delegate?.circleRowCollected()
            }
            generateRow()
            setNewBall()
        }
    }
    func sortRow() {
        var rotationBall = rotationPointInCurrentRow
        for ball in row {
            ball.run(SKAction.rotateToDegree(rotationBall, duration: 0.2))
            ball.body.run(SKAction.group([
                                            SKAction.moveTo(y: SettingsScenes.Game.Position.ballFromCenter, duration: 0.2),
                                            SKAction.moveTo(x: 0.0, duration: 0.0)]))
            rotationBall += SettingsGameProcess.Circle.rotationDifference
        }
    }
    func ballFinishedMovingWithoutCollision() {
        setNewBall()
    }
}
