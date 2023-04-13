import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyCatalog: UIView!
    
    var presenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        setupPresenter()
        getTemplate()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "GenericTableViewCell", bundle: nil), forCellReuseIdentifier: "GenericTableViewCell")
    }
    
    private func setupPresenter() {
        presenter = HomePresenter()
        presenter?.delegate = self
    }
    
    private func getTemplate() {
        presenter?.getAnimeList()
    }
}

//MARK: - TABLE VIEW DELEGATE -
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
}

//MARK: - TABLE VIEW DATA SOURCE -
extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfModelsRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GenericTableViewCell", for: indexPath) as? GenericTableViewCellController {
            if let data = presenter?.animeForRow(at: indexPath) {
                cell.build(data: data)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        MARK: - TODO
    }
}

//MARK: - PRESENTER DELEGATE -
extension HomeViewController: HomePresenterDelegate {
    func showEmptyList() {
        self.emptyCatalog.isHidden = false
        self.tableView.isHidden = true
    }
    
    func showLoading() {
        self.showActivityIndicator()
    }
    
    func removeLoading() {
        self.removeActivityIndicator()
    }
    
    func reloadTableView() {
        tableView.reloadData() /// Realimentar a tableview com todos seus métodos
    }
    
    func showAlert() {
        self.showAlert(title: "Atenção", message: "Falha na obtenção do catálogo")
    }
}

