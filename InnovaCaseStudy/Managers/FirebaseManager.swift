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
                let docRef = Firestore.firestore().collection("User").document("\(Auth.auth().currentUser!.uid)")
                let user = User(email: email, name: name, userid: Auth.auth().currentUser?.uid , wallet: Price(value: 0, currency: .TRY))
                do {
                    let jsonData = try JSONEncoder().encode(user)
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
    }
    func updateWallet(isExpense: Bool, cash: Double, currencyType: Price.CurrencyType, completion: @escaping (Result<String, Error>) -> Void) {
        guard let currentUser = Global.shared.currentUser else {
            completion(.failure(NSError(domain: "User not found", code: 0, userInfo: nil)))
            return
        }

        let newValue = isExpense ? (currentUser.wallet!.value - cash) : (currentUser.wallet!.value + cash)
        let newWallet = Price(value: newValue, currency: currencyType)
        let docRef = Firestore.firestore().collection("User").document(Auth.auth().currentUser!.uid)

        let walletData: [String: Any] = [
            "value": newWallet.value,
            "currency": newWallet.currency!.rawValue
        ]

        docRef.updateData(["wallet": walletData]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success("Cüzdan güncellendi"))
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
                    
                    if let jsonData = try? JSONSerialization.data(withJSONObject: documentData, options: []),
                       let transaction = try? JSONDecoder().decode(User.self, from: jsonData)
                    {
                        
                        user = transaction
                    }
                    
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
                    
                    let documentData = document.data()
                        
                    if let jsonData = try? JSONSerialization.data(withJSONObject: documentData, options: []),
                       let transaction = try? JSONDecoder().decode(Transactions.self, from: jsonData)
                    {
                        
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
