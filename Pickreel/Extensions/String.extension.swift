extension String {
    func generateKeywords() -> [String] {
        guard !self.isEmpty else { return [] }
        var sequences: [String] = []
        
        for i in 1...self.count {
            let prefix = String(self.prefix(i)).lowercased()
            sequences.append(prefix)
        }
        
        let words = self.components(separatedBy: .whitespacesAndNewlines)
        if words.count > 1 {
            for word in words[1...] {
                sequences.append(contentsOf: word.generateKeywords())
            }
        }
        
        return sequences
    }
}
