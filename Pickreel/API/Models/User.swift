import Foundation

struct User: Identifiable, Codable {
    let id: String
    let nickname: String
    let email: String
}
