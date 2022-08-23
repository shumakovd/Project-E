//
//  FirebaseManager.swift
//  Project-E
//
//  Created by Shumakov Dmytro on 22.08.2022.
//

import Firebase
import Foundation
import FirebaseDatabase

final class FirebaseManager {

    /// The static field that controls the access to the singleton instance.
    /// This implementation let you extend the Singleton class while keeping
    /// just one instance of each subclass around.
    static var shared: FirebaseManager = {
            return FirebaseManager()
        }()

    private init() {}

    enum Result<T> {
        case success(T)
        case failure(String)
    }

    // MARK: - Properties -

    let ref = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
        
    // MARK: - Methods -
    
    func authWithEmail(parameters: Parameters, completion: @escaping (_ result: Bool) -> Void) {

        let users = ref.child("Users")
        
        let teacher     = parameters["teacher"] as? Bool ?? false
        let date      = parameters["date"] as? String ?? ""        
        let name      = parameters["name"] as? String ?? ""
        let email     = parameters["email"] as? String ?? ""
        let number    = parameters["number"] as? String ?? ""
        let password  = parameters["password"] as? String ?? ""
                
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error == nil {
                if let result = result {
                    // SAVE USER TO DB
                    users.child(result.user.uid).updateChildValues([
                        "teacher" : teacher,
                        "date" : date,
                        "name" : name,
                        "email": email,
                        "number": number])

                    completion(true)
                    print("Auth Completed. UID: ", result.user.uid)
                } else {
                    completion(false)
                    print(" Auth Error: \(String(describing: result))")
                }
            } else {
                completion(false)
                print(" Auth Error: \(String(describing: error))")
            }
        }
        users.removeAllObservers()
    }
    
    func authIfUserWithThisEmailExist(email: String, completion: @escaping (_ result: Bool) -> Void) {
        let users = ref.child("Users")
        users.queryOrdered(byChild: "u_email").queryEqual(toValue: email).observe(.value, with: { snapshot in
            if snapshot.exists(){
                completion(false)
            } else {
                completion(true)
            }
            users.removeAllObservers()
        })
    }
    
    
    func loginWithAdmin<T: Codable>(completion: @escaping (Result<T>) -> Void) {
        ref.child("RestaurantAdmins").observe(.childAdded) { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                do {
                    let json = try JSONSerialization.data(withJSONObject: value)
                    let decoder = JSONDecoder()
                    let decodedValues = try decoder.decode(T.self, from: json)
                    
                    completion(.success(decodedValues))
                    
                } catch {
                    completion(.failure(" Parse \(T.self) Model Error"))
                }
            } else {
                completion(.failure(" Snapshot Value Error"))
            }
        }
        ref.removeAllObservers()
    }

}
