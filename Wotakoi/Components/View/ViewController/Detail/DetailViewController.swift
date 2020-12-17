import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var animeImg: UIImageView!
    @IBOutlet weak var animeTitle: UILabel!
    @IBOutlet weak var animeGenre: UILabel!
    @IBOutlet weak var animeAiredYear: UILabel!
    @IBOutlet weak var animeSummary: UILabel!
    @IBOutlet weak var animeID: UILabel!
    @IBOutlet weak var favoriteImg: UIButton!
    
    var data = Content()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.build(data: data)
    }
    @IBAction func returnToList(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favor(_ sender: Any) {
        if favoriteImg.isSelected {
            favoriteImg.isSelected = false
//            MARK: - TODO Remove from favorites list
        } else {
            favoriteImg.isSelected = true
//            MARK: - TODO ADD to favorites list
        }
    }
}

extension DetailViewController {
    struct Content {
        var id: String?
        var name: String?
        var summary: String?
        var picture: String?
        var airedYear: String?
        var genre: String?
    }
    
    func build(data: Content) {
        if let url = data.picture {
            guard let baseURL = URL(string: "https://i.stack.imgur.com/y9DpT.jpg") else {return}
            self.downloadImage(from: URL(string: url) ?? baseURL)
        }
        self.animeTitle.text = data.name ?? ""
        self.animeGenre.text = "Gênero: \(data.genre ?? "")"
        self.animeAiredYear.text = "Estréia: \(data.airedYear ?? "")"
        self.animeSummary.text = data.summary ?? ""
        self.animeID.text = "Código de referência: \(data.id ?? "")"
        
    }
}

extension DetailViewController {
    func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getImageData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.animeImg.image = UIImage(data: data)
            }
        }
    }
}
