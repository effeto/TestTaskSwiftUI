//
//  ContentView.swift
//  TestTask
//
//  Created by Демьян on 22.04.2023.
//

import SwiftUI
import ActivityIndicatorView

struct ContentView: View {
    
    @EnvironmentObject var viewModel: ContentViewViewModel
    @State private var searchText = ""
    var body: some View {
        VStack {
            searchBar
                .padding([.trailing, .leading], 16)
                .padding(.bottom, 24)
                .onChange(of: searchText) { newValue in
                    if newValue.count >= 3 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.viewModel.searching = true
                            if let data = self.viewModel.vendors?.vendors {
                                let forAppend = data.filter ({($0.companyName ?? "").contains(searchText)})
                                self.viewModel.data?.vendors?.removeAll(keepingCapacity: false)
                                self.viewModel.data?.vendors?.append(contentsOf: forAppend)
                                if self.viewModel.data?.vendors?.isEmpty == true {
                                    self.viewModel.data = nil
                                }
                            }
                        }
                    } else {
                        self.viewModel.searching = false
                        self.viewModel.data = self.viewModel.vendors
                    }
                }
                if let data = self.viewModel.data?.vendors {
                    List(0..<data.count, id: \.self) { index in
                            VStack {
                                CellImageHeader(url: data[index].coverPhoto?.mediaURL ?? "", city: data[index].areaServed ?? "", favorited: data[index].favorited ?? false)
                                VStack(alignment: .leading) {
                                    if let categories = data[index].categories {
                                        CellCompanyNameAndCategory(companyName: data[index].companyName ?? "", categories: categories)
                                    }
                                    HStack {
                                        ForEach(data[index].tags!) { tag in
                                            CellTagsView(name: tag.name ?? "")
                                        }
                                    }
                                }
                            }
                            .onAppear(perform: {
                                if self.viewModel.searching != true {
                                    if self.viewModel.shouldLoadData(id: index) {
                                        self.viewModel.fetchNewData { }
                                    }
                                }
                            })
                            .listRowSeparator(.hidden)
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
            self.viewModel.fetchData()
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
