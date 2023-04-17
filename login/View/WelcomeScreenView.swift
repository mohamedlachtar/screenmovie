//
//  WelcomeScreenView.swift
//  login
//
//  Created by Apple Esprit on 14/3/2023.
//

import SwiftUI

struct WelcomeScreenView: View {
    @State private var isLinkActive = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    NavigationLink(
                        destination: SignInScreenView().navigationBarHidden(true),
                        isActive: $isLinkActive,
                        label: {
                          
                        })
                        .navigationBarHidden(true)
                }
                .padding()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.isLinkActive = true
            }
        }
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView()
    }
}

