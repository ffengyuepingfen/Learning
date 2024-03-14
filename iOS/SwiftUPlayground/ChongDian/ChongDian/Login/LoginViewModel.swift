//
//  LoginViewModel.swift
//  SwiftUIDemo (iOS)
//
//  Created by Xiangbo Wang on 2022/9/16.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {

    // 输入
    @Published var username = ""
    @Published var password = ""
    @Published var passwordConfirm = ""

    // 输出
    @Published var isUsernameLengthValid = false
    @Published var isPasswordLengthValid = false
    @Published var isPasswordCapitalLetter = false
    @Published var isPasswordConfirmValid = false
    
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        
        //用户名校验
        $username
            .receive(on: RunLoop.main)
            .map { username in
                return username.count >= 2
            }
            .assign(to: \.isUsernameLengthValid, on: self)
            .store(in: &cancellableSet)
        
        //密码校验
        $password
            .receive(on: RunLoop.main)
            .map { password in
                return password.count >= 6
            }
            .assign(to: \.isPasswordLengthValid, on: self)
            .store(in: &cancellableSet)
        
        //密码大写校验
        $password
            .receive(on: RunLoop.main)
            .map { password in
                
                let pattern = "[A-Z]"
                
                if let _ = password.range(of: pattern, options: .regularExpression) {
                    return true
                } else {
                    return false
                }
            }
            .assign(to: \.isPasswordCapitalLetter, on: self)
            .store(in: &cancellableSet)
        
        //两次密码是否相同
        Publishers.CombineLatest($password, $passwordConfirm).receive(on: RunLoop.main)
            .map { password, passwordConfirm in
                !passwordConfirm.isEmpty && (passwordConfirm == password)
            }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancellableSet)
    }
}
