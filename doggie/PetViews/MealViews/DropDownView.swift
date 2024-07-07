//
//  DropDownView.swift
//  doggie
//
//  adapted from https://youtu.be/7NSOcE3EvOs?si=DYNa-ZvXrNeftfy0
//  Created by Maggie Gong on 7/5/24.
//

import SwiftUI

struct DropDownView: View {
    let times: [String] = ["a.m", "p.m"]
    let options: [String] = ["Open Farm", "Redbarn", "A Pup Above", "Wellness Complete Health"]
    let amounts: [String] = ["1 cup", "2 cup", "3 cup"]
    
    @State private var isOptionsExpanded = false   //tracks if the menu has been expanded
    @State private var isTimesExpanded = false
    @State private var isAmountsExpanded = false
    
    @Binding var mealSelection: String?     //tracks which option is selected and makes it a state property in the parent view
    @Binding var timeSelection: String?
    @Binding var amountSelection: String?
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Today is")
                    .foregroundColor(Color.gray)
                Text(formattedDate())
                    .bold()
            }
            HStack{
                //prompt 1
                VStack(alignment: .leading){
                    //drop down
                    VStack{
                        HStack{
                            if(timeSelection == ""){
                                Text("time").foregroundColor(.gray)
                            }
                            else{
                                Text(timeSelection!)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .rotationEffect(.degrees(isTimesExpanded ? -180 : 0))    //if taps, rotate the arrow
                        }
                        .frame(height: 40)
                        .padding(.horizontal)
                        .onTapGesture {
                            withAnimation(.snappy){
                                isTimesExpanded.toggle()
                            }
                        }
                        if isTimesExpanded {
                            VStack{
                                ForEach(times, id: \.self){time in
                                    HStack{
                                        Text(time)
                                            .foregroundStyle((timeSelection == time) ? Color.primary : .gray)
                                        Spacer()
                                        if(timeSelection == time){
                                            Image(systemName: "checkmark")
                                                .font(.subheadline)
                                        }
                                    }
                                    .frame(height: 40)
                                    .padding(.horizontal)
                                    .onTapGesture {
                                        withAnimation(.snappy){
                                            timeSelection = time
                                            isTimesExpanded.toggle()
                                        }
                                    }
                                }
                            }
                            .transition(.move(edge: .bottom))
                        }
                    }
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 4)
                    .frame(width: 95)
                }
                
                //prompt 2
                VStack(alignment: .leading){
                //drop down
                VStack{
                    HStack{
                        if(mealSelection == ""){
                            Text("brand").foregroundColor(.gray)
                        }
                        else{
                            Text(mealSelection!)
                        }
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .rotationEffect(.degrees(isOptionsExpanded ? -180 : 0))    //if taps, rotate the arrow
                    }
                    .frame(height: 40)
                    .padding(.horizontal)
                    .onTapGesture {
                        withAnimation(.snappy){
                            isOptionsExpanded.toggle()
                        }
                    }
                    if isOptionsExpanded {
                        VStack{
                            ForEach(options, id: \.self){option in
                                HStack{
                                    Text(option)
                                        .foregroundStyle((mealSelection == option) ? Color.primary : .gray)
                                    Spacer()
                                    if(mealSelection == option){
                                        Image(systemName: "checkmark")
                                            .font(.subheadline)
                                    }
                                }
                                .frame(height: 40)
                                .padding(.horizontal)
                                .onTapGesture {
                                    withAnimation(.snappy){
                                        mealSelection = option
                                        isOptionsExpanded.toggle()
                                    }
                                }
                            }
                        }
                        .transition(.move(edge: .bottom))
                    }
                }
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 4)
                .frame(width: 135)
                }
                
                //prompt 3
                VStack(alignment: .leading){
                //drop down
                VStack{
                    HStack{
                        if(amountSelection == ""){
                            Text("amt").foregroundColor(.gray)
                        }
                        else{
                            Text(amountSelection!)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .rotationEffect(.degrees(isAmountsExpanded ? -180 : 0))    //if taps, rotate the arrow
                    }
                    .frame(height: 40)
                    .padding(.horizontal)
                    .onTapGesture {
                        withAnimation(.snappy){
                            isAmountsExpanded.toggle()
                        }
                    }
                    if isAmountsExpanded {
                        VStack{
                            ForEach(amounts, id: \.self){amount in
                                HStack{
                                    Text(amount)
                                        .foregroundStyle((amountSelection == amount) ? Color.primary : .gray)
                                    Spacer()
                                    if(amountSelection == amount){
                                        Image(systemName: "checkmark")
                                            .font(.subheadline)
                                    }
                                }
                                .frame(height: 40)
                                .padding(.horizontal)
                                .onTapGesture {
                                    withAnimation(.snappy){
                                        amountSelection = amount
                                        isAmountsExpanded.toggle()
                                    }
                                }
                            }
                        }
                        .transition(.move(edge: .bottom))
                    }
                }
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 4)
                .frame(width: 90)
                }
            }
        }
    }
    func formattedDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            return dateFormatter.string(from: Date())
        }
}

#Preview {
    DropDownView(mealSelection: .constant("C"), timeSelection: .constant("p.m"), amountSelection: .constant("3c."))
}
