//
//  SelectionView.swift
//  doggie
//
//  Created by Maggie Gong on 7/6/24.
//

import SwiftUI

struct SelectionView: View {
    @Binding var isSelected: Bool
    @State var color: Color
    @State var text: String
    @State var image: String
    
    var body: some View {
        HStack{
            ZStack{
                Rectangle()
                    .frame(width: 90, height: 60)
                    .foregroundColor(isSelected ? color : .clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(isSelected ? Color.clear : Color.black, lineWidth: 1)
                    )
                    .cornerRadius(15)
                VStack{
                    Image(systemName: image)
                        .foregroundColor(isSelected ? Color.white : Color.black)
                        .padding(.top)
                        .fontWeight(.light)
                    Text(text)
                        .foregroundColor(isSelected ? Color.white : Color.primary)
                        .padding(.bottom)
                        .fontWeight(.light)
                }
            }
        }
    }
}

#Preview {
    SelectionView(isSelected: .constant(false), color: .blue, text: "Walk", image: "figure.walk.motion")
}
