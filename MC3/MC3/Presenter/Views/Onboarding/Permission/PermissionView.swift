//
//  PermissionView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import SwiftUI

struct PermissionView: View {
    @StateObject var viewModel: PermissionViewModel = PermissionViewModel()
    
    @State var buttonType: ButtonType = .done
    
    @Binding var isOnboardingFinished: Bool
    
    var body: some View {
        Spacer()
        
        SingleTextField(placeholder: "Name...", text: $viewModel.name)
        
        Spacer()
        
        Toggle("Allow push notifications", isOn: $viewModel.isPushNotificationPermissionAllowed)
            .onChange(of: viewModel.isPushNotificationPermissionAllowed, perform: viewModel.handleOnPushNotificationsPermissionToggled)
        Toggle("Allow access mirophone", isOn: $viewModel.isMicrophonePermissionAllowed)
            .onChange(of: viewModel.isMicrophonePermissionAllowed, perform: viewModel.handleOnMicrophonePermissionToggled)
        
        Spacer()
        
        HStack {
            Spacer()
            
            PrimaryButton(text: buttonType.rawValue) {
                handleOnClicked()
            }
            .disabled(!viewModel.isPermissionsAllowed())
        }
        .alert(isPresented: $viewModel.isError) {
            Alert(title: Text(viewModel.error))
        }
    }
    
    /// Handles next button clicked
    private func handleOnClicked() {
        switch buttonType {
        case .next, .getStarted: break
        case .done: self.handleOnDoneClicked()
        }
    }
    
    private func handleOnDoneClicked() {
        // Check for permissions
        guard viewModel.isPermissionsAllowed() else {
            return
        }
        
        isOnboardingFinished = true
    }
}

struct PermissionView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionView(viewModel: PermissionViewModel(), isOnboardingFinished: .constant(false))
    }
}
