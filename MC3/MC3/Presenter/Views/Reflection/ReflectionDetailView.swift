//
//  ReflectionDetailView.swift
//  MC3
//
//  Created by Muhammad Afif Maruf on 25/07/23.
//

import SwiftUI

struct ReflectionDetailView: View {
    var reflection: String
    
    var body: some View {
        ZStack{
            Color("AccentColor").edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading){
                Text("Your Reflection")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                ScrollView{
                    
                    Text(reflection)
                        .lineSpacing(5)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .background(.white)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.bottom, 16)
                Spacer()
                
                PrimaryButton(text: "Continue", isFull: true) {
                    print()
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

struct ReflectionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionDetailView(reflection: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Gravida neque convallis a cras semper auctor neque. Eget magna fermentum iaculis eu non diam phasellus. Est lorem ipsum dolor sit amet consectetur adipiscing elit pellentesque. Facilisi nullam vehicula ipsum a arcu cursus. Erat velit scelerisque in dictum non. Proin libero nunc consequat interdum varius sit amet. Viverra nam libero justo laoreet. Est placerat in egestas erat. Volutpat consequat mauris nunc congue nisi vitae suscipit tellus mauris. Quis ipsum suspendisse ultrices gravida dictum fusce ut. Mauris vitae ultricies leo integer malesuada. Orci eu lobortis elementum nibh tellus molestie nunc non blandit. Purus sit amet luctus venenatis. Amet commodo nulla facilisi nullam vehicula ipsum a arcu. Scelerisque eleifend donec pretium vulputate sapien. Egestas integer eget aliquet nibh. Vitae suscipit tellus mauris a diam.Ornare lectus sit amet est. Porttitor leo a diam sollicitudin tempor. Eget felis eget nunc lobortis mattis aliquam faucibus purus in. Ultricies integer quis auctor elit sed vulputate mi. Nec feugiat nisl pretium fusce id velit ut tortor pretium. Tempus imperdiet nulla malesuada pellentesque elit eget. A iaculis at erat pellentesque adipiscing commodo elit. Sed risus pretium quam vulputate dignissim suspendisse in. In massa tempor nec feugiat nisl pretium fusce id. Bibendum at varius vel pharetra vel turpis nunc. Nec nam aliquam sem et. Pretium aenean pharetra magna ac placerat vestibulum lectus. Massa tincidunt dui ut ornare lectus. Venenatis tellus in metus vulputate eu scelerisque felis imperdiet. Nibh sit amet commodo nulla facilisi nullam vehicula ipsum. Pretium quam vulputate dignissim suspendisse in. Vitae aliquet nec ullamcorper sit amet risus nullam eget. Odio eu feugiat pretium nibh ipsum consequat nisl vel. Elit pellentesque habitant morbi tristique senectus et netus. Semper quis lectus nulla at volutpat diam ut venenatis tellus. Aliquam eleifend mi in nulla posuere. Eu augue ut lectus arcu bibendum at varius vel. Risus pretium quam vulputate dignissim. Adipiscing enim eu turpis egestas pretium aenean pharetra magna. Diam volutpat commodo sed egestas egestas fringilla phasellus. Iaculis nunc sed augue lacus viverra vitae congue. A iaculis at erat pellentesque adipiscing commodo elit at. Platea dictumst vestibulum rhoncus est pellentesque. Eu consequat ac felis donec et odio pellentesque. Malesuada bibendum arcu vitae elementum curabitur vitae nunc sed.")
    }
}
