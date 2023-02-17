//
//  CoreDataStack.swift
//  JsonPlaceholder-iOS
//
//  Created by Paolo Torregrosa on 17/02/23.
//

import Combine
import CoreData

protocol DataProvider {
    var usersPublisher: Published<[User]>.Publisher { get }
    func addNewUser(id: Int32, name: String, email: String, phone: String)
    func deleteUser(_ user: User)
    var postsPublisher: Published<[Post]>.Publisher { get }
    func addNewPost(userId: Int32, id: Int32, title: String, body: String)
    func deletePost(_ post: Post)
}

class CoreDataStack {
    private var managedObjectContext: NSManagedObjectContext
    private var canellables = Set<AnyCancellable>()
    @Published var users: [User] = []
    @Published var posts: [Post] = []
    
    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
        publishUsers()
        publishPosts()
    }
    
    // MARK: Users
    
    private func allUsers() -> [User] {
        do {
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            return try self.managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
            return []
        }
    }
    
    private func saveUser() {
        do {
            try self.managedObjectContext.save()
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
        publishUsers()
    }
    
    private func removeAllUsers() {
        allUsers().forEach { el in
            managedObjectContext.delete(el)
        }
        saveUser()
    }
    
    private func publishUsers() {
        users = allUsers()
    }
    
    // MARK: Posts
    
    private func allPosts() -> [Post] {
        do {
            let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
            return try self.managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
            return []
        }
    }
    
    private func savePost() {
        do {
            try self.managedObjectContext.save()
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
        
        publishPosts()
    }
    
    private func removeAllPosts() {
        allPosts().forEach { el in
            managedObjectContext.delete(el)
        }
        savePost()
    }
    
    private func publishPosts() {
        posts = allPosts()
    }
}

extension CoreDataStack: DataProvider {
    var usersPublisher: Published<[User]>.Publisher {
        $users
    }
    
    var postsPublisher: Published<[Post]>.Publisher {
        $posts
    }
    
    func addNewUser(id: Int32, name: String, email: String, phone: String) {
        let user = User(context: managedObjectContext)
        user.name = name
        user.id = id
        user.email = email
        user.phone = phone
        saveUser()
    }
    
    func deleteUser(_ user: User) {
        self.managedObjectContext.delete(user)
        saveUser()
    }
    
    func addNewPost(userId: Int32, id: Int32, title: String, body: String) {
        let post = Post(context: managedObjectContext)
        post.userId = userId
        post.id = id
        post.title = title
        post.body = body
        savePost()
    }
    
    func deletePost(_ post: Post) {
        self.managedObjectContext.delete(post)
        savePost()
    }
}
