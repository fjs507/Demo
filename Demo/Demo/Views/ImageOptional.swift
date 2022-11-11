//
//  ImageOptional.swift
//  Demo
//
//  Created by Farren Springer on 11/11/22.
//

import SwiftUI

struct ImageOptional: View {
    @Binding var image: Image?
    
    var body: some View {
        if let image = image {
            image
                .resizable()
                .scaledToFit()
        } else {
            Color.clear
        }
    }
}
