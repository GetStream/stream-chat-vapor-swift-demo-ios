import Foundation
import UIKit

enum AuthResult {
    case success
    case failure
}

class Auth: ObservableObject {
    static let keychainKey = "STREAM-VAPOR-API-KEY"
    let apiHostname: String
    
    @Published
    private(set) var isLoggedIn = false
    
    init(apiHostname: String) {
        self.apiHostname = apiHostname
        if token != nil {
            self.isLoggedIn = true
        }
    }
    
    var token: String? {
        get {
            Keychain.load(key: Auth.keychainKey)
        }
        set {
            if let newToken = newValue {
                Keychain.save(key: Auth.keychainKey, data: newToken)
            } else {
                Keychain.delete(key: Auth.keychainKey)
            }
            DispatchQueue.main.async { [weak self] in
                self?.isLoggedIn = newValue != nil
            }
        }
    }
    
    func logout() {
        token = nil
    }
}
