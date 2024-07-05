//
//  PetEditView.swift
//  doggie
//
//  Created by Maggie Gong on 7/4/24.
//

import SwiftUI
import CoreData

struct PetEditView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext

    @State private var name: String
    @State private var joinedDate: Date
    @State private var birthDate: Date
    
    private var passedPet: Family?
    
    //initialize a new Family entity
    init(passedPet: Family? = nil, initialDate: Date = Date()) {
        self.passedPet = passedPet
        _name = State(initialValue: passedPet?.name ?? "")
        _joinedDate = State(initialValue: passedPet?.joinedDate ?? initialDate)
        _birthDate = State(initialValue: passedPet?.birthDate ?? initialDate)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Pet")) {
                TextField("Enter Pet Name", text: $name)
            }
            Section(header: Text("Date")) {
                VStack{
                    DatePicker("Birth Date", selection: $birthDate, displayedComponents: .date)
                        .padding(.bottom)
                    DatePicker("Joined on family on ", selection: $joinedDate,     displayedComponents: .date)
                }
            }
            Section {
                Button("Save") {
                    saveAction()
                }
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    private func saveAction() {
        withAnimation {
            if let pet = passedPet {
                pet.name = name
                pet.joinedDate = joinedDate
                pet.birthDate = birthDate
            } else {
                let newPet = Family(context: viewContext)
                newPet.name = name
                newPet.joinedDate = joinedDate
                newPet.birthDate = birthDate
            }

            do {
                print("Attempting to save: \(name), \(joinedDate), \(birthDate)")
                try viewContext.save()
                print("Saved pet named \(name) with birthdate \(birthDate) and joined on \(joinedDate)")
                self.presentationMode.wrappedValue.dismiss()
            } catch {
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

// Preview
struct PetEditView_Previews: PreviewProvider {
    static var previews: some View {
        PetEditView()
    }
}
