//
//  SwiftUIView.swift
//  Best Sellers
//
//  Created by Ivan Villanueva on 14/08/21.
//

import Foundation

struct Main: Codable {
    let numResults: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case numResults = "num_results"
        case results
    }
}

struct Result: Codable {
    let id:UUID = UUID()
    let listName, listNameEncoded: String

    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case listNameEncoded = "list_name_encoded"
    }
}

// MARK: -Categories
class Categories:ObservableObject {
    @Published var categories:[Result] = []
    
    func FetchCategories(urlString:String) {
        let url = URL(string: urlString)
        
        //Check the url is not nil
        guard url != nil else {
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            // Check for errors and that data is not missing
            if error == nil && data != nil {
                // Parse JSON
                let deocder = JSONDecoder()
                do {
                    let categories_ = try deocder.decode(Main.self, from: data!)
                    DispatchQueue.main.async {
                        self.categories = categories_.results
                    }
                } catch {
                    print("Error parsing JSON")
                    print(error)
                }
            }
        }// end dataTask
        // Make the API call
        dataTask.resume()
    }// end FetchCategories()
}
