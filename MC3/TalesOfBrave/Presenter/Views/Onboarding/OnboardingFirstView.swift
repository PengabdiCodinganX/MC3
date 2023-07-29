//
//  OnboardingFirstView.swift
//  MC3
//
//  Created by Muhammad Rezky on 28/07/23.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

enum OnboardingState{
    case first
    case second
    case third
    case permission
    
}

struct OnboardingFirstView: View {
    @StateObject private var viewModel: SignInViewModel = SignInViewModel()
    @StateObject var permissionViewModel: PermissionViewModel = PermissionViewModel()
    
    @State var state: OnboardingState = .first
    
    @Binding var isSignedIn: Bool
    @Binding var isOnboardingFinished: Bool
    
    func getSubmitText() -> String {
        switch state {
        case .first:
            return "Try Now !"
        case .second:
            return "Continue"
        case .third:
            return ""
        case .permission:
            return "Finish"
        }
    }
    
    
    var body: some View {
        ZStack{
            Color("AccentColor").edgesIgnoringSafeArea(.top)
            VStack(spacing: 0){
                Spacer()
                switch state {
                case .first:
                    Image("onboarding-illustration")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: 360) 
                case .second:
                    Mascot(mascotText: [TextTrack(text: "Hi..", track: "")], alignment: .vertical, mascotContentMode: .scaleAspectFit)
                case .third:
                    Mascot(mascotText: [TextTrack(text: "Are You Ready to Be Brave? Let's Get Started and Conquer Together!", track: "")], alignment: .vertical, mascotContentMode: .scaleAspectFit)
                        .padding(.top, 32)
                case .permission:
                    Mascot(mascotText: [TextTrack(text: "Lets setup your permission first", track: "")], alignment: .vertical, mascotContentMode: .scaleAspectFit)
                        .padding(.top, 32)
                }
                VStack(alignment: .leading, spacing: 0){
                    VStack(alignment: .leading, spacing: 0 ){
                        switch state {
                        case .first:
                            
                            Text("Welcome to Tales of Brave")
                                .fontDesign(.rounded)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 16)
                            Text("Even geniuses encounter challenges in life. Discover the tale that resonates with you right here!")
                                .lineSpacing(8)
                                .font(.title2)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .multilineTextAlignment(.leading)
                        case .second:
                            
                            Text("Meet Leo, your Courageous Guide!")
                                .fontDesign(.rounded)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 16)
                            Text("Talk about you problem & he'll ignite your spirit with triumphant tales so you can conquer anything!")
                            
                                .lineSpacing(8)
                                .font(.title2)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .multilineTextAlignment(.leading)
                        case .third:
                            EmptyView()
                        case .permission:
                            VStack(spacing: 24){
                                
                                Toggle("Allow push notifications", isOn: $permissionViewModel.isPushNotificationPermissionAllowed)
                                    .onChange(of: permissionViewModel.isPushNotificationPermissionAllowed, perform: permissionViewModel.handleOnPushNotificationsPermissionToggled)
                                Toggle("Allow access mirophone", isOn: $permissionViewModel.isMicrophonePermissionAllowed)
                                    .onChange(of: permissionViewModel.isMicrophonePermissionAllowed, perform: permissionViewModel.handleOnMicrophonePermissionToggled)
                                
                            }
                        }
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, (state != .third) ? 36 : 16)
                    
                    if(state != .third){
                        PrimaryButton(text: getSubmitText(), isFull: true){
                            print("tapped")
                            withAnimation(){
                                if(state == .first){
                                    state = .second
                                } else if(state == .second){
                                    state = .third
                                } else if(state == .third){
                                    state = .permission
                                } else {
                                    guard permissionViewModel.isPermissionsAllowed() else {
                                        print("[handleOnDoneClicked][isPermissionsAllowed]", false)
                                        return
                                    }
                                    
                                    isSignedIn = true
                                    
                                    isOnboardingFinished = true
                                
                                }
                            }
                        }
                    } else {
                        SignInWithAppleButton(.signIn,
                                              onRequest: viewModel.handleOnSignInRequest,
                                              onCompletion: viewModel.handleOnSignInCompletion)
                        .signInWithAppleButtonStyle(.black)
                        .frame(width: UIScreen.main.bounds.width - 64,height: 60)
                        .cornerRadius(16)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 32)
                .background(.white)
                .cornerRadius(16, corners: [.topLeft, .topRight])
                
            }
            
        }
        .onChange(of: viewModel.isSignedIn){_ in
            if(viewModel.isSignedIn == true){
                state = .permission
            }
        }
        .alert(isPresented: $viewModel.isError) {
            Alert(title: Text(viewModel.error))
        }
    }
}
//
//
//
//struct OnboardingFirstView: View {
//    var body: some View {
//        ZStack{
//            Color("AccentColor").edgesIgnoringSafeArea(.top)
//
//            VStack(spacing: 0){
//                Spacer()
//                Image("onboarding-illustration")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: UIScreen.main.bounds.width, height: 340)
//                VStack(alignment: .leading, spacing: 36){
//                    VStack(alignment: .leading, spacing: 16){
//                        Text("Welcome to Tales of Brave")
//                            .fontDesign(.rounded)
//                            .multilineTextAlignment(.leading)
//                        Text("Even geniuses encounter challenges in life. Discover the tale that resonates with you right here!")
//                            .lineSpacing(8)
//                            .font(.title2)
//                            .fontWeight(.bold)
//                            .fontDesign(.rounded)
//                            .multilineTextAlignment(.leading)
//                    }
//                    .padding(.horizontal, 16)
//                    PrimaryButton(text: "Try Now !", isFull: true){
//
//                    }
//                }
//                .padding(.horizontal, 16)
//                .padding(.vertical, 32)
//                .background(.white)
//                .cornerRadius(16, corners: [.topLeft, .topRight])
//
//            }
//
//        }
//    }
//}
//

struct OnboardingFirstView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFirstView(isSignedIn: .constant(false), isOnboardingFinished: .constant(false))
    }
}
