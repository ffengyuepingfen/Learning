//
//  SettingView.swift
//  ChongDian
//
//  Created by Laowang on 2023/8/10.
//

import SwiftUI

struct SettingView: View {

    @EnvironmentObject var appData: AppModel

    private var settings: AppState.Settings { appData.store.appState.settings }
    private var settingsBinding: Binding<AppState.Settings> { $appData.store.appState.settings }

    var body: some View {
        Form {
            Section(header: Text("账户")) {
                if settings.loginUser == nil {
                    Picker(selection: settingsBinding.checker.accountBehavior, label: Text("")) {
                        ForEach(AppState.Settings.AccountBehavior.allCases, id: \.self) {
                            Text($0.text)
                        }
                    }.pickerStyle(SegmentedPickerStyle())

                    TextField("电子邮箱", text: settingsBinding.checker.email)
                        .foregroundColor(settings.isEmailValid ? .green : .red)
                    SecureField("密码", text: settingsBinding.checker.password)
                    if settings.checker.accountBehavior == .register {
                        SecureField("确认密码", text: settingsBinding.checker.verifyPassword)
                    }
                    if settings.showingAccountBehaviorIndicator {
                        Text("\(settings.checker.accountBehavior.text)中...")
                            .foregroundColor(.gray)
                    } else {
                        Button(settings.checker.accountBehavior.text) {
                            let checker = self.settings.checker
                            switch checker.accountBehavior {
                            case .register:
                                self.appData.store.dispatch(.register(email: checker.email, password: checker.password))
                            case .login:
                                self.appData.store.dispatch(.login(email: checker.email, password: checker.password))
                            }
                        }
                        .disabled(!settings.isValid)
                    }
                } else {
                    Text(settings.loginUser!.email)
                    Button("注销") {
                        self.appData.store.dispatch(.logout)
                    }
                }
            }

            Section(header: Text("选项")) {
                Toggle(isOn: settingsBinding.showEnglishName) {
                    Text("显示英文名")
                }
                Picker(selection: settingsBinding.sorting, label: Text("排序方式")) {
                    ForEach(AppState.Settings.Sorting.allCases, id: \.self) {
                        Text($0.text)
                    }
                }
                Toggle(isOn: settingsBinding.showFavoriteOnly) {
                    if settings.loginUser == nil {
                        Text("只显示收藏 (登录后可用)")
                    } else {
                        Text("只显示收藏")
                    }
                }.disabled(settings.loginUser == nil)
            }

            Section {
                Button(action: {
                    self.appData.store.dispatch(.clearCache)
                }) {
                    Text("清空缓存").foregroundColor(.red)
                }
            }
        }.alert(item: settingsBinding.loginError) { e in
            Alert(title: Text(e.localizedDescription))
        }
    }
}

extension AppState.Settings.Sorting {
    var text: String {
        switch self {
        case .id: return "ID"
        case .name: return "名字"
        case .color: return "颜色"
        case .favorite: return "最爱"
        }
    }
}

extension AppState.Settings.AccountBehavior {
    var text: String {
        switch self {
        case .register: return "注册"
        case .login: return "登录"
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView().environmentObject(AppModel())
    }
}
