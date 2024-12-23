//
//  GameScene.swift
//  ColorSwitch
//
//  Created by Anup Saud on 2024-12-21.
//

import SpriteKit

class GameScene: SKScene {
    var colorSwitch: SKSpriteNode! // The rotating color circle
    
    override func didMove(to view: SKView) {
        // Setup the physics world properties
        setupPhysics()
        
        // Setup the layout for the screen elements
        layoutScreen()
    }
    
    /// Configures the physics world properties
    func setupPhysics() {
        // Set gravity to pull objects downward slightly
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
    }
    
    /// Lays out the game screen by adding the color switch and spawning the ball
    func layoutScreen() {
        // Set the background color
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        
        // Create the ColorSwitch node
        colorSwitch = SKSpriteNode(imageNamed: "ColorCircle")
        colorSwitch.size = CGSize(width: frame.size.width / 3, height: frame.size.width / 3)
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.size.height)
        
        // Add a physics body to the color switch (static, does not move)
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width / 2)
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory // Set its category
        colorSwitch.physicsBody?.isDynamic = false // Make it static (no movement)
        
        // Add the ColorSwitch to the scene
        addChild(colorSwitch)
        
        // Spawn a ball in the scene
        spwanBall()
    }
    
    /// Spawns a ball at the top of the screen
    func spwanBall() {
        // Create the ball node
        let ball = SKSpriteNode(imageNamed: "ball")
        ball.size = CGSize(width: 30.0, height: 30.0) // Set ball size
        ball.position = CGPoint(x: frame.midX, y: frame.maxY) // Spawn at the top center of the screen
        
        // Add a physics body to the ball
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory // Set its category
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory // Check for contact with ColorSwitch
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none // No physical collisions
        
        // Add the ball to the scene
        addChild(ball)
    }
}
