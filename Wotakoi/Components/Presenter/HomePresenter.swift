import UIKit
/// Herdar de AnyObject fará com que apenas classes possam ser criadas conforme este protocolo. Obs.: class está deprecated
protocol HomePresenterDelegate: AnyObject {
    func fetchSuccess()
}

class HomePresenter {
    
    private let homeService: AnimeListService
    weak var delegate: HomePresenterDelegate? /// weak em delegate evita memory leak pois evita retenção de ciclos
    
    var animeData = [AnimeModel]()
    var userDefaults = UserDefaults.standard
    var favoritesList = [String:String]()
    
    init(homeService: AnimeListService = AnimeListService()) {
        self.homeService = homeService
    }
    
//MARK: - Functions
    
    func getAnimeList() {
        self.homeService.animeModelService(to: Endpoint.fetchAnimeList.rawValue) { response in
            switch response{
            case .success(let animeModel):
                self.animeMapper(animeData: animeModel)
                self.delegate?.fetchSuccess()
                break
            case .failure:
                break
            }
            
        }
    }

}

//MARK: - ObjectMappers
extension HomePresenter {

    func animeMapper(animeData: [AnimeModel]) {
        self.animeData = animeData
    }
    
    func favoriteMapper() -> [GenericTableViewCellController.Content] {
        let data = userDefaults.object(forKey: "favoritesList") as? [String:Dictionary<String, String>] ?? [:]
        
        var anime = [String:String]()
        var content = [GenericTableViewCellController.Content]()
        
        for item in data {
            for subItem in item.value {
                switch subItem.key {
                case "id":
                    anime["id"] = subItem.value
                case "name":
                    anime["name"] = subItem.value
                case "summary":
                    anime["summary"] = subItem.value
                case "picture":
                    anime["picture"] = subItem.value
                case "airedYear":
                    anime["airedYear"] = subItem.value
                default:
                    anime["genre"] = subItem.value
                }
            }
                
                
                let favorites = GenericTableViewCellController.Content(
                    id: anime["id"] ?? "",
                    name: anime["name"] ?? "",
                    summary: anime["summary"] ?? "",
                    picture: anime["picture"] ?? "",
                    airedYear: anime["airedYear"] ?? "",
                    genre: anime["genre"] ?? "")
                
                content.append(favorites)
        }
        return content
    }
    
}

//MARK: - Cells Builders

extension HomePresenter {
    
    func numberOfModelsRows() -> Int{
        return animeData.count
    }
    
    func animeForRow(at indexPath: IndexPath) -> GenericTableViewCellController.Content{
        let data = GenericTableViewCellController.Content(
            id: self.animeData[indexPath.row].id,
            name: self.animeData[indexPath.row].name,
            summary: self.animeData[indexPath.row].summary,
            picture: self.animeData[indexPath.row].picture,
            airedYear: self.animeData[indexPath.row].airedYear)
        return data
    }
    
    func animeDetail(at indexPath: IndexPath) -> DetailViewController.Content{
        let data = DetailViewController.Content(
            id: self.animeData[indexPath.row].id,
            name: self.animeData[indexPath.row].name,
            summary: self.animeData[indexPath.row].summary,
            picture: self.animeData[indexPath.row].picture,
            airedYear: self.animeData[indexPath.row].airedYear)
        return data
    }
    
    func favoritesRows() -> Int{
        return self.favoriteMapper().count
    }
    
    func favoriteForRow() -> [GenericTableViewCellController.Content]{
        return self.favoriteMapper()
    }
    
}
