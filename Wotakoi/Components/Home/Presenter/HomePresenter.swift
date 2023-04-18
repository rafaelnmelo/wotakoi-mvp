import UIKit
/// Herdar de AnyObject fará com que apenas classes possam ser criadas conforme este protocolo. Obs.: class está deprecated
protocol HomePresenterDelegate: AnyObject {
    func showLoading()
    func removeLoading()
    func showAlert()
    func showEmptyList()
    func showAnimeList()
}

class HomePresenter {
    
    private let homeService: AnimeListService
    weak var delegate: HomePresenterDelegate? /// weak em delegate evita memory leak pois evita retenção de ciclos
    
    var animeData: AnimeModel?
    var animeList: [Anime]?
    
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
                animeList.results?.count ?? 0 > 0 ? self.fillData(animeList: animeList) : self.delegate?.showEmptyList()
                break
            case .failure:
                self.delegate?.removeLoading()
                self.delegate?.showAlert()
                break
            }
        }
    }
    
    func fillData(animeList: AnimeModel) {
        self.animeMapper(animeData: animeList)
        self.delegate?.showAnimeList()
    }
}

//MARK: - MAPPER -
extension HomePresenter {
    func animeMapper(animeData: AnimeModel) {
        self.animeData = animeData
        let results = animeData.results
        self.animeList = results?.filter( { $0.genreIds!.contains(16) } )
    }
}

//MARK: - CELL BUILDER -

extension HomePresenter {
    func numberOfModelsRows() -> Int{
        return animeList?.count ?? 0
    }
    
    func animeForRow(at indexPath: IndexPath) -> GenericTableViewCellController.Content{
        let data = GenericTableViewCellController.Content(
            id: "\(self.animeList?[indexPath.row].id ?? 0)" ,
            name: self.animeList?[indexPath.row].title,
            summary: self.animeList?[indexPath.row].overview,
            picture: self.animeList?[indexPath.row].backdropPath,
            airedYear: self.animeList?[indexPath.row].releaseDate,
            rating: "\(Float(self.animeList?[indexPath.row].voteAverage ?? 0))")
        return data
    }
}
