import UIKit
/// Herdar de AnyObject fará com que apenas classes possam ser criadas conforme este protocolo. Obs.: class está deprecated
protocol HomePresenterDelegate: AnyObject {
    func showLoading()
    func removeLoading()
    func reloadTableView()
    func showAlert()
    func showEmptyList()
}

class HomePresenter {
    
    private let homeService: AnimeListService
    weak var delegate: HomePresenterDelegate? /// weak em delegate evita memory leak pois evita retenção de ciclos
    
    var animeData = [AnimeModel]()
    
    init(homeService: AnimeListService = AnimeListService()) {
        self.homeService = homeService
    }
    
//MARK: - FUNCTIONS -
    func getAnimeList() {
        self.delegate?.showLoading()
        self.homeService.animeModelService(to: Endpoint.fetchAnimeList.rawValue) { response in
            switch response{
            case .success(let animeList):
                self.delegate?.removeLoading()
                animeList.count > 0 ? self.animeMapper(animeData: animeList) : self.delegate?.showEmptyList()
                break
            case .failure:
                self.delegate?.removeLoading()
                self.delegate?.showAlert()
                break
            }
        }
    }
}

//MARK: - MAPPER -
extension HomePresenter {
    func animeMapper(animeData: [AnimeModel]) {
        self.animeData = animeData
    }
}

//MARK: - CELL BUILDER -

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
}
