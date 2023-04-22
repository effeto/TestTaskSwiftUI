//
//  CellImageHeader.swift
//  TestTask
//
//  Created by Демьян on 23.04.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct CellImageHeader: View {
    let url: String?
    let city: String?
    @State var favorited: Bool?
    
    var body: some View {
        ZStack {
            WebImage(url: URL(string: url ?? ""),
                     context: [.imageThumbnailPixelSize : CGSize.zero])
            .resizable()
            .frame(height: 170)
            .cornerRadius(10)
            VStack {
                HStack {
                    Spacer()
                    Image(self.favorited == true ? "ic-inactive" : "ic-selected")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .padding(.top, 10)
                }
                Spacer()
                HStack {
                    Text(self.city ?? "")
                        .foregroundColor(Color.customColor(.greyPrimary))
                        .font(.openSans(.regular, size: 14))
                        .padding([.leading,.trailing], 8)
                        .background {
                            Color.white
                                .cornerRadius(16)
                                .frame(height: 22)
                        }
                    Spacer()
                }
                .padding(.leading, 8 )
                .padding(.bottom, 16)
            }
        }
    }
}
