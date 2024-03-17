import Foundation

struct Filter {
    var years: (left: Int, right: Int)
    var ratings: (left: Double, right: Double)
    var countries: [String]? = nil
    var genres: [String]? = nil
}
