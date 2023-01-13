//
//  onBoardingView.swift
//  SampleCoreData
//
//  Created by Maryam on 19/06/1444 AH.
//


import Foundation
import SwiftUI

struct Val
{
var BGimage: Int
var title: String
var description: String
var skip: String
}

// Struct for onBoardingView
struct onBoardingView: View {
    
    @State var values: Val

    var body: some View{
        
        GeometryReader{ geo in
            ZStack{
                Image("\(values.BGimage)")
                    .resizable()
                    .ignoresSafeArea(.all)
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .opacity(1.0)
                
                    Text(values.skip)
                   .padding(.all)
                   .font(.system(size: 28))
//                   .fontWeight(.light)
                   .foregroundColor(.gray.opacity(1))
                   .padding([.top], -350)
                   .padding([.leading], 300)
                   
                Text(values.title)
                    //.font(.title).bold()
                    .fontWeight(.bold)
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .padding([.top], 300)
                
                Text(values.description)
                    .fontWeight(.regular)
                    .font(.system(size: 24))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding([.top], 400)
            }
            
        }
    }
    
}
struct onBoardingView_Perview: PreviewProvider{
    static var previews: some View{
        onBoardingView(values: .init(BGimage: 1,title: "Hello",description: "decs", skip: "Skip"))
    }
}

