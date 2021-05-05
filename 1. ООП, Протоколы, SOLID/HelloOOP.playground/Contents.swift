import Foundation

// MARK: ENTITY -

struct User: CustomStringConvertible {
    
    let id: Int
    let name: String
    var description: String {
        "User \(name) with id - \(id)"
    }
}

// MARK: - STORAGES -

protocol StorageProviderProtocol {
    static func load() -> [User]
    static func save(_ users: [User])
}

enum Default: StorageProviderProtocol {
    
    static func load() -> [User] {
        print("I don't know anything about users!")
        return []
    }
    
    static func save(_ users: [User]) {
        print("I don't know what to do with these users!")
    }
}

enum Server: StorageProviderProtocol {
    
    private static var users = [User]()
    
    static func load() -> [User] {
        return users
    }
    
    static func save(_ users: [User]) {
        self.users = users
    }
}

enum Database: StorageProviderProtocol {
    
    private struct UserModel {

        private let dataSeparator: Character = "|"
        
        var data: Data
        
        init(user: User) {
            let components = ["\(user.id)", user.name]
            
            data = components
                .joined(separator: String(dataSeparator))
                .data(using: .utf8) ?? Data()
        }
        
        func toUser() -> User? {
            guard let string = String(data: data, encoding: .utf8) else {
                return nil
            }
            
            let components = string
                .split(separator: dataSeparator)
                .map(String.init)
            
            guard components.count == 2 else { return nil }
            
            guard let idString = components.first,
                  let id = Int(idString),
                  let name = components.last else { return nil }
            
            return User(id: id, name: name)
        }
    }
    
    private static var users = [UserModel]()
    
    static func load() -> [User] {
        return users.compactMap { $0.toUser() }
    }
    
    static func save(_ users: [User]) {
        self.users = users.map(UserModel.init)
    }
}

// MARK: - MANAGERS -

protocol SourceManagementProtocol {
    var source: StorageProviderProtocol.Type { get }
}

// MARK: Abstraction
protocol UserCollectionable {
    var collection: [User] { get set }
}

class UsersCollectionManager: SourceManagementProtocol, UserCollectionable {
    
    var source: StorageProviderProtocol.Type { Default.self }
    
    private var isSavingNeeded = false
    
    var collection = [User]() {
        didSet {
            guard isSavingNeeded else { return }
            saveData()
        }
    }
    
    init() {
        print("\(source) connected")
        loadData()
    }
    
    deinit {
        print("\(source) disconnected")
    }
    
    // MARK: Encapsulation
    private func saveData() {
        source.save(collection)
        print("\(source)| Saved  collection with \(collection.count) elements")
    }
    
    private func loadData() {
        defer {
            isSavingNeeded = true
        }
        isSavingNeeded = false
        
        collection = source.load()
        print("\(source)| Loaded collection with \(collection.count) elements")
    }
}

// MARK: Inheritance
final class NetworkManager: UsersCollectionManager {
    
    override var source: StorageProviderProtocol.Type { Server.self }
}

final class DatabaseManager: UsersCollectionManager {
    
    override var source: StorageProviderProtocol.Type { Database.self }
}

// MARK: - APP -

final class AdminApp {
    
    // MARK: Polymorphism
    private var currentManager: UserCollectionable = UsersCollectionManager()
    var isNetworkAvailable: Bool = false {
        didSet {
            if isNetworkAvailable, oldValue == false {
                synchronizeNetwork()
            }
            
            setupManager()
        }
    }
    
    var users: [User] {
        get {
            currentManager.collection
        }
        set {
            currentManager.collection = newValue
            if isNetworkAvailable {
                synchronizeDatabase()
            }
        }
    }
    
    init(isNetworkAvailable: Bool = true) {
        self.isNetworkAvailable = isNetworkAvailable
        setupManager()
    }
    
    private func setupManager() {
        if isNetworkAvailable {
            currentManager = NetworkManager()
        } else {
            currentManager = DatabaseManager()
        }
    }
    
    private func synchronizeNetwork() {
        NetworkManager().collection = users
    }
    
    private func synchronizeDatabase() {
        DatabaseManager().collection = users
    }
}

// MARK: - PRINT HELPER -

func printStorageInfo(after action: String) {
    print()
    print("--------ACTION--------")
    print(action)
    print("--------SERVER--------")
    print(Server.load())
    print("-------DATABASE-------")
    print(Database.load())
    print()
}

// MARK: - EXPERIMENT -

// Launch App
var myApp: AdminApp? = AdminApp(isNetworkAvailable: true)

myApp?.users.append(User(id: 1, name: "Bob"))
myApp?.users.append(User(id: 2, name: "Bill"))

myApp?.isNetworkAvailable = false

myApp?.users.append(User(id: 3, name: "Jack"))

// Close App
myApp = nil

printStorageInfo(after: "Added 2 users with network and 1 without")

// Launch App
myApp = AdminApp(isNetworkAvailable: false)

myApp?.users.append(User(id: 4, name: "Jess"))

printStorageInfo(after: "Added user without network")

myApp?.isNetworkAvailable = true

printStorageInfo(after: "Connect to network")

myApp?.users.append(User(id: 5, name: "Mike"))

// Close App
myApp = nil

printStorageInfo(after: "Added user with network")
