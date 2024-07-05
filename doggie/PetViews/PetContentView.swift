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
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Pet.name, ascending: true)], animation: .default)
    private var pet: FetchedResults<Pet>
    
//    var family: Family
    
    var body: some View {
//        ForEach(items){item in
//            item.many.
//        }
        TabView{
//            MealView(family: family)
//            DropDownView(mealSelection: .constant("C"), timeSelection: .constant("p.m"), amountSelection: .constant("3c."))
            MealView()
                .tabItem {
                    Label("Home", systemImage: "carrot")
                }
            
            ActivityView()
                .tabItem {
                    Label("Activity", systemImage: "dumbbell")
                }
            
            NotesView()
                .tabItem {
                    Label("Notes", systemImage: "pencil.line")
                }
            
            ReminderView()
                .tabItem {
                    Label("Reminder", systemImage: "bell.and.waves.left.and.right")
                }
        }
    }
}

//struct PetContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        // Provide a sample Family instance for the preview
//        PetContentView(family: Pet())
//    }
//}
