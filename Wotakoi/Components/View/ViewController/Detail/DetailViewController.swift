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
    var favorite = [String:Dictionary<String, String>]()
    var list = WotakoiConstants.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.build(data: data)
    }
    
    @IBAction func returnToList(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favor(_ sender: Any) {
        self.buildFav(data: data)
        if favoriteImg.isSelected {
            favoriteImg.isSelected = false
            list.removeFromFav(favorite)
        } else {
            favoriteImg.isSelected = true
            self.buildFav(data: data)
            list.addToFav(favorite)
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
        self.checkFav(data: data)
        
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
    
    func checkFav(data: Content) {
        let userDefaults = UserDefaults.standard
        let favoritesList = userDefaults.object(forKey: "favoritesList") as? [String:Dictionary<String, String>] ?? [:]
        
        for item in favoritesList {
            for subItem in item.value {
                if subItem.value == data.id {
                    favoriteImg.isSelected = true
                }
            }
        }
    }
    
    func buildFav(data: Content) {
        var content = [String:String]()
        content["id"] = data.id ?? ""
        content["name"] = data.name ?? ""
        content["summary"] = data.summary ?? ""
        content["picture"] = data.picture ?? ""
        content["airedYear"] = data.airedYear ?? ""
        content["genre"] = data.genre ?? ""
        self.favorite[data.id ?? ""] = content
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
