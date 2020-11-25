struct Constants {
    static let clientID = "8947de064cc94317bc133bac6a75c33e"
    static let redirectURI = URL(string: "glade://callback")!
    static let sessionKey = "spotifySessionKey"
    static let tokenSwapURLString = "https://gladeapp.herokuapp.com/api/token"
    static let tokenSwapURL = URL(string: tokenSwapURLString)
    static let tokenRefreshURLString = "https://gladeapp.herokuapp.com/api/refresh_token"
    static let tokenRefreshURL = URL(string: tokenRefreshURLString)
}
