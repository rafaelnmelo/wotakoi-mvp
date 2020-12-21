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
    
    func favoriteMapper() {
//        let data = userDefaults.object(forKey: "favoritesList") as? [String:Dictionary<String, String>] ?? [:]
//
//        self.animeData = data
//
//        for item in animeData {
//            for subItem in item.value {
//                self.animeData = subItem as AnimeModel
//                self.favoritesList[subItem.key] = subItem.value
//            }
//
//        }
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
        return favoritesList.count
    }
    
    func favoriteForRow(at indexPath: IndexPath) -> GenericTableViewCellController.Content{
//        self.favoriteMapper()
//        
//        for dados in favoritesList {
//            let data = GenericTableViewCellController.Content(
//                id: dados[indexPath.row].id,
//                name: dados["name"],
//                summary: dados["summary"],
//                picture: dados["picture"],
//                airedYear: dados["airedYear"])
//            return data
//        }
        return GenericTableViewCellController.Content()

    }
    
}
