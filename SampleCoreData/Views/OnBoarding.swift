//
//  OnBoarding.swift
//  SampleCoreData
//
//  Created by Maryam on 19/06/1444 AH.
//

//  SampleCoreData
//
//  Created by Afnan on 12/01/2023.
//

import Foundation
import SwiftUI

struct x: View {
   private let dotAppearance = UIPageControl.appearance()
   @State var isPresent = false
   var body: some View {
       NavigationView{
       ZStack{
           TabView{
               ZStack {
                   onBoardingView(values: .init(BGimage: 1 ,title: "",description: " ", skip: "")).padding(.top, -20)
                   VStack{
                       Text("BLOG YOUR FOOD !")
                           .fontWeight(.bold)
                           .font(.system(size: 32))
                           .foregroundColor(.white)
                           .padding([.top], 300)
                       Button {
                           print(" ")
                           isPresent = true
                       } label: {
                           Text("Get Started")
                           
                           NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), isActive: $isPresent){}
                       }
                       .frame(width: 285, height: 50)
                       .font(.system(size: 20))
                       .foregroundColor(.white)
                       .background(Color("Button"))
                       .cornerRadius(10)
                       .padding(.top)
                   }
               }
           }
           
       }.ignoresSafeArea(.all)
       
   }

   }
}
                       
struct x_Previews: PreviewProvider {
   static var previews: some View {
       x()
   }
}
