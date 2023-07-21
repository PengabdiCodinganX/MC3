//
//  PermissionView.swift
//  MC3
//
//  Created by Muhammad Adha Fajri Jonison on 21/07/23.
//

import SwiftUI

struct PermissionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            SingleTextField(placeholder: "Name...", text: $viewModel.name)
            
            Spacer()
            
            Toggle("Allow push notifications", isOn: $viewModel.isPushNotificationsPermissionToggled)
                .onChange(of: viewModel.isPushNotificationsPermissionToggled, perform: viewModel.handleOnPushNotificationsPermissionToggled)
            Toggle("Allow access mirophone", isOn: $viewModel.isMicrophonePermissionToggled)
                .onChange(of: viewModel.isMicrophonePermissionToggled, perform: viewModel.handleOnMicrophonePermissionToggled)
        }
    }
}

struct PermissionView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionView(viewModel: OnboardingViewModel())
    }
}
