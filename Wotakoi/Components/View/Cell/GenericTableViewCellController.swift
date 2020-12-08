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
    struct Data {
        var id: String?
        var name: String?
        var summary: String?
        var picture: String?
        var airedYear: String?
        var genre: String?
    }
    
    func build(data: Data) {
        self.animeID = data.id ?? ""
        self.animeTitle.text = data.name ?? ""
        self.animeSummary = data.summary ?? ""
        self.animePictureURL = data.picture ?? ""
        self.animeAiredYear = data.airedYear ?? ""
        self.animeGenre = data.genre ?? ""
    }
}
