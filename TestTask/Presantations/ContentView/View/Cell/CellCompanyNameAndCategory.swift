//
//  CellCompanyNameAndCategory.swift
//  TestTask
//
//  Created by Демьян on 23.04.2023.
//

import SwiftUI
import SDWebImageSwiftUI
import WrappingHStack

struct CellCompanyNameAndCategory: View {
    let companyName: String?
    let categories: [Category]
    
    var body: some View {
        Text(self.companyName ?? "")
            .font(.openSans(.bold, size: 16))
            .foregroundColor(Color.customColor(.greyPrimary))
        VStack {
            if let categories = categories {
                WrappingHStack(categories) { category in
                    HStack {
                        WebImage(url: URL(string: category.image?.mediaURL ?? ""),
                                 context: [.imageThumbnailPixelSize : CGSize.zero])
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(Color.customColor(.greyPrimary))
                        Text(category.name ?? "")
                            .font(.openSans(.regular, size: 14))
                            .foregroundColor(Color.customColor(.greyPrimary))
                    }
                }
            }
        }
    }
}

