//
//  MealView.swift
//  doggie
//
//  Created by Maggie Gong on 7/4/24.
//

import SwiftUI
import CoreData

struct MealView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Meal.meal, ascending: true)],
        animation: .default)
    private var meals: FetchedResults<Meal>
    
    @State private var selectedOption: String?
    @State private var selectedTime: String?
    @State private var selectedAmount: String?
    @State private var selectedDate: Date?
    
    @State private var passedMeal: Meal?
    
    init(passedMeal: Meal? = nil) {
        self.passedMeal = passedMeal
        _selectedTime = State(initialValue: passedMeal?.time ?? "")
        _selectedOption = State(initialValue: passedMeal?.meal ?? "")
        _selectedAmount = State(initialValue: passedMeal?.amount ?? "")
        _selectedDate = State(initialValue: passedMeal?.date ?? Date())
    }
    
    var body: some View {
        ScrollView{
            HStack{
                Spacer()
                VStack(alignment: .leading){
                    DropDownView(mealSelection: $selectedOption, timeSelection: $selectedTime, amountSelection: $selectedAmount)
                        .padding([.top, .leading, .trailing])
                    HStack{
                        Spacer()
                        Button("Save") {
                            saveMeal()
                        }
                        .frame(width: 200) // Set the width of the button
                        .padding(.vertical, 5.0)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .cornerRadius(10)
                        Spacer()
                    }
                }
                .padding(.bottom, 8.0)
                .background(.white)
                .cornerRadius(15)
                .shadow(color: .black.opacity(0.1), radius: 3, x: 3, y: 3)
                
                Spacer()
            }
            Divider().frame(height: 0.5).background(.black).padding()
            
            ForEach(meals){meal in
                HStack {
                    Text(formattedDate(meal.date))
                        .frame(maxWidth: 70, alignment: .leading)
                    Spacer()
                    Text(meal.time ?? "")
                        .frame(maxWidth: 50, alignment: .leading)
                    Spacer()
                    Text(meal.meal ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Text(meal.amount ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Button(role: .destructive) {
                        delete(meal: meal)
                        } label: {
                        Label("", systemImage: "trash")
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(color: .black.opacity(0.1), radius: 5))
                .padding(.horizontal)
                .foregroundColor(.black)
            }
        }
    }
    
    private func formattedDate(_ date: Date?) -> String {
            guard let date = date else { return "" }
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            return dateFormatter.string(from: date)
        }
    
    private func saveMeal() {
            withAnimation {
                guard let time = selectedTime, !time.isEmpty,
                      let option = selectedOption, !option.isEmpty,
                      let amount = selectedAmount, !amount.isEmpty,
                      let date = selectedDate
                else {
                    print("Input values are missing")
                    return
                }

                if let meal = passedMeal {
                    meal.time = time
                    meal.meal = option
                    meal.amount = amount
                    meal.date = date
                } else {
                    let newMeal = Meal(context: viewContext)
                    newMeal.time = time
                    newMeal.meal = option
                    newMeal.amount = amount
                    newMeal.date = date
                }

                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    print("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    private func delete(meal: Meal) {
        withAnimation {
            viewContext.delete(meal)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
//        MealView(family: Pet(name: "a", joinedDate: Date(), birthDate: Date()))
        MealView()
}
