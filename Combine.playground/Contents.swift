import UIKit
import Combine

let myUrl = URL(string: "https://cat-fact.herokuapp.com/facts")!

func requestData(_ completion: @escaping (Result<Data, Error>) -> Void){
    URLSession.shared.dataTask(with: myUrl) { data, response, error in
        if let error = error {
            completion(.failure(error))
        }
        
        guard let data = data else {
            preconditionFailure("I don't understand")
        }
        
        completion(.success(data))
    }.resume()
}

var myCats: Data? = nil

requestData { result in
    switch result {
    case .success(let data):
        myCats = data
        print(myCats ?? "you have no CATTT!")
    case .failure(let error):
        print(error)
    }
}

// MARK: - Response
struct Response: Codable {
    let all: [All]
}

// MARK: - All
struct All: Codable {
    let id, text, type: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case text, type
    }
}



