struct AnimeModel: Codable {
    let id: String
    let name: String
    let summary: String
    let picture: String
    let airedYear: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "nome"
        case summary = "descricao"
        case picture = "fotoDoAnime"
        case airedYear = "anoDoAnime"
    }
}
