//
//  BS List.swift
//  Best Sellers
//
//  Created by Ivan Villanueva on 13/08/21.
//
import Foundation

struct Welcome: Codable {
    let status: String
    let numResults: Int
    let results: Results

    enum CodingKeys: String, CodingKey {
        case status
        case numResults = "num_results"
        case results
    }
}

struct Results: Codable {
    let displayName: String
    let books: [Book]

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case books
    }
}

struct Book: Codable {
    let id:UUID = UUID()
    let rank: Int
    let primaryIsbn10, primaryIsbn13, publisher, bookDescription: String
    let title, author, bookImage: String
    let buyLinks: [BuyLink]

    enum CodingKeys: String, CodingKey {
        case rank
        case primaryIsbn10 = "primary_isbn10"
        case primaryIsbn13 = "primary_isbn13"
        case publisher
        case bookDescription = "description"
        case title, author
        case bookImage = "book_image"
        case buyLinks = "buy_links"
    }
}

struct BuyLink: Codable {
    var id:UUID = UUID()
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}

// MARK: - BS_LIST class
class BSList:ObservableObject {
    @Published var bsBooks:[Book] = []
    
    func MakeCall(urlString:String) {
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
                    let books = try deocder.decode(Welcome.self, from: data!)
                    DispatchQueue.main.async {
                        self.bsBooks = books.results.books
                    }
                } catch {
                    print("Error parsing JSON")
                    print(error)
                }
            }
        }// end dataTask
        // Make the API call
        dataTask.resume()
    }// end MakeCall()

}// end BSList class
