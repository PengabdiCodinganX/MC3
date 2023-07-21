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
    
    var body: some View {
        VStack {
            SingleTextField(placeholder: "Name...", text: $viewModel.name)
            
            Spacer()
            
            Toggle("Allow push notifications", isOn: $viewModel.isPushNotificationPermissionAllowed)
                .onChange(of: viewModel.isPushNotificationPermissionAllowed, perform: viewModel.handleOnPushNotificationsPermissionToggled)
            Toggle("Allow access mirophone", isOn: $viewModel.isMicrophonePermissionAllowed)
                .onChange(of: viewModel.isMicrophonePermissionAllowed, perform: viewModel.handleOnMicrophonePermissionToggled)
            
            HStack {
                Spacer()
                
                PrimaryButton(text: buttonType.rawValue) {
                    handleOnClicked()
                }
                .disabled(!viewModel.isPermissionsAllowed())
            }
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
        
        viewModel.setOnboardingFinished(true)
    }
}

struct PermissionView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionView(viewModel: PermissionViewModel())
    }
}
