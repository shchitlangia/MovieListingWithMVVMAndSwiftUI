//
//  ViewModifiers.swift
//  PopularMovies
//
//  Created by Shweta Chitlangia on 04/08/23.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .padding()
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}
