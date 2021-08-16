//
//  BookDetail.swift
//  Best Sellers
//
//  Created by Ivan Villanueva on 13/08/21.
//

import SwiftUI

struct BookDetail: View {
    var book:Book
    
    init(book:Book) {
        self.book = book
    }
    var body: some View {
        VStack{
            ScrollView {
                VStack(alignment: .leading, spacing: nil){
                    Text("Description")
                        .bold()
                        .font(.title3)
                    Text(book.bookDescription)
                        .lineLimit(nil)
                    Spacer()
                    HStack {
                        Text("isbn10:")
                            .bold()
                        Text(book.primaryIsbn10)
                    }
                    HStack {
                        Text("isbn13:")
                            .bold()
                        Text(book.primaryIsbn13)
                    }
                    
                }.frame(width: 360, alignment: .topLeading)
                
                Spacer()
                Image(uiImage: book.bookImage.loadImage())
                Spacer()
                NavigationLink( destination: BuyLinks(links:book), label: {
                    Text("Where to buy")
                        .bold()
                        .font(.title2)
                        .frame(width: 210, height: 50)
                        .background(Color("LinkBlue"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
            }
            
        }
        .navigationTitle(book.title.capitalized)
        .frame(minWidth: 0, maxWidth: 363, minHeight: 0, maxHeight: .infinity)
    }// end body
}

struct BookDetail_Previews: PreviewProvider {
    static var previews: some View {
        BookDetail(book: BSList().bsBooks.first!)
    }
}
