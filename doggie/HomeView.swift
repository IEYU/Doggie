//
//  HomeView.swift
//  doggie
//
//  Created by Maggie Gong on 7/3/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        let persistenceController = PersistenceController.shared
        NavigationStack(){
            VStack(alignment: .center, spacing: 20.0){
                //paw print
                Image(systemName: "pawprint")
                    .aspectRatio(contentMode: .fit)
                    .font(.system(size: 100, weight: .ultraLight))
                    .foregroundColor(.black)
                //title
                Text("Doggie")
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.light/*@END_MENU_TOKEN@*/)
                //footnote
                Text("Welcome to Doggie, your personal pet assistant")
                    .font(.footnote)
                    .fontWeight(.light)
                //record a day of ur pet's life
                Divider()
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                
                HStack{
                    Spacer()
                    //record button
                    NavigationLink(destination: PetFamilyView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)){
                        HStack{
                            Image(systemName: "pencil.and.scribble")
                            Text("Record")
                        }
                    }
                    Spacer()
                    //snap button
                    NavigationLink(destination: CameraView()){
                        HStack{
                            Image(systemName: "camera")
                            Text("Snap!")
                        }
                    }
                    Spacer()
                }.buttonStyle(.bordered)
                    .foregroundColor(.black)
                    .dynamicTypeSize(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)
                    .fontWeight(.light)
            }
        }
    }
}

#Preview {
    HomeView()
}
