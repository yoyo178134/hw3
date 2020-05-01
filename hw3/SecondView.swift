//
//  SecondView.swift
//  hw3
//
//  Created by 郭垣佑 on 2020/5/1.
//  Copyright © 2020 郭垣佑. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    @Binding var showSecondPage: Bool
    @Binding  var selectedName:String
    var body: some View {
        VStack{
            Spacer()
            Image(selectedName)
            .resizable()
            .scaledToFit()
            Spacer()
            
        }.overlay(Button(action:{
            self.showSecondPage = false
        }){
            Image(systemName: "xmark.circle.fill")
            .imageScale(.large)
            .padding()
        }, alignment: .topLeading)
    
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(showSecondPage: .constant(true), selectedName: .constant("red"))
    }
}
