import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var presenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        setupPresenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
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
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.favoritesRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GenericTableViewCell", for: indexPath) as? GenericTableViewCellController {
            if let data = presenter?.favoriteForRow(at: indexPath) {
                cell.build(data: data)
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension FavoritesViewController: HomePresenterDelegate {
    func fetchSuccess() {
        tableView.reloadData() /// Realimentar a tableview com todos seus métodos
    }
}
