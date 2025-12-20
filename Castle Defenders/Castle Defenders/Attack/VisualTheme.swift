//
//  VisualTheme.swift
//  Castle Defenders
//
//  Complete visual theme system for cohesive game appearance
//

import SpriteKit

/// Visual theme defines colors, effects, and overall aesthetic
struct VisualTheme {
    let name: String
    let colors: ColorPalette
    let effects: EffectSettings
    let projectileType: ProjectileType
    let backgroundType: BackgroundType
    
    // MARK: - Predefined Themes
    
    static let medieval = VisualTheme(
        name: "Medieval",
        colors: ColorPalette(
            primary: .systemBrown,
            secondary: .systemGray,
            accent: .systemOrange,
            background: UIColor(red: 0.9, green: 0.85, blue: 0.7, alpha: 1.0),
            projectile: .systemBrown,
            ui: .systemGray
        ),
        effects: EffectSettings(
            particleIntensity: .medium,
            glowEnabled: false,
            trailEnabled: true
        ),
        projectileType: .arrow,
        backgroundType: .castle
    )
    
    static let fantasy = VisualTheme(
        name: "Fantasy",
        colors: ColorPalette(
            primary: .systemPurple,
            secondary: .systemIndigo,
            accent: .systemPink,
            background: UIColor(red: 0.1, green: 0.1, blue: 0.3, alpha: 1.0),
            projectile: .systemPurple,
            ui: .systemIndigo
        ),
        effects: EffectSettings(
            particleIntensity: .high,
            glowEnabled: true,
            trailEnabled: true
        ),
        projectileType: .magic,
        backgroundType: .main
    )
    
    static let fire = VisualTheme(
        name: "Fire Warrior",
        colors: ColorPalette(
            primary: .systemOrange,
            secondary: .systemRed,
            accent: .systemYellow,
            background: UIColor(red: 0.3, green: 0.15, blue: 0.1, alpha: 1.0),
            projectile: .systemOrange,
            ui: .systemRed
        ),
        effects: EffectSettings(
            particleIntensity: .high,
            glowEnabled: true,
            trailEnabled: true
        ),
        projectileType: .fireball,
        backgroundType: .desert
    )
    
    static let ice = VisualTheme(
        name: "Ice Mage",
        colors: ColorPalette(
            primary: .systemCyan,
            secondary: .systemBlue,
            accent: .systemTeal,
            background: UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0),
            projectile: .systemCyan,
            ui: .systemBlue
        ),
        effects: EffectSettings(
            particleIntensity: .medium,
            glowEnabled: true,
            trailEnabled: true
        ),
        projectileType: .ice,
        backgroundType: .main
    )
    
    static let nature = VisualTheme(
        name: "Nature Guardian",
        colors: ColorPalette(
            primary: .systemGreen,
            secondary: .systemTeal,
            accent: .systemMint,
            background: UIColor(red: 0.7, green: 0.9, blue: 0.7, alpha: 1.0),
            projectile: .systemGreen,
            ui: .systemTeal
        ),
        effects: EffectSettings(
            particleIntensity: .medium,
            glowEnabled: false,
            trailEnabled: true
        ),
        projectileType: .arrow,
        backgroundType: .forest
    )
    
    static let lightning = VisualTheme(
        name: "Storm Caller",
        colors: ColorPalette(
            primary: .systemYellow,
            secondary: .systemIndigo,
            accent: .systemCyan,
            background: UIColor(red: 0.2, green: 0.2, blue: 0.3, alpha: 1.0),
            projectile: .systemYellow,
            ui: .systemIndigo
        ),
        effects: EffectSettings(
            particleIntensity: .high,
            glowEnabled: true,
            trailEnabled: true
        ),
        projectileType: .lightning,
        backgroundType: .main
    )
    
    // MARK: - Theme Application
    
    func apply(to scene: GameScene) {
        // Apply background color or texture
        applyBackground(to: scene)
        
        // Apply to UI
        applyToUI()
        
        print("🎨 Applied theme: \(name)")
    }
    
    private func applyBackground(to scene: GameScene) {
        // Try to load custom background
        let backgroundTexture = AssetManager.shared.getBackgroundTexture(type: backgroundType)
        
        // Check if it's a real texture or placeholder
        if backgroundTexture.size().width > 100 {
            // Use texture
            let background = SKSpriteNode(texture: backgroundTexture)
            background.size = scene.size
            background.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
            background.zPosition = -100
            background.name = "background"
            scene.addChild(background)
        } else {
            // Use color
            scene.backgroundColor = colors.background
        }
    }
    
    private func applyToUI() {
        // Update UIConfig colors
        // Note: UIConfig uses static properties, so we'd need to refactor it
        // For now, this is a placeholder for future enhancement
    }
}

// MARK: - Supporting Structures

struct ColorPalette {
    let primary: UIColor
    let secondary: UIColor
    let accent: UIColor
    let background: UIColor
    let projectile: UIColor
    let ui: UIColor
    
    // Computed helper colors
    var primaryDark: UIColor {
        return primary.darker()
    }
    
    var primaryLight: UIColor {
        return primary.lighter()
    }
}

struct EffectSettings {
    let particleIntensity: ParticleIntensity
    let glowEnabled: Bool
    let trailEnabled: Bool
    
    enum ParticleIntensity {
        case low    // Fewer particles, better performance
        case medium // Balanced
        case high   // Maximum visual impact
        
        var birthRate: CGFloat {
            switch self {
            case .low: return 20
            case .medium: return 50
            case .high: return 100
            }
        }
    }
}

// MARK: - Theme Manager

class ThemeManager {
    static let shared = ThemeManager()
    
    var currentTheme: VisualTheme = .fantasy {
        didSet {
            print("🎨 Theme changed to: \(currentTheme.name)")
        }
    }
    
    let availableThemes: [VisualTheme] = [
        .medieval,
        .fantasy,
        .fire,
        .ice,
        .nature,
        .lightning
    ]
    
    func setTheme(_ theme: VisualTheme, for scene: GameScene) {
        currentTheme = theme
        theme.apply(to: scene)
    }
    
    func cycleTheme(for scene: GameScene) {
        if let currentIndex = availableThemes.firstIndex(where: { $0.name == currentTheme.name }) {
            let nextIndex = (currentIndex + 1) % availableThemes.count
            setTheme(availableThemes[nextIndex], for: scene)
        }
    }
}

// MARK: - UIColor Extensions

extension UIColor {
    func lighter(by percentage: CGFloat = 0.3) -> UIColor {
        return self.adjust(by: abs(percentage))
    }
    
    func darker(by percentage: CGFloat = 0.3) -> UIColor {
        return self.adjust(by: -abs(percentage))
    }
    
    private func adjust(by percentage: CGFloat) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return UIColor(
            red: min(red + percentage, 1.0),
            green: min(green + percentage, 1.0),
            blue: min(blue + percentage, 1.0),
            alpha: alpha
        )
    }
}

// MARK: - Usage Examples

/*
 
 HOW TO USE THEMES:
 
 // 1. In GameScene.sceneDidLoad()
 ThemeManager.shared.setTheme(.fantasy, for: self)
 
 // 2. Change theme dynamically
 ThemeManager.shared.setTheme(.fire, for: self)
 
 // 3. Cycle through themes (useful for testing)
 ThemeManager.shared.cycleTheme(for: self)
 
 // 4. Get current theme colors for UI
 let currentColors = ThemeManager.shared.currentTheme.colors
 myButton.color = currentColors.primary
 
 // 5. Create custom theme
 let customTheme = VisualTheme(
     name: "My Theme",
     colors: ColorPalette(
         primary: .systemPink,
         secondary: .systemPurple,
         accent: .systemIndigo,
         background: .black,
         projectile: .systemPink,
         ui: .systemPurple
     ),
     effects: EffectSettings(
         particleIntensity: .high,
         glowEnabled: true,
         trailEnabled: true
     ),
     projectileType: .magic,
     backgroundType: .main
 )
 ThemeManager.shared.setTheme(customTheme, for: scene)
 
 */
