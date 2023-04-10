import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    private var presenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        setupPresenter()
        getTemplate()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "GenericTableViewCell", bundle: nil), forCellReuseIdentifier: "GenericTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupPresenter() {
        presenter = HomePresenter()
        presenter?.delegate = self
    }
    
    private func getTemplate() {
        presenter?.getAnimeList()
    }
}

extension HomeViewController: HomePresenterDelegate {
    func fetchSuccess() {
        tableView.reloadData() /// Realimentar a tableview com todos seus métodos
    }
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
}

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

