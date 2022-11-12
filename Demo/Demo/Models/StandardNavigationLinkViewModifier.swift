//
//  StandardNavigationLinkViewModifier.swift
//  Demo
//
//  Created by Farren Springer on 11/12/22.
//

import SwiftUI

struct StandardNavigationLinkViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .font(.title3)
            .frame(height: 30)
            .padding()
    }
}
