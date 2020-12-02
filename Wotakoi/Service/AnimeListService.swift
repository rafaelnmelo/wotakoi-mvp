import Alamofire

public enum ResponseError: Error {
    case internetError
    case decodeError
    case dataNotFound
}

final class AnimeListService {
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func animeModelService(to endpoint: String, callback: @escaping (Result<AnimeModel, ResponseError>) -> Void ) {
        
        self.networkManager.getFromServer(by: endpoint) { response in
            switch response.result {
            case .success:
                let decoder = JSONDecoder()
                guard let jsonData = response.data, let _ = response.value, let animeModel = try?  decoder.decode(AnimeModel.self, from: jsonData) else {
                    callback(.failure(.decodeError))
                    return
                }
                callback(.success(animeModel))
            case .failure:
                callback(.failure(.dataNotFound))
            }
        }
    }
}
