import Foundation
import Alamofire
/// Todas chamadas de serviço
protocol NetworkManagerProtocol {
    func getFromServer(by endpoint: String, callback: @escaping (_ response: AFDataResponse<Data?>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    public static var shared: NetworkManagerProtocol = NetworkManager()

    func getFromServer(by endpoint: String, callback: @escaping (_ response: AFDataResponse<Data?>) -> Void) {
        
        AF.request(endpoint).response { response in
            callback(response)
        }
    }
}
