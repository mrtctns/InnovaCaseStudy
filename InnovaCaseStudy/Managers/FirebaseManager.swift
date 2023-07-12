//
//  FirebaseManager.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 12.07.2023.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class FirebaseManager {
    static let shared = FirebaseManager()
    
    func addUser(name: String, email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] _, error in
            if error != nil {
                print(error ?? "error")
                completion(.failure(error!))
            } else {
                Firestore.firestore().collection("User").document(Auth.auth().currentUser!.uid).setData([
                    "name": name,
                    "wallet": 0,
                    "userid": "\(Auth.auth().currentUser!.uid)",
                    "email": Auth.auth().currentUser!.email!,
                    
                ])
                completion(.success("Succes"))
            }
        }
    }
    
    func fetchCurrentUserDetails(completion: @escaping (_ user: User?) -> Void) {
        var user = User()
        let docRef = Firestore.firestore().collection("User").document("\(Auth.auth().currentUser!.uid)")
        docRef.getDocument { document, err in

            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if let document = document, document.exists {
                    let documentData = document.data()
                    guard let documentData = documentData else { return }
                    
                    user.email = documentData["email"] as? String
                    user.name = documentData["name"] as? String
                    user.userid = documentData["userid"] as? String
                    user.wallet = documentData["wallet"] as? Double
                    
                    completion(user)
                }
            }
        }
    }

    func fetchUserTransactions(completion: @escaping (_ transaction: [Transactions?]) -> Void) {
        var transactions: [Transactions] = []
        let docRef = Firestore.firestore().collection("User").document("\(Auth.auth().currentUser!.uid)").collection("Transactions")
        
        docRef.getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    // Firestore belge verilerini alın
                    let documentData = document.data()
                        
                    // Firestore verilerini modele dönüştürün
                    if let jsonData = try? JSONSerialization.data(withJSONObject: documentData, options: []),
                       let transaction = try? JSONDecoder().decode(Transactions.self, from: jsonData)
                    {
                        // Başarıyla modele dönüştürüldü
                        transactions.append(transaction)
                    }
                }
                completion(transactions)
            }
        }
    }

    func addTransactions(object: Transactions, completion: @escaping (Result<String, Error>) -> Void) {
        let docRef = Firestore.firestore().collection("User").document("\(Auth.auth().currentUser!.uid)").collection("Transactions").document(object.id)
        
        do {
            let jsonData = try JSONEncoder().encode(object)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            docRef.setData(jsonObject as? [String: Any] ?? [:]) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success("Succes"))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
