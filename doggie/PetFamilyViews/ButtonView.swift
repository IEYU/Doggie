//
//  buttonView.swift
//  doggie
//
//  Created by Maggie Gong on 7/4/24.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        Group{
            NavigationLink(destination: PetEditView(initialDate: Date())){
                VStack{
                    Spacer()
                    Image(systemName: "pawprint").font(.largeTitle)
                    Spacer()
                    Text("Add Pet").font(.title)
                    Spacer()
                }
            }.fontWeight(.thin)
                .foregroundColor(.black)
                .frame(width: 200, height: 130)
                .background(Color.white.opacity(1))
                .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 1)
                    )
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
                .padding()
                .frame(alignment: .bottom)
        }
        .background(.clear)
    }
}

#Preview {
    ButtonView()
}
