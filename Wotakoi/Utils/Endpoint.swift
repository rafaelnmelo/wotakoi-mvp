import Alamofire

public enum Endpoint {
    case fetchAnimeList
    
    var rawValue: String {
        switch self {
        case .fetchAnimeList:
            return BaseURL.domain + "/animes"
        }
    }
}

public struct BaseURL {
    static var domain = "https://demo2372265.mockable.io"
}
