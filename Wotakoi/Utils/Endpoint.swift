import Alamofire

public enum Endpoint {
    case fetchAnimeList
    
    var rawValue: String {
        switch self {
        case .fetchAnimeList:
            return BaseURL.domain + "/movie/popular" + ApiKey.defaultKey + QueryParameter.language + QueryParameter.imageLanguage + QueryParameter.pages
        }
    }
}

public struct ApiKey {
    static var defaultKey = "?api_key=1e4ba8bbb5c77a2861e8a23414ce6aed"
}

public struct BaseURL {
    static var domain = "https://api.themoviedb.org/3"
    static var imageDomain = "https://image.tmdb.org/t/p"
}

public struct QueryParameter {
    static var language = "&language=pt-BR"
    static var imageLanguage = "&include_image_language=en"
    static var pages = "&page=1"
}
