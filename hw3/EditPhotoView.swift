//
//  EditPhotoView.swift
//  hw3
//
//  Created by 郭垣佑 on 2020/4/30.
//  Copyright © 2020 郭垣佑. All rights reserved.
//

import SwiftUI

struct EditPhotoView: View {
    @State private var scale: CGFloat = 1
    @State private var brightnessAmount: Double = 0
    @State private var loveTime = Date()
    @State private var reservePhone = false
    @State private var amount = 0
    @State private var mail:String = ""
    @State private var showAlert = false

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    var roles = [ "black", "white","red"]
    @State private var selectedName = "black"
    @State private var showSecondPage = false
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Form {
                    Image("\(self.selectedName)")
                    .resizable()
                    .scaledToFill()
                        .frame(width: geometry.size.width,height: geometry.size.width/4*3.5)
                    .scaleEffect(self.scale)
                    .brightness(self.brightnessAmount)
                    .clipped()
                    .overlay(Button(action:{
                        self.showSecondPage = true
                    }){
                        Image(systemName: "magnifyingglass.circle.fill")
                        .imageScale(.large)
                        .padding()
                    }.sheet(isPresented: self.$showSecondPage) {
                        SecondView(showSecondPage: self.$showSecondPage, selectedName: self.$selectedName)
                    }
                        , alignment: .topLeading)
                    
                    
                    Picker(selection: self.$selectedName, label: Text("Color")) {
                        ForEach(self.roles, id: \.self) { (role) in
                            Text(role)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    
                    Stepper(value: self.$amount, in: 0...5) {
                        Text("數量：\(self.amount) 支")
                   }
                       
                    sliderview(scale: self.$scale)
                    Toggle("預購", isOn: self.$reservePhone)
                    if self.reservePhone {
                        VStack {
                            DatePicker("日期", selection: self.$loveTime, in: Date()...DateComponents(calendar: Calendar.current, year: 2025, month: 12, day: 31).date!,displayedComponents: .date)
                            Text(self.dateFormatter.string(from: self.loveTime))
                        }
                    }
                    Text("價格：\(self.amount*14500)")
                    VStack {
                        TextField("email", text: self.$mail, onEditingChanged: { (editing) in
                          print("onEditingChanged", editing)
                       })
                        {
                          print(self.mail)
                       }
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       Button("購買") {
                          print(self.mail)
                        self.showAlert = true
                       }
                    }
                    .alert(isPresented: self.$showAlert) { () -> Alert in
                       let result: String
                       if self.amount == 0 {
                          result = "你沒有買"
                       }  else {
                          result = "你沒錢買"
                       }
                       return Alert(title: Text(result))
                    }
                }
                
                
            }
            
            
        }
    }
}

struct EditPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        EditPhotoView()
    }
}

struct sliderview: View {
    @Binding  var scale: CGFloat
    
    var body: some View {
        HStack {
            Text("縮放")
            Slider(value: self.$scale, in: 0.1...2, step: 0.1, minimumValueLabel: Image(systemName: "sun.max.fill").imageScale(.small), maximumValueLabel: Image(systemName: "sun.max.fill").imageScale(.large)) {
                Text("")
            }
        }
    }
}
