//
//  ContentView.swift
//  Best Sellers
//
//  Created by Ivan Villanueva on 13/08/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var books:BSList = BSList()
    @ObservedObject var categories:Categories = Categories()
    
    @State var searchBook:String = ""
    @State var isSearching:Bool = false
    
    @State var selected:String = ""
    @State var show:Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(search: $searchBook, isSearching: $isSearching)
                List {
                    ForEach(books.bsBooks.filter({ (book:Book) -> Bool in
                        return book.title.hasPrefix(searchBook) || searchBook == ""
                    }), id: \.id) { book in
                        NavigationLink(destination: BookDetail(book: book), label: {
                            BookCell(book: book)
                        })
                    }
                }
                .navigationTitle("Best Seller Books")
                .padding(.all, 0)
                .listStyle(PlainListStyle())
                .toolbar {
                    if isSearching {
                        Button("Cancel") {
                            searchBook = ""
                            withAnimation {
                                isSearching = false
                                UIApplication.shared.dismissKeyboard()
                            }
                        }
                    }//end Searching
                    
                    Button(action: {
                        self.show.toggle()
                    }) {
                        Text("Filters")
                    }.sheet(isPresented: $show) {
                        VStack {
                            Spacer()
                            RadioButtons(categories: categories, selected:self.$selected, show: self.$show)
                        }
                    }// end sheet
                }// end toolbar
                .gesture(DragGesture().onChanged({_ in
                    UIApplication.shared.dismissKeyboard()
                }))
                .onAppear {
                    books.MakeCall(urlString: "https://api.nytimes.com/svc/books/v3/lists/current/e-book-nonfiction.json?api-key=eq6PYTbHyGv58wvEiw0djL3sIMSM9LkF")
                    print(self.selected)
                }// end onAppear()
            }// end VStack
        }// end NaivgationView
    }
}

// MARK: -BookCell
struct BookCell:View {
    var book:Book
    
    var body: some View {
        VStack(alignment:.leading) {
            Text(book.title.capitalized)
                .font(.headline)
            
            Text("Author: " + book.author)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 3)
    }
}

// MARK: -RadioButtons
struct RadioButtons:View {
    @ObservedObject var categories:Categories
    
    @Binding var selected : String
    @Binding var show : Bool
    
    var body : some View{
        ScrollView {
            VStack(alignment: .leading, spacing: 15){
                Text("Filter By")
                    .font(.title)
                    .padding(.top)
                
                ForEach(categories.categories,id: \.id){ categorie in
                    Button(action: {
                        self.selected = categorie.listName
                    }) {
                        HStack {
                            Text(categorie.listName)
                            Spacer()
                            
                            ZStack {
                                Circle()
                                    .fill(self.selected == categorie.listName ? Color("CBSelected") : Color.black.opacity(0.2))
                                    .frame(width: 15, height: 15)
                                
                                if (self.selected == categorie.listName) {
                                    Circle()
                                        .stroke(Color("Color1"), lineWidth: 2)// Adds a border line color to the selected option
                                        .frame(width: 15, height: 15)
                                }
                            }// end ZStack
                        }// end HStack
                        .foregroundColor(.black)
                    }
                    .padding(.top)
                }// end ForEach
                
                HStack {
                    Spacer()
                    Button(action: {
                        self.show.toggle()
                    }) {
                        Text("Continue")
                            .padding(.vertical)
                            .padding(.horizontal, 25)
                            .foregroundColor(.white)
                    }
                    .background(self.selected != "" ? Color("Continue"): Color("Disabled"))
                    .foregroundColor(self.selected != "" ? Color(.white):Color("DisabledText"))
                    .clipShape(Capsule())
                    .disabled(self.selected != "" ? false : true)
                }// end HStack
                .padding(.top)
            }// end VStack
            .padding(.vertical)
            .padding(.horizontal,25)
            .padding(.trailing, 25)
            .padding(.bottom,(UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 5)
            .background(Color.white)
            .cornerRadius(30)
        }// end ScrollView
        .onAppear {
            categories.FetchCategories(urlString: "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=eq6PYTbHyGv58wvEiw0djL3sIMSM9LkF")
        }
    }
}

//MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
