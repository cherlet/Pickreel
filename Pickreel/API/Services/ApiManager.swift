import Foundation

let apiKey = ["x-api-key": "7bcd876b-9e86-461d-a2af-f3a0ee6a571f"]

enum ApiType {
    case getFilms
    case getSeries
    case getStaff
    
    var baseURL: String {
        return "https://kinopoiskapiunofficial.tech/"
    }
    
    var headers: [String: String] {
        return apiKey
    }
    
    var path: String {
        switch self {
        case .getFilms: return "api/v2.2/films?type=FILM&order=NUM_VOTE"
        case .getSeries: return "api/v2.2/films?type=TV_SERIES&order=NUM_VOTE"
        case .getStaff: return "api/v1/staff"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseURL)!)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        return request
    }
}

class ApiManager {
    static let shared = ApiManager()
    
    func getFilms(completion: @escaping ([Item]) -> Void) {
        let request = ApiType.getFilms.request
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let films = try? JSONDecoder().decode(Films.self, from: data) {
                completion(films.items)
            } else {
                completion([])
            }
        }
        
        task.resume()
    }
    
    func getSeries(completion: @escaping ([Item]) -> Void) {
        let request = ApiType.getSeries.request
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let series = try? JSONDecoder().decode(Films.self, from: data) {
                completion(series.items)
            } else {
                completion([])
            }
        }
        
        task.resume()
    }
}
