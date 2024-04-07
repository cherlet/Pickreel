enum MediaType {
    case movies
    case series
    
    func getOpposite() -> MediaType {
        switch self {
        case .movies:
            return .series
        case .series:
            return .movies
        }
    }
}
