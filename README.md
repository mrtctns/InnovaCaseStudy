# Innova Case Study
### Introduction
This project is developed by Mert Çetin for the Innova company case study.

This project is developed to using UIKit and programmatic UI.
##### -Programmatic UI
##### -URLSession
##### -Firebase
##### -SnapKit
##### -MVC
##### -Singleton Pattern

### Network Manager
```Swift
func readJSONData<T: Decodable>(fileName: String, objectType: T.Type) throws -> T
```
This function reads the JSON file with the given fileName and decodes it into the specified objectType.
```Swift
func fetchCurrencyData(completion: @escaping (Result<[Currency], Error>) -> Void)
```
This code represents a function that fetches currency data from an API and returns the result through a completion handler.
```Swift
func exchangeCurrency(from: String, to: String, amount: Double, completion: @escaping (Result<Double, Error>)
```
This code defines a function that uses an API to convert a specified amount of currency from one type to another and returns the result through a completion handler.

### Firebase Manager
```Swift
func addUser(name: String, email: String, password: String, completion: @escaping (Result<String, Error>) -> Void)
```
This code defines a function that creates a user account with the provided name, email, and password using Firebase Authentication. Upon successful account creation, it also stores additional user information in Firestore database, including the user's email, name, unique user ID, and wallet details. The function returns the result of the operation through a completion handler, indicating success or failure.
```Swift
func updateWallet(isExpense: Bool, cash: Double, currencyType: Price.CurrencyType, completion: @escaping (Result<String, Error>) -> Void)
```
This code defines a function that updates the wallet balance of the currently logged-in user based on whether it's an expense or income. The function calculates the new wallet value by subtracting or adding the cash amount, depending on the isExpense parameter. It then updates the user's wallet data in the Firestore database with the new value and currency type. The result of the operation is returned through a completion handler, indicating success or failure.
```Swift
func fetchCurrentUserDetails(completion: @escaping (_ user: User?) -> Void)
```
This code defines a function that fetches the details of the currently logged-in user from Firestore database. It retrieves the document corresponding to the user's unique ID and checks if it exists. If the document exists, it retrieves the data, converts it into JSON data, and decodes it into a User object using JSONDecoder. The function returns the fetched user object through a completion handler.
```Swift
func fetchUserTransactions(completion: @escaping (_ transaction: [Transactions?]) -> Void)
```
This code defines a function that fetches the transactions of the currently logged-in user from Firestore database. It retrieves the collection of transactions belonging to the user and iterates through each document. For each document, it retrieves the data, converts it into JSON data, and decodes it into a Transactions object using JSONDecoder. The function accumulates the fetched transactions into an array and returns it through a completion handler.
```Swift
func addTransactions(object: Transactions, completion: @escaping (Result<String, Error>) -> Void)
```
This code defines a function that adds a transaction object to the Firestore database under the logged-in user's collection of transactions. The function takes the transaction object as a parameter, encodes it into JSON data using JSONEncoder, and converts it into a JSON object using JSONSerialization. It then sets the data of the Firestore document with the JSON object. The result of the operation is returned through a completion handler, indicating success or failure.
