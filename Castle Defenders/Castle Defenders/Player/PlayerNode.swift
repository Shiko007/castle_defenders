//
//  PlayerNode.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 08.10.24.
//

import SpriteKit

class PlayerNode: SKSpriteNode {
    let playerParametersStorage = PlayerParametersStorage()
    var playerID: String?
    var experiencePoints: Int = 0
    var experienceToNextLevel: Int! // Example: XP required to reach level 2
    var level: Int = 1
    var skillPoints: Int = 0
    var attackCooldown: TimeInterval = 1 // Time between attacks initial value
    var lastAttackTime: TimeInterval = 0 // Track the last attack time
    var attackRange: CGFloat = 50 // Range within which the player can attack inital value
    var attackDamage: Int = 10 //Attack Damage initial value
    var gold: Int = 0
    var gameScene: GameScene?
    private var rangeCircle: SKShapeNode!
    private var experienceArc: SKShapeNode!
    
    init(texture: SKTexture?, color: UIColor = .clear, size: CGSize = CGSize(width: 50, height: 50), gameScene: GameScene) {
        self.gameScene = gameScene
        // You must call a designated initializer of SKSpriteNode here
        super.init(texture: texture, color: color, size: size)  // Correct designated initializer call
        self.zPosition = elementsZPos.player
        self.loadPlayer()
        // Set up physics body for the player
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = PhysicsCategory.player
        self.physicsBody?.contactTestBitMask = PhysicsCategory.monster
        self.physicsBody?.collisionBitMask = PhysicsCategory.none // No physical collision, only contact
        self.physicsBody?.isDynamic = true // Allow movement if needed
        self.physicsBody?.affectedByGravity = false // Since it's a 2D game, gravity is often disabled
        
        addPlayerRangeCircle()
        drawExperienceArc()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addPlayerRangeCircle() {
        let radius: CGFloat = PlayerConfig.attackRange
        
        // Create a circular shape node with the given radius
        let rangeCircle = SKShapeNode(circleOfRadius: radius)
        
        // Set the fill color to gray with low opacity
        rangeCircle.fillColor = PlayerConfig.playerRangeColor.withAlphaComponent(PlayerConfig.playerRangeColorAlpha)
        
        // Optionally, set the stroke color and width (for the circle's border)
        rangeCircle.strokeColor = PlayerConfig.playerRangeColor
        rangeCircle.lineWidth = PlayerConfig.playerRangeLineW
        // Position the circle at the player's position
        rangeCircle.position = self.position
        // Ensure the circle is behind the player (optional, adjust zPosition as needed)
        rangeCircle.zPosition = elementsZPos.expCircleRange
        
        // Add the circle to the scene (or the player node if you prefer)
        gameScene!.addChild(rangeCircle)
    }
    
    func drawExperienceArc() {
        let radius: CGFloat = PlayerConfig.attackRange
        experienceArc = SKShapeNode(circleOfRadius: radius)
        experienceArc.strokeColor = PlayerConfig.expBarLineColor
        experienceArc.lineWidth = PlayerConfig.expBarLineWidth
        experienceArc.position = self.position
        experienceArc.alpha = PlayerConfig.expBarAlpha
        experienceArc.zPosition = elementsZPos.expCircle
        experienceArc.lineCap = .round // Smooth line endings
        
        // Start with an empty arc
        experienceArc.path = createArcPath(percentage: 0)
        gameScene!.addChild(experienceArc)
    }
    
    // Create the arc path based on the experience percentage
    func createArcPath(percentage: CGFloat) -> CGPath {
        let radius: CGFloat = PlayerConfig.attackRange
        let center = CGPoint(x: 0, y: 0)
        let startAngle = CGFloat(-CGFloat.pi / 2) // Start at the top of the circle
        let endAngle = startAngle + (2 * CGFloat.pi * percentage / 100)
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        return path.cgPath
    }
    
    // Call this whenever the player gains experience
    func updateExperienceProgress() {
        let experiencePercentage = CGFloat(experiencePoints) / CGFloat(experienceToNextLevel) * 100
        experienceArc.path = createArcPath(percentage: experiencePercentage)
    }
    
    func update(currentTime: TimeInterval, monsters: [MonsterNode]) {
        // Find the closest monster within attack range
        var distance : CGFloat!
        let sortedMonsters = sortMonsters(monsters)
        var attackableMonsters : [MonsterNode] = []
        for monster in sortedMonsters {
            distance = distanceBetween(player: self, monster: monster)
            
            if distance <= attackRange && attackableMonsters.count < PlayerConfig.attackCount {
                attackableMonsters.append(monster)
            }
        }
        if currentTime - lastAttackTime >= attackCooldown {
            attack(monsters: attackableMonsters)
            lastAttackTime = currentTime
        }
    }
    
    func sortMonsters(_ monsters: [MonsterNode]) -> [MonsterNode] {
        // Sort monsters by distance and return the closest one
        return monsters.sorted {
            distanceBetween(player: self, monster: $0) < distanceBetween(player: self, monster: $1)
        }
    }
    
    func distanceBetween(player: PlayerNode, monster: MonsterNode) -> CGFloat {
        let dx = player.position.x - monster.position.x
        let dy = player.position.y - monster.position.y
        return sqrt(dx*dx + dy*dy)
    }
    
    func attack(monsters: [MonsterNode]) {
        // Attack animation (e.g., shoot a projectile)
        let attackImage = SKTexture(image: UIImage(systemName: "circle.fill")!)
        for monster in monsters {
            let attack = AttackNode(texture:attackImage, targetMonster: monster, damage: self.attackDamage)
            
            attack.position = self.position
            let moveAction = SKAction.move(to: monster.position, duration: PlayerConfig.attackProjectileSpeed)
            let removeAction = SKAction.removeFromParent()
            attack.run(SKAction.sequence([moveAction, removeAction]))
            
            self.parent?.addChild(attack)
        }
    }
    
    // Function to gain XP
    func gainExperience(points: Int) {
        experiencePoints += points
        updateExperienceProgress()
        if experiencePoints >= experienceToNextLevel {
            levelUp()
            triggerLevelUpVibration()
        }
    }
    
    // Function to execute level up vibration
    func triggerLevelUpVibration() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success) // Use .warning for level-up
    }
    
    // Function to level up
    func levelUp() {
        level += 1
        skillPoints += 1 // Award 1 skill point per level-up (can be adjusted)
        
        // Reset XP and increase the XP threshold for the next level
        experiencePoints = 0
        experienceToNextLevel += PlayerConfig.playerLevelExpIncrement // Increase the XP requirement (adjust as needed)
        //TODO: Implement a level up notification
        // Create and position the levelup effect
        if let levelupEffect = SKEmitterNode(fileNamed: "level_up.sks") {
            levelupEffect.position = self.position
            self.parent?.addChild(levelupEffect)
            
            // Optional: Run a sequence to remove the smoke effect after it dissipates
            let wait = SKAction.wait(forDuration: 3.0) // Adjust duration as needed
            let removeLevelUpEffect = SKAction.removeFromParent()
            levelupEffect.run(SKAction.sequence([wait, removeLevelUpEffect]))
        }
    }
    
    func loadPlayer() {
        let defaultplayerData: [String: Any] = ["gold": self.gold]
        self.playerID = getPlayerID()
        self.playerParametersStorage.loadPlayerData(playerID: self.playerID!) { data in
            if let data = data {
                self.gold = data["gold"] as! Int
                self.gameScene!.uiHandling.goldCounterLabel.text = "\(self.gold)"
            }
            else {
                self.playerParametersStorage.savePlayerData(playerID: self.getPlayerID(), data: defaultplayerData)
            }
        }
        self.attackCooldown = PlayerConfig.attackCD
        self.attackRange = PlayerConfig.attackRange
        self.attackDamage = PlayerConfig.attackDamage
        self.experienceToNextLevel = PlayerConfig.playerLevelExperience
    }
    
    func savePlayerState() {
        let playerData = ["gold": self.gold]
        self.playerParametersStorage.savePlayerData(playerID: self.getPlayerID(), data: playerData)
    }
    
    func generatePlayerID() -> String {
        return UUID().uuidString
    }
    
    func getPlayerID() -> String {
        let key = "playerID"
        if let savedID = UserDefaults.standard.string(forKey: key) {
            return savedID
        } else {
            let newID = generatePlayerID()
            UserDefaults.standard.set(newID, forKey: key)
            return newID
        }
    }
}
