//
//  PetHomeView.swift
//  doggie
//
//  Created by Maggie Gong on 7/4/24.
//

import SwiftUI

struct PetContentView: View {
    var body: some View {
        TabView{
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

#Preview {
    PetContentView()
}
