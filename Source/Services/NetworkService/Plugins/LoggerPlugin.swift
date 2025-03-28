import Foundation
import Moya

enum LoggerPlugin {
    static var instance = NetworkLoggerPlugin(configuration: configuration)
    
    private static let configuration = NetworkLoggerPlugin.Configuration(output: defaultOutput, logOptions: .verbose)
    
    private static func defaultOutput(target: TargetType, items: [String]) {
        var logMessage = "---------------------------REQUEST START---------------------------\n\n"

        for item in items {
            logMessage.append(contentsOf: item)
        }

        logMessage.append(contentsOf: "\n\n---------------------------REQUEST END-----------------------------\n\n")
        
        Log.networkService.debug(logEntry: .text(logMessage))
    }
}
