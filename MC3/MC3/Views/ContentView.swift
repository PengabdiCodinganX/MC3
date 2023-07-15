//
//  ContentView.swift
//  MC3
//
//  Created by Vincent Gunawan on 11/07/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TabView() {
                UserView()
                    .tabItem {
                        Text("User")
                    }
                    .tag(1)
                
                StoryView()
                    .tabItem {
                        Text("Story")
                    }
                    .tag(2)
                
                StoryCategoryView()
                    .tabItem {
                        Text("Story Category")
                    }
                    .tag(3)
                
                StoryFeedbackView()
                    .tabItem {
                        Text("Story Feedback")
                    }
                    .tag(4)
                
                AffirmationView()
                    .tabItem {
                        Text("Affirmation")
                    }
                    .tag(5)
            }
        }
        .padding()
    }
}

struct UserView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State var username: String = ""
    
    var body: some View {
        VStack {
            if userViewModel.users.count > 0 {
                List {
                    ForEach(userViewModel.users) { user in
                        Text(user.name ?? "")
                            .onTapGesture {
                                print("select user", user)
                                userViewModel.setUser(user: user)
                            }
                    }
                    .onDelete(perform: deleteUser)
                }
            }
            
            TextField("Input User", text: $username)
            
            Button("Submit User") {
                let user = UserModel(name: username)
                userViewModel.saveUser(userModel: user)
                userViewModel.getAllUsers()
            }
            
            Button("Refresh User") {
                userViewModel.getAllUsers()
            }
        }
        .buttonStyle(.bordered)
    }
    
    private func deleteUser(at offsets: IndexSet) {
        offsets.forEach { index in
            let user = userViewModel.users[index]
            userViewModel.deleteUser(userModel: user)
        }
        userViewModel.getAllUsers()
    }
}

struct StoryView: View {
    @State var story: String = ""
    
    var body: some View {
        VStack {
            TextField("Input Story", text: $story)
            Button("Submit Story") {
                
            }
        }
    }
}

struct StoryCategoryView: View {
    @State var storyCategory: String = ""
    
    var body: some View {
        VStack {
            TextField("Input Story Category", text: $storyCategory)
            Button("Submit Story Category") {
                
            }
        }
    }
}

struct StoryFeedbackView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @StateObject var storyViewModel = StoryViewModel()
    @State var storyFeedback: String = ""
    
    var body: some View {
        VStack {
            if userViewModel.user != nil {
                Text("Current User: \(userViewModel.user!.name!)")
                
                Button("Reset") {
                    userViewModel.user = nil
                }
            }
                
            if storyViewModel.storyFeedbacks.count > 0 {
                List {
                    ForEach(storyViewModel.storyFeedbacks) { storyFeedback in
                        VStack {
                            Text(storyFeedback.feedback ?? "")
                            Text(storyFeedback.user?.name ?? "")
                        }
                    }
                    .onDelete(perform: deleteFeedback)
                }
            }
            
            TextField("Input Story Feedback", text: $storyFeedback)
            
            Button("Submit Story Feedback") {
                let storyFeedbackModel = StoryFeedbackModel(
                concern: "test", rating: 1, feedback: storyFeedback)
                
                if userViewModel.user == nil {
                    print("error")
                }
                
                storyViewModel.saveStoryFeedback(storyFeedbackModel: storyFeedbackModel, userModel: userViewModel.user!)
                
                storyViewModel.getAllStoryFeedbacks()
            }
            
            Button("Refresh Story feedback") {
                storyViewModel.getAllStoryFeedbacks()
            }
            
            if userViewModel.user != nil {
                Button("Refresh Story feedback by user") {
                    storyViewModel.getAllStoryFeedbacksByUser(userModel: userViewModel.user!)
                }
            }
        }
        .buttonStyle(.bordered)
    }
    
    private func deleteFeedback(at offsets: IndexSet) {
        offsets.forEach { index in
            let storyFeedback = storyViewModel.storyFeedbacks[index]
            storyViewModel.deleteFeedback(storyFeedbackModel: storyFeedback)
        }
        
        storyViewModel.getAllStoryFeedbacks()
    }
}

struct PublicFigureView: View {
    @State var publicFigureName: String = ""
    
    var body: some View {
        VStack {
            TextField("Input Public Figure Name", text: $publicFigureName)
            Button("Submit Public Figure Name") {
                
            }
        }
    }
}

struct AffirmationView: View {
    @State var affirmation: String = ""
    
    var body: some View {
        VStack {
            TextField("Affirmation", text: $affirmation)
            Button("Submit Affirmation") {
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
