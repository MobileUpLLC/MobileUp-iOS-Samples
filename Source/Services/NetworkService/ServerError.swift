import Moya
import Alamofire
import Foundation

struct ErrorDetails {
    var statusCode: Int?
    var message = String.empty
    var error: Error?
}

enum ServerError: Error {
    /// statusCode: 400
    case badRequest(details: ErrorDetails)
    /// statusCode: 401
    case unauthorized(details: ErrorDetails)
    
    /// statusCode: 403
    case forbidden(details: ErrorDetails)
    
    /// statusCode: 404
    case notFound(details: ErrorDetails)
    
    /// statusCode: 500
    case internalServerError(details: ErrorDetails)
    
    /// statusCode: 502
    case badGateway(details: ErrorDetails)
    
    /// statusCode: 503
    case serviceUnavailable(details: ErrorDetails)
    
    /// statusCode: 504
    case gatewayTimeOut(details: ErrorDetails)
    
    case networkError(details: ErrorDetails)
    case unknown(details: ErrorDetails)
    case systemError(details: ErrorDetails)
    case swiftError(details: ErrorDetails)
    
    var details: ErrorDetails {
        switch self {
        case let .badRequest(details):
            return details
        case let .unauthorized(details):
            return details
        case let .forbidden(details):
            return details
        case let .notFound(details):
            return details
        case let .badGateway(details):
            return details
        case let .internalServerError(details):
            return details
        case let .serviceUnavailable(details):
            return details
        case let .gatewayTimeOut(details):
            return details
        case let .unknown(details):
            return details
        case let .networkError(details):
            return details
        case let .systemError(details):
            return details
        case let .swiftError(details):
            return details
        }
    }
    
    var title: String {
        let defaultTitle = R.string.common.networkCommonErrorTitle()
        var detailsTitle = String.empty
        switch self {
        case .networkError:
            detailsTitle = R.string.common.networkInternetConnectionErrorTitle()
        default:
            break
        }
        
        return detailsTitle.isEmpty == false ? detailsTitle : defaultTitle
    }
    
    // swiftlint:disable:next cyclomatic_complexity
    static func handleError(_ error: Error, response: Response) -> ServerError {
        let responseCode = response.statusCode
        
        var errorDetails = ErrorDetails()
        errorDetails.statusCode = responseCode
        
        let serverError: ServerError
        switch responseCode {
        case 200:
            errorDetails.message = R.string.common.networkDecodingErrorText()
            errorDetails.error = error
            serverError = .systemError(details: errorDetails)
        case 400:
            serverError = .badRequest(details: errorDetails)
        case 401:
            serverError = .unauthorized(details: errorDetails)
        case 403:
            serverError = .forbidden(details: errorDetails)
        case 404:
            serverError = .notFound(details: errorDetails)
        case 500:
            serverError = .internalServerError(details: errorDetails)
        case 502:
            serverError = .badGateway(details: errorDetails)
        case 503:
            serverError = .serviceUnavailable(details: errorDetails)
        case 504:
            errorDetails.message = R.string.common.networkGatewayTimeOutErrorText()
            errorDetails.error = error
            serverError = .gatewayTimeOut(details: errorDetails)
        default:
            errorDetails.error = error
            serverError = .unknown(details: errorDetails)
        }
        
        return serverError
    }

    static func mapError(_ error: MoyaError) -> ServerError {
        var details = ErrorDetails(error: error)

        if
            case let .underlying(error, _) = error,
            let errorCode = error.asAFError?.getErrorCode(),
            isNetworkErrorCode(errorCode)
        {
            details.message = R.string.common.networkInternetConnectionErrorText()
            return .networkError(details: details)
        }

        return .swiftError(details: details)
    }

    private static func isNetworkErrorCode(_ errorCode: Int) -> Bool {
        let isNetworkErrorCode = errorCode == NSURLErrorNotConnectedToInternet ||
        errorCode == NSURLErrorNetworkConnectionLost ||
        errorCode == NSURLErrorDataNotAllowed

        return isNetworkErrorCode
    }
}

private extension AFError {
   func getErrorCode() -> Int? {
       if case .sessionTaskFailed(let sessionTaskError) = self {
           return (sessionTaskError as NSError).code
       }

       return responseCode
   }
}
