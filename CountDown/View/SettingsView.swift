//
//  SettingsView.swift
//  CountDown
//
//  Created by Tri Pham on 7/31/22.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK - Properties
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    // MARK - Body
    var body: some View {
            VStack {
                Spacer()
                VStack {
                    HStack(spacing: 0) {
                        
                        Text("About the App")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .padding(.top, 6)
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                            playSound(sound: "sound-tap", type: "mp3")
                        }) {
                            ZStack {
                                Image(systemName: "xmark.square")
                                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color.gray)
                                    
                                
                            }
                        }
                        .padding(.top, 6)
                        .frame(maxWidth: 2, alignment: .trailing)
                        
                    }
                    .padding()
                    
                    FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Count Down")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                    FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                    FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Tri Pham")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                    FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Tri Pham")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                    FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                    
                    // Mark Footer
                    Text("For a beautiful and a very special person to me,\nPhuong Nguyen")
                        .multilineTextAlignment(.center)
                        .font(.footnote)
                        .padding(.top, 6)
                        .padding(.bottom, 16)
                        .foregroundColor(Color.secondary)
                    
                }//.VStack
    //            .frame(minHeight: 0, maxHeight: .infinity)
    //            .padding(.horizontal)
    //            .padding(.vertical, 20)
                .background(
                    isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white
                )
                .cornerRadius(16)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
                .frame(maxWidth:640)
                
            }
            .ignoresSafeArea(.all)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
