//
//  AssetManager.swift
//  Castle Defenders
//
//  Centralized asset management for easy sprite/texture loading
//

import SpriteKit

/// Manages all game assets - textures, sprites, and particle effects
class AssetManager {
    
    static let shared = AssetManager()
    
    // MARK: - Asset Names (Update these when you add assets to Assets.xcassets)
    
    struct Player {
        static let castle = "castle_tower"              // Your player sprite
        static let castleDamaged = "castle_damaged"     // Optional: damaged state
        static let levelUpGlow = "player_levelup_glow"  // Optional: level up effect
    }
    
    struct Monsters {
        static let basic = ["monster_basic_1", "monster_basic_2", "monster_basic_3"]
        static let fast = ["monster_fast_1", "monster_fast_2", "monster_fast_3"]
        static let tank = ["monster_tank_1", "monster_tank_2", "monster_tank_3"]
        static let boss = "monster_boss"
    }
    
    struct Projectiles {
        static let arrow = "projectile_arrow"
        static let fireball = "projectile_fireball"
        static let magic = "projectile_magic"
        static let ice = "projectile_ice"
        static let lightning = "projectile_lightning"
    }
    
    struct Backgrounds {
        static let main = "background_main"
        static let forest = "background_forest"
        static let castle = "background_castle"
        static let desert = "background_desert"
    }
    
    struct Particles {
        static let spark = "particle_spark"
        static let smoke = "particle_smoke"
        static let magic = "particle_magic"
        static let gold = "particle_gold"
    }
    
    struct UI {
        static let buttonNormal = "button_normal"
        static let buttonPressed = "button_pressed"
        static let panelBackground = "panel_background"
        static let coin = "coin"
    }
    
    // MARK: - Fallback to SF Symbols
    
    private let useFallbacks = true  // Set to false once you have custom assets
    
    // MARK: - Texture Loading
    
    /// Load a texture with fallback to SF Symbol if asset not found
    func loadTexture(named: String, fallbackSymbol: String? = nil) -> SKTexture {
        // Try loading from Assets.xcassets
        if let image = UIImage(named: named) {
            return SKTexture(image: image)
        }
        
        // Fallback to SF Symbol if provided and enabled
        if useFallbacks, let symbolName = fallbackSymbol {
            if let symbolImage = UIImage(systemName: symbolName) {
                return SKTexture(image: symbolImage)
            }
        }
        
        // Last resort: create colored square
        print("⚠️ Asset '\(named)' not found, using colored placeholder")
        return createPlaceholderTexture(color: .systemGray)
    }
    
    /// Load animation frames
    func loadAnimationFrames(named: [String], fallbackSymbol: String? = nil) -> [SKTexture] {
        var textures: [SKTexture] = []
        
        for frameName in named {
            textures.append(loadTexture(named: frameName, fallbackSymbol: fallbackSymbol))
        }
        
        // If no textures loaded, return at least one
        if textures.isEmpty {
            textures.append(createPlaceholderTexture(color: .systemGray))
        }
        
        return textures
    }
    
    // MARK: - Convenience Getters
    
    func getPlayerTexture() -> SKTexture {
        return loadTexture(named: Player.castle, fallbackSymbol: "building.2.fill")
    }
    
    func getMonsterTextures(type: MonsterType) -> [SKTexture] {
        switch type {
        case .basic:
            return loadAnimationFrames(named: Monsters.basic, fallbackSymbol: "figure.walk")
        case .fast:
            return loadAnimationFrames(named: Monsters.fast, fallbackSymbol: "hare.fill")
        case .tank:
            return loadAnimationFrames(named: Monsters.tank, fallbackSymbol: "tortoise.fill")
        case .boss:
            return [loadTexture(named: Monsters.boss, fallbackSymbol: "crown.fill")]
        }
    }
    
    func getProjectileTexture(type: ProjectileType) -> SKTexture {
        switch type {
        case .arrow:
            return loadTexture(named: Projectiles.arrow, fallbackSymbol: "arrowtriangle.right.fill")
        case .fireball:
            return loadTexture(named: Projectiles.fireball, fallbackSymbol: "flame.fill")
        case .magic:
            return loadTexture(named: Projectiles.magic, fallbackSymbol: "sparkles")
        case .ice:
            return loadTexture(named: Projectiles.ice, fallbackSymbol: "snowflake")
        case .lightning:
            return loadTexture(named: Projectiles.lightning, fallbackSymbol: "bolt.fill")
        }
    }
    
    func getBackgroundTexture(type: BackgroundType) -> SKTexture {
        switch type {
        case .main:
            return loadTexture(named: Backgrounds.main, fallbackSymbol: nil)
        case .forest:
            return loadTexture(named: Backgrounds.forest, fallbackSymbol: nil)
        case .castle:
            return loadTexture(named: Backgrounds.castle, fallbackSymbol: nil)
        case .desert:
            return loadTexture(named: Backgrounds.desert, fallbackSymbol: nil)
        }
    }
    
    func getParticleTexture(type: ParticleType) -> SKTexture {
        switch type {
        case .spark:
            return loadTexture(named: Particles.spark, fallbackSymbol: "sparkle")
        case .smoke:
            return loadTexture(named: Particles.smoke, fallbackSymbol: "smoke.fill")
        case .magic:
            return loadTexture(named: Particles.magic, fallbackSymbol: "sparkles")
        case .gold:
            return loadTexture(named: Particles.gold, fallbackSymbol: "star.fill")
        }
    }
    
    func getCoinTexture() -> SKTexture {
        return loadTexture(named: UI.coin, fallbackSymbol: "dollarsign.circle.fill")
    }
    
    // MARK: - Helper Methods
    
    private func createPlaceholderTexture(color: UIColor, size: CGSize = CGSize(width: 50, height: 50)) -> SKTexture {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return SKTexture(image: image)
    }
    
    // MARK: - Asset Validation
    
    /// Check which assets are loaded vs fallbacks
    func validateAssets() -> AssetReport {
        var report = AssetReport()
        
        // Check player
        report.playerLoaded = UIImage(named: Player.castle) != nil
        
        // Check monsters
        report.monstersLoaded = Monsters.basic.allSatisfy { UIImage(named: $0) != nil }
        
        // Check projectiles
        report.projectilesLoaded = UIImage(named: Projectiles.arrow) != nil
        
        // Check background
        report.backgroundLoaded = UIImage(named: Backgrounds.main) != nil
        
        // Check particles
        report.particlesLoaded = UIImage(named: Particles.spark) != nil
        
        return report
    }
    
    func printAssetStatus() {
        let report = validateAssets()
        print("📦 Asset Status:")
        print("   Player: \(report.playerLoaded ? "✅" : "⚠️ Using fallback")")
        print("   Monsters: \(report.monstersLoaded ? "✅" : "⚠️ Using fallback")")
        print("   Projectiles: \(report.projectilesLoaded ? "✅" : "⚠️ Using fallback")")
        print("   Background: \(report.backgroundLoaded ? "✅" : "⚠️ Using fallback")")
        print("   Particles: \(report.particlesLoaded ? "✅" : "⚠️ Using fallback")")
    }
}

// MARK: - Supporting Types

enum MonsterType {
    case basic
    case fast
    case tank
    case boss
}

enum ProjectileType {
    case arrow
    case fireball
    case magic
    case ice
    case lightning
}

enum BackgroundType {
    case main
    case forest
    case castle
    case desert
}

enum ParticleType {
    case spark
    case smoke
    case magic
    case gold
}

struct AssetReport {
    var playerLoaded = false
    var monstersLoaded = false
    var projectilesLoaded = false
    var backgroundLoaded = false
    var particlesLoaded = false
    
    var allLoaded: Bool {
        return playerLoaded && monstersLoaded && projectilesLoaded && backgroundLoaded && particlesLoaded
    }
    
    var percentageComplete: Int {
        let total = 5
        let loaded = [playerLoaded, monstersLoaded, projectilesLoaded, backgroundLoaded, particlesLoaded]
            .filter { $0 }.count
        return (loaded * 100) / total
    }
}

// MARK: - Usage Examples

/*
 
 HOW TO USE ASSETMANAGER:
 
 // 1. Load player sprite
 let playerTexture = AssetManager.shared.getPlayerTexture()
 let player = SKSpriteNode(texture: playerTexture)
 
 // 2. Load monster with animation
 let monsterFrames = AssetManager.shared.getMonsterTextures(type: .basic)
 let monster = SKSpriteNode(texture: monsterFrames[0])
 let animation = SKAction.animate(with: monsterFrames, timePerFrame: 0.1)
 monster.run(SKAction.repeatForever(animation))
 
 // 3. Load projectile
 let projectileTexture = AssetManager.shared.getProjectileTexture(type: .fireball)
 let projectile = SKSpriteNode(texture: projectileTexture)
 
 // 4. Check asset status
 AssetManager.shared.printAssetStatus()
 
 */
