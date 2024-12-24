//
//  GameScene.swift
//  ColorSwitch
//
//  Created by Anup Saud on 2024-12-21.
//

import SpriteKit

enum PlayColors{
    static let colors = [
        UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0),
        UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1.0),
        UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0),
        UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
    ]
}

enum SwitchState:Int {
    case red, yellow, green, blue
}

class GameScene: SKScene {
    var colorSwitch: SKSpriteNode! // The rotating color circle
    var switchState = SwitchState.red
    var currentColorIndex: Int?
    let scoreLabel = SKLabelNode(text: "0")
    var score = 0
    
    override func didMove(to view: SKView) {
        // Setup the physics world properties
        setupPhysics()
        
        // Setup the layout for the screen elements
        layoutScreen()
    }
    
    /// Configures the physics world properties
    func setupPhysics() {
        // Set gravity to pull objects downward slightly
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0)
        physicsWorld.contactDelegate = self
    }
    
    /// Lays out the game screen by adding the color switch and spawning the ball
    func layoutScreen() {
        // Set the background color
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        
        // Create the ColorSwitch node
        colorSwitch = SKSpriteNode(imageNamed: "ColorCircle")
        colorSwitch.size = CGSize(width: frame.size.width / 3, height: frame.size.width / 3)
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.size.height)
        colorSwitch.zPosition = ZPositions.colorSwitch
        
        // Add a physics body to the color switch (static, does not move)
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width / 2)
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory // Set its category
        colorSwitch.physicsBody?.isDynamic = false // Make it static (no movement)
        
        // Add the ColorSwitch to the scene
        addChild(colorSwitch)
        
        scoreLabel.fontName = "AvenireNext-Bold"
        scoreLabel.fontSize = 60.0
        scoreLabel.fontColor = UIColor.white
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        scoreLabel.zPosition = ZPositions.label
        addChild(scoreLabel)
        
        // Spawn a ball in the scene
        spwanBall()
    }
    
    func updateScoreLabel(){
        scoreLabel.text = "\(score)"
    }
    
    /// Spawns a ball at the top of the screen
    func spwanBall() {
        currentColorIndex =  Int(arc4random_uniform(UInt32(4)))
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: PlayColors.colors[currentColorIndex!], size: CGSize(width: 30.0, height: 30.0))
        ball.colorBlendFactor = 1.0
        ball.name = "Ball"
        ball.position = CGPoint(x: frame.midX, y: frame.maxY) // Spawn at the top center of the screen
        ball.zPosition = ZPositions.ball
        // Add a physics body to the ball
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory // Set its category
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory // Check for contact with ColorSwitch
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none // No physical collisions
        
        // Add the ball to the scene
        addChild(ball)
    }
    func turnWheel(){
        if let newState = SwitchState(rawValue: switchState.rawValue + 1){
            switchState = newState
        }else{
            switchState = .red
        }
        colorSwitch.run(SKAction.rotate(byAngle: .pi/2, duration: 0.25))
    }
    func gameOver(){
        // save the score of the user
        UserDefaults.standard.set(score, forKey: "Recentscore")
        if score > UserDefaults.standard.integer(forKey: "Highscore"){
            UserDefaults.standard.set(score, forKey: "Highscore")
        }
        
        //when game is over redirect to menu screen
        let menuScene = MenuScene(size: view!.bounds.size)
        view?.presentScene(menuScene)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnWheel()
    }
    
    
}
extension GameScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory{
            if let ball = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode{
                if currentColorIndex == switchState.rawValue{
                    score += 1
                    updateScoreLabel()
                    ball.run(SKAction.fadeIn(withDuration: 0.25)) {
                        ball.removeFromParent()
                        self.spwanBall()
                    }
                } else{
                    gameOver()
                }
            }
        }
    }
}
