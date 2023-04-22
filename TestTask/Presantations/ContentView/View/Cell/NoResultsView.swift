//
//  NoResultsView.swift
//  TestTask
//
//  Created by Демьян on 23.04.2023.
//

import SwiftUI

struct NoResultsView: View {
    var body: some View {
        VStack {
            Text("Sorry! No results found...")
                .foregroundColor(Color.customColor(.darkGreen))
                .font(.openSans(.bold, size: 24))
            Text("Please try a different search request \nor browse businesses from the list")
                .foregroundColor(Color.customColor(.greyPrimary))
                .font(.openSans(.regular, size: 16))
                .multilineTextAlignment(.center)
        }
    }
}
