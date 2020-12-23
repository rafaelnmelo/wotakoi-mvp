import Foundation

enum UserDefaultsKeys: String {
    case favoritesList
}

class WotakoiConstants {
    
    public static var shared = WotakoiConstants()
    var userDefaults = UserDefaults.standard
    var favoritesList = [String:Dictionary<String, String>]()

    func addToFav(_ anime: [String:Dictionary<String, String>]) {
        favoritesList = userDefaults.object(forKey: "favoritesList") as? [String:Dictionary<String, String>] ?? [:]
        for item in anime {
            favoritesList["\(item.key)"] = item.value
        }
        
        userDefaults.set(favoritesList, forKey: UserDefaultsKeys.favoritesList.rawValue)
    }
    
    func removeFromFav(_ anime: [String:Dictionary<String, String>]) {
        favoritesList = userDefaults.object(forKey: "favoritesList") as? [String:Dictionary<String, String>] ?? [:]
        guard let id = anime.first?.key else {return}
        favoritesList.removeValue(forKey: id)
        userDefaults.set(favoritesList, forKey: UserDefaultsKeys.favoritesList.rawValue)
    }
}
