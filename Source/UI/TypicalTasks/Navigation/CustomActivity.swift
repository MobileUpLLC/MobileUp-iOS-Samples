import UIKit

final class CustomActivity: UIActivity {
    override var activityType: UIActivity.ActivityType? {
        .init("com.example.customActivity")
    }
    
    override var activityTitle: String? {
        "Кастомная активность"
    }
    
    override var activityImage: UIImage? {
        UIImage(systemName: "star")
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        true // Условие, когда активность доступна
    }
    
    override func perform() {
        print("Выполняется кастомная активность")
        activityDidFinish(true)
    }
}
