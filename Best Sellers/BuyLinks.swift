//
//  BuyLinks.swift
//  Best Sellers
//
//  Created by Ivan Villanueva on 13/08/21.
//

import SwiftUI

struct BuyLinks: View {
    var links:Book
    
    var body: some View {
        VStack {
            ForEach(links.buyLinks, id: \.id) { link in
                Link(destination: URL(string: link.url)!, label: {
                    whichStore(storeName: link.name)
                })
            }
        }.navigationTitle("Online Stores")
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct whichStore:View {
    var storeName:String
    let otherColors:[Color] = [Color("OtherC1"), Color("OtherC2"), Color("OtherC3"), Color("OtherC4")]
    
    var body: some View {
        
        if storeName == "Amazon" {
            Text(storeName)
                .font(.title2)
                .frame(width: 210, height: 50)
                .background(Color("AmazonColor"))
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
        }
        else if storeName == "Apple Books" {
            Text(storeName)
                .font(.title2)
                .frame(width: 210, height: 50)
                .background(Color("AppleBooks"))
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
        }
        else {
            Text(storeName)
                .font(.title2)
                .frame(width: 210, height: 50)
                .background(otherColors.randomElement()!)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
        }
    }
}

struct BuyLinks_Previews: PreviewProvider {
    static var previews: some View {
        BuyLinks(links:BSList().bsBooks.last!)
    }
}
