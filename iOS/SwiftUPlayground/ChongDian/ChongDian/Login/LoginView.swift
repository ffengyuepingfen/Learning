//
//  LoginView.swift
//  DesignCode
//
//  Created by Meng To on 2020-03-26.
//  Copyright © 2020 Meng To. All rights reserved.
//

import SwiftUI

/// 模态视图返回的两种方法
/// 1、系统内置的 控制模态视图的开关
/// @Environment(\.presentationMode) var presentationMode
/// self.presentationMode.wrappedValue.dismiss()
///
/// 2、发起模态的地方把控制模态的开关传进来， 改变其状态 达到消失的目的

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var showAlert = false
    @State var alertMessage = "Something went wrong."
    @State var isLoading = false
    @State var isSuccessful = false
    
    @EnvironmentObject var userData: AppModel

    @ObservedObject private var keyboardResponder = KeyboardResponder()
    @ObservedObject private var viewModel = LoginViewModel()
    
    func login() {
        self.hideKeyboard()
        self.isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            
            if Bool.random() {
                self.userData.isLogged = true
                UserDefaults.standard.set(true, forKey: "isLogged")
                self.isSuccessful = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.email = ""
                    self.password = ""
                    self.isSuccessful = false
                    self.userData.showLogin = false
                }
                
            }else{
                self.alertMessage = "Something went wrong."
                self.showAlert = true
            }
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ZStack (alignment: .top) {

                Color("background2")
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .edgesIgnoringSafeArea(.bottom)
                
                LoginCoverView()
//
                VStack {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)

                        TextField("Your Email".uppercased(), text: $email)
                            .keyboardType(.emailAddress)
                            .font(.subheadline)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading)
                            .frame(height: 44)
                    }

                    Divider().padding(.leading, 80)

                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)

                        SecureField("Password".uppercased(), text: $password)
                            .keyboardType(.default)
                            .font(.subheadline)
                            //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading)
                            .frame(height: 44)
                    }
                }
                .frame(height: 136)
                .frame(maxWidth: .infinity)
                .background(BlurView(style: .systemMaterial))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
                .padding(.horizontal)
                .offset(y: 460)

                HStack {
                    Text("Forgot password?")
                        .font(.subheadline)

                    Spacer()

                    Button(action: {
                        self.login()
                    }) {
                        Text("Log in").foregroundColor(.black)
                    }
                    .padding(12)
                    .padding(.horizontal, 30)
                    .background(Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding()

            }
            .frame(minHeight: 670)
            .padding(.bottom, keyboardResponder.currentHeight)
            .animation(.easeInOut, value: keyboardResponder.currentHeight)
            .onTapGesture {
                self.hideKeyboard()
            }
            
            if isLoading {
                LoadingView()
            }
            
            if isSuccessful {
                SuccessView()
            }
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AppModel())
    }
}
