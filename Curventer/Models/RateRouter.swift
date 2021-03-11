import Foundation
import Alamofire

enum RateRouter {
    case fetchLatestRatesOnBase(String)
    case fetchRatesOnDateOnBase(String, String)
    case fetchRateOnBaseSymbol(String, String)
}

// MARK: - Extensions
extension RateRouter: EndpointType {
    var baseURL: String {
        "https://api.ratesapi.io/api"
    }
    
    var headers: HTTPHeader? {
        return nil
    }
    
    var path: String {
        switch self {
        case .fetchRatesOnDateOnBase(let date, _):
            return "/\(date)"
        default:
            return "/latest"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .fetchLatestRatesOnBase(let base):
            return ["base": base]
        case .fetchRatesOnDateOnBase(_, let base):
            return ["base": base]
        case .fetchRateOnBaseSymbol(let base, let symbol):
            //TODO: Remove
            print("PARAMETERS: \(["base": base, "symbols": symbol])")
            return ["base": base, "symbols": symbol]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var fullURL: URL {
        switch self {
        default:
            //TODO: Remove 
            print("URL: \(self.baseURL) + \(self.path)")
            return URL(string: self.baseURL + self.path)!
        }
    }
}

