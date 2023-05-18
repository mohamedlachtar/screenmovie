//
//  FaceIDView.swift
//  login
//
//  Created by Floki on 17/5/2023.
//

import SwiftUI
import LocalAuthentication

struct FaceIDView: View {
    @State private var unlocked = false
    var body: some View {
        VStack{
            if unlocked{
                Text ("tay" )
            }else{
                Text("mech tay")
                }
            }
        .onAppear(perform: Authent )
    }
    func Authent(){
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        {
            let reason = "We Need to scan your face. "
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
            localizedReason: reason)
            {success, AuthenticationError in
                if success{
                    //authent success
                    unlocked = true
                }else{
                    //there was a problem
                }
            }
        }else{
            //no biometrics
        }
    }
}

struct FaceIDView_Previews: PreviewProvider {
    static var previews: some View {
        FaceIDView()
    }
}
