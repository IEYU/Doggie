//
//  PetFamilyView.swift
//  doggie
//
//  Created by Maggie Gong on 7/4/24.
//

import SwiftUI
import CoreData

struct PetFamilyView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var newPet = Family()
    @State private var selection: Family?

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Family.joinedDate, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Family>

    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(items) { item in
                        NavigationLink(destination: PetContentView()){
                            FamilyCardView(family: item)
                        }
                        .buttonStyle(PlainButtonStyle()) // To prevent default link styling
                        .swipeActions {
                            Button(role: .destructive) {
                                delete(item: item)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                Spacer()
                ButtonView()
            }
            .background(Color(uiColor: .systemGray6)) // Set VStack background to clear
        }
        .edgesIgnoringSafeArea(.all) // Ignore safe area for full-screen background
    }
    
    private func createFamily(){
        let family = Family(context: viewContext)
        family.name = "User Family"
    }
    
    private func delete(item: Family) {
        withAnimation {
            viewContext.delete(item)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()

struct FamilyCardView: View {
    var family: Family

    var body: some View {
        HStack{
            Image(systemName: "pawprint").fontWeight(.regular).font(.title)
                .padding(.leading)
            Spacer()
            VStack(alignment: .leading) {
                Text(family.name ?? "Unknown Name")
                    .font(.headline)
                    .padding(.bottom, 2)
                Text("Birthday: \(family.birthDate ?? Date(), formatter: itemFormatter)")
                    .font(.subheadline)
                    .fontWeight(.light)
                Text("Joined the family on: \(family.joinedDate ?? Date(), formatter: itemFormatter)")
                    .font(.subheadline)
                    .fontWeight(.light)
            }
        }
        .padding(.trailing)
    }
}

#Preview {
    PetFamilyView()
}
