//
//  PetHomeView.swift
//  doggie
//
//  Created by Maggie Gong on 7/4/24.
//

import SwiftUI
import CoreData

struct PetContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Meal.date, ascending: true)], animation: .default)
    private var meals: FetchedResults<Meal>
    
    var body: some View {
        TabView{
            MealView()
                .tabItem {
                    Label("Meal", systemImage: "carrot")
                }
            
            ActivityView()
                .tabItem {
                    Label("Activity", systemImage: "dumbbell")
                }
            ReminderView()
                .tabItem {
                    Label("Reminder", systemImage: "bell.and.waves.left.and.right")
                }
            NotesView()
                .tabItem {
                    Label("Summary", systemImage: "pencil.line")
                }
        }
    }
    func find(){
        
    }
    
    func createPetProfile(family: Family){
        let pet = Family(context: viewContext)
        pet.name = family.name
    }
}

#Preview{
    PetContentView()
}
