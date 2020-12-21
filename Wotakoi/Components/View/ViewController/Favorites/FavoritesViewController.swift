import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var userDefaults = UserDefaults.standard
    var favoritesList = [String:Dictionary<String, String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupFavorites()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "GenericTableViewCell", bundle: nil), forCellReuseIdentifier: "GenericTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupFavorites() {
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GenericTableViewCell", for: indexPath) as? GenericTableViewCellController {
//            let data = GenericTableViewCellController.Content(
//                id: self.animeData[indexPath.row].id,
//                name: self.animeData[indexPath.row].name,
//                summary: self.animeData[indexPath.row].summary,
//                picture: self.animeData[indexPath.row].picture,
//                airedYear: self.animeData[indexPath.row].airedYear)
        }
        return UITableViewCell()
    }
    
    
}
