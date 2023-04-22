//
//  CellTagsView.swift
//  TestTask
//
//  Created by Демьян on 23.04.2023.
//

import SwiftUI

struct CellTagsView: View {
    let name: String?
    var body: some View {
        HStack {
            Text("• \(name ?? "???")")
                .font(.openSans(.regular, size: 14))
                .foregroundColor(Color.customColor(.greySecondary))
        }
    }
}
