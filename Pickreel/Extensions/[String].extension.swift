extension Array where Element == String {
    func toString() -> String {
        return self.joined(separator: ", ")
    }
}
