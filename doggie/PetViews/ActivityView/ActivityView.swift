//
//  activityView.swift
//  doggie
//
//  Created by Maggie Gong on 7/4/24.
//

import SwiftUI
import CoreData

struct ActivityView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Activity.date, ascending: true)],
        animation: .default)
    private var activities: FetchedResults<Activity>

    @State private var walkingSelected = false
    @State private var hikingSelected = false
    @State private var frisbeeSelected = false
    @State private var swimmingSelected = false
    @State private var showAlert = false //controls the state of the alart
    @State private var alertText = ""
    @State private var startTime = Date()
    @State private var endTime = Date()

    @State private var passedActivity: Activity?
    @State private var selectedActivity: String?
    @State private var selectedDate: Date?
    @State private var selectedTime: String?
    
    init(passedActivity: Activity? = nil) {
        self.passedActivity = passedActivity
        _selectedActivity = State(initialValue: passedActivity?.activityName ?? "")
        _selectedDate = State(initialValue: passedActivity?.date ?? Date())
    }
    
    var body: some View {
//        Text("activity - coming soon")
        ScrollView{
            //Date
            HStack{
                Text("Today is")
                    .foregroundColor(Color.gray)
                Text(formattedDate())
                    .bold()
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30.0)
            VStack(alignment: .center){
                //Buttons
                HStack(spacing: 5){
                    //button 1
                    SelectionView(
                        isSelected: $walkingSelected,
                        color: .orange,
                        text: "Walking",
                        image: "figure.walk.motion")
                    .onTapGesture {
                        walkingSelected.toggle()
                        if(walkingSelected){
                            hikingSelected = false
                            frisbeeSelected = false
                            swimmingSelected = false
                        }
                    }
                    
                    //button 2
                    SelectionView(
                        isSelected: $hikingSelected,
                        color: .green,
                        text: "Hiking",
                        image: "figure.hiking")
                    .onTapGesture {
                        hikingSelected.toggle()
                        if(hikingSelected){
                            walkingSelected = false
                            frisbeeSelected = false
                            swimmingSelected = false
                        }
                    }
                    
                    //button 3
                    SelectionView(
                        isSelected: $frisbeeSelected,
                        color: .purple,
                        text: "Frisbee",
                        image: "circle.circle")
                    .onTapGesture {
                        frisbeeSelected.toggle()
                        if(frisbeeSelected){
                            walkingSelected = false
                            hikingSelected = false
                            swimmingSelected = false
                        }
                    }
                    
                    //button 4
                    SelectionView(
                        isSelected: $swimmingSelected,
                        color: .blue,
                        text: "Swimming",
                        image: "water.waves")
                    .onTapGesture {
                        swimmingSelected.toggle()
                        if(swimmingSelected){
                            walkingSelected = false
                            hikingSelected = false
                            frisbeeSelected = false
                        }
                    }
                }
                HStack(alignment: .center){
                    HStack {
                        VStack(alignment: .leading, spacing: 0){
                            Text("From:").font(.caption2).foregroundColor(.gray)
                            DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .clipped()
                        }
                        VStack(alignment: .leading, spacing: 0){
                            Text("To:").font(.caption2).foregroundColor(.gray)
                            DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .clipped()
                        }
                    }.padding(.leading, 30.0)
                    Spacer()
                    Button("Save"){
                        if(walkingSelected){
                            alertText = "walking"
                            selectedActivity = "walking"
                            saveActivity(selectedActivity: selectedActivity ?? "")
                        }
                        else if(hikingSelected){
                            alertText = "hiking"
                            selectedActivity = "hiking"
                            saveActivity(selectedActivity: selectedActivity ?? "")
                        }
                        else if(frisbeeSelected){
                            alertText = "frisbee"
                            selectedActivity = "frisbee"
                            saveActivity(selectedActivity: selectedActivity ?? "")
                        }
                        else if(swimmingSelected){
                            alertText = "swimming"
                            selectedActivity = "swimming"
                            saveActivity(selectedActivity: selectedActivity ?? "")
                        }
                        else{
                            print("saving nothing")
                        }
//                        showAlert.toggle()
                    }
                    .padding(.horizontal, 30)
                        .padding(.vertical, 10.0)
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1))
                        .fontWeight(.light)
//                    .alert(alertText, isPresented: $showAlert){
//                        Button("Continue"){
//                            
//                        }
//                    }
                    Spacer()
                }
//                Text("Time Difference: \(timeDifference())")
//                            .font(.caption)
//                            .padding(.top, 20)
                
            }
            Divider().padding(.all, 5.0)
            ForEach(activities){activity in
                HStack {
                    VStack(alignment: .leading, spacing: 0){
                        Text("Date:").font(.caption2).foregroundColor(.gray)
                        Text(formattedDate(activity.date))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 0){
                        Text("Activity:").font(.caption2).foregroundColor(.gray)
                        Text(activity.activityName ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 0){
                        Text("Duration:").font(.caption2).foregroundColor(.gray )
                        Text(activity.activityTime ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer()
                    Button(role: .destructive) {
                        delete(activity: activity)
                        } label: {
                            Label("", systemImage: "trash").foregroundColor(.black)
                    }
//                    Spacer()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(color: .black.opacity(0.1), radius: 5))
                .padding(.horizontal)
                .foregroundColor(.black)
            }
        }
    }
    
    private func timeDifference() -> String {
            let calendar = Calendar.current
            let difference = calendar.dateComponents([.hour, .minute], from: startTime, to: endTime)
            
            if let hour = difference.hour, let minute = difference.minute {
                return String(format: "%02d:%02d", hour, minute)
            } else {
                return "00:00"
            }
        }
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: Date())
    }
    
    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
    private func saveActivity(selectedActivity: String?) {
        selectedTime = timeDifference()
           withAnimation {
               guard let activity = selectedActivity, !activity.isEmpty,
                     let date = selectedDate,
                     let time = selectedTime, !activity.isEmpty
               else {
                   print("No activity selected")
                   return
               }

               let newActivity = Activity(context: viewContext)
               newActivity.activityName = activity
               newActivity.date = date // Assuming there's a date attribute
               newActivity.activityTime = time
                              
               do {
                   try viewContext.save()
                   print("saving \(activity)")
               } catch {
                   let nsError = error as NSError
                   print("Unresolved error \(nsError), \(nsError.userInfo)")
               }
           }
       }
    
    private func delete(activity: Activity) {
        withAnimation {
            viewContext.delete(activity)

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
    ActivityView()
}
