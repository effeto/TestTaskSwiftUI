//
//  ContentView.swift
//  TestTask
//
//  Created by Демьян on 22.04.2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: ContentViewViewModel
    @State var vendors: SimpleModel?
    @State var data: SimpleModel?
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            searchBar
                .padding([.trailing, .leading], 16)
                .padding(.bottom, 24)
                .onChange(of: searchText) { newValue in
                    if newValue.count >= 3 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            if let data = vendors?.vendors {
                                let forAppend = data.filter ({$0.companyName!.contains(searchText)})
                                self.data?.vendors?.removeAll(keepingCapacity: false)
                                self.data?.vendors?.append(contentsOf: forAppend)
                                if self.data?.vendors?.isEmpty == true {
                                    self.data = nil
                                }
                            }
                        }
                    } else {
                        self.data = vendors
                    }
                }
            if let data = self.data?.vendors {
                List() {
                    ForEach(data) { row in
                        VStack {
                            CellImageHeader(url: row.coverPhoto?.mediaURL ?? "", city: row.areaServed ?? "", favorited: row.favorited ?? false)
                            VStack(alignment: .leading) {
                                if let categories = row.categories {
                                    CellCompanyNameAndCategory(companyName: row.companyName ?? "", categories: categories)
                                }
                                HStack {
                                    ForEach(row.tags!) { tag in
                                        CellTagsView(name: tag.name ?? "")
                                    }
                                }
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .frame( maxWidth: .infinity)
                .background(content: {
                    Color(hex: "FCFCFC").edgesIgnoringSafeArea(.all)
                })
                .listStyle(PlainListStyle())
            } else {
                Spacer()
                NoResultsView()
                Spacer()
            }
        }
        .onAppear(perform: {
            self.viewModel.fetchData { model in
                self.vendors = model
                self.data = model
            } failure: { error in
                print(error)
            }
            
        })
        .background(content: {
            Color(hex: "FCFCFC").edgesIgnoringSafeArea(.all)
        })
    }
    
    var searchBar: some View {
        HStack {
            TextField("Search...", text: $searchText)
                .font(Font.system(size: 21))
                .frame(height: 40)
                .padding(.leading, 14)
            Image("ic-search")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.gray)
                .padding(.trailing, 12)
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 0.5, x: 1, y: 2)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContentViewViewModel())
        
    }
}
