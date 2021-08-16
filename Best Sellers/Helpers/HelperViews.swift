//
//  HelperViews.swift
//  Best Sellers
//
//  Created by Ivan Villanueva on 16/08/21.
//

import Foundation
import SwiftUI


//MARK: -SearchBar
struct SearchBar:View {
    @Binding var search:String
    @Binding var isSearching:Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("LightGray"))
            
            HStack(spacing: 0) {
                Image(systemName: "magnifyingglass")
                
                TextField("Search books...", text:$search) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            isSearching = true
                        }
                    }
                } onCommit: {
                    withAnimation {
                        isSearching =  false
                    }
                }
            }//end HStack
            .foregroundColor(.gray)
            .padding(.leading, 13)
        }//end ZStack
        .frame(height: 40)
        .cornerRadius(13)
        .padding()
    }
}
