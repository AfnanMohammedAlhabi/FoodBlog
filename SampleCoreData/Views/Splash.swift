//
//  Splash.swift
//  SampleCoreData
//
//  Created by Maryam on 19/06/1444 AH.

import SwiftUI

struct Splash: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            x()
        } else {
            VStack {
                VStack {
                    Image("Sp")
                        .resizable()
                        .ignoresSafeArea()
//
                }
                
               
               .scaledToFit()
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.00
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct Splash_Previews: PreviewProvider {
    static var previews: some View {
        Splash()
    }
}
