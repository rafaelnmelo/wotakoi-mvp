import UIKit

class GenericTableViewCellController: UITableViewCell {
    
    @IBOutlet weak var animeImg: UIImageView!
    @IBOutlet weak var animeTitle: UILabel!
    @IBOutlet weak var releaseDateLb: UILabel!
    @IBOutlet weak var ratingLb: UILabel!
    
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
        var rating: String?
    }
    
    func build(data: Content) {
        self.animeID = data.id ?? ""
        self.animeTitle.text = data.name ?? ""
        self.animeSummary = data.summary ?? ""
        self.releaseDateLb.text = data.airedYear
        self.ratingLb.text = data.rating
        
        if let pictureEndpoint = data.picture,
           let pictureURL = URL(string: BaseURL.imageDomain + "/w300" + pictureEndpoint) {
            self.animeImg.downloaded(from: pictureURL)
        }
        
        self.animeAiredYear = data.airedYear ?? ""
        self.animeGenre = data.genre ?? ""
        
    }
    
    
}


