import Foundation
import Alamofire

protocol EndpointType {
    var baseURL: String { get }
    var path: String { get }
    var headers: HTTPHeader? { get }
    var parameters: [String: String]? { get }
    var httpMethod: HTTPMethod { get }
    var fullURL: URL { get }
}

