import UIKit

class GenericTableViewCellController: UITableViewCell {
    
    @IBOutlet var animeImg: UIImageView!
    @IBOutlet var animeTitle: UILabel!
    
    var animeID: String?
    var animeSummary: String?
    var animePictureURL: String?
    var animeAiredYear: String?
    var animeGenre: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension GenericTableViewCellController {
    struct Content {
        var id: String?
        var name: String?
        var summary: String?
        var picture: String?
        var airedYear: String?
        var genre: String?
    }
    
    func build(data: Content) {
        self.animeID = data.id ?? ""
        self.animeTitle.text = data.name ?? ""
        self.animeSummary = data.summary ?? ""
        
        if let url = data.picture {
            guard let baseURL = URL(string: "https://i.stack.imgur.com/y9DpT.jpg") else {return}
            self.downloadImage(from: URL(string: url) ?? baseURL)
        }
        
        self.animeAiredYear = data.airedYear ?? ""
        self.animeGenre = data.genre ?? ""
        
    }
    
    
}

extension GenericTableViewCellController {
    func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getImageData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.animeImg.image = UIImage(data: data)
            }
        }
    }
}
