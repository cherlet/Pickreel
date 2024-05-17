struct Iterator {
    var value = 0
    
    mutating func increase() {
        value += 1
    }
    
    mutating func reset() {
        value = 0
    }
    
    func isReachedMiddle(of number: Int) -> Bool {
        value == number / 2
    }
}
