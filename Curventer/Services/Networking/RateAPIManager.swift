import Foundation
import Alamofire

struct RateAPIManager{
    static func fetch<T: Decodable>(type: T.Type, router: EndpointType, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(router.fullURL, method: router.httpMethod, parameters: router.parameters)
            .responseDecodable(of: type) { response in
                if let error = response.error {
                    completion(.failure(error))
                    return
                }
                guard let rates = response.value else {
                    completion(.failure(NetworkError.fetchError))
                    return
                }
                completion(.success(rates))
        }
    }
}
