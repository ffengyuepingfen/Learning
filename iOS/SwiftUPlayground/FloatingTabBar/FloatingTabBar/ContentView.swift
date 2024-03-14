//
//  ContentView.swift
//  FloatingTabBar
//
//  Created by Laowang on 2024/1/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var tabmodel: TabModel = .init()
    @Environment(\.controlActiveState) private var state
    var body: some View {
        TabView(selection: $tabmodel.activetab,
                content:  {
            NavigationStack {
                Text("home view")
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button("", systemImage: "sidebar.left") {
                                tabmodel.hideTabBar.toggle()
                            }
                        }
                    }
            }
            .tag(Tab.home)
            .background(HideTabBar())
            Text("favourites view")
                .tag(Tab.favourites)
            Text("notifications view")
                .tag(Tab.notifications)
            Text("settings view")
                .tag(Tab.settings)
        })
        .background {
            GeometryReader {
                let rect = $0.frame(in: .global)
                
                Color.clear
                    .customOnChange(value: rect) { _ in
                        /// frame change
                        tabmodel.updateTabPosition()
                    }
            }
        }
        .customOnChange(value: state, inital: true) { newValue in
            if newValue == .key {
                tabmodel.addTabBar()
            }
        }
        .frame(minWidth: 100, minHeight: 200)
    }
}

extension View {
    @ViewBuilder
    func customOnChange<Value: Equatable>(value: Value, inital: Bool = false, result: @escaping (Value)-> ()) -> some View {
        if #available(macOS 14, *) {
            self.onChange(of: value, initial: inital) { oldValue, newValue in
                result(newValue)
            }
        } else {
            self.onChange(of: value, perform: result)
                .onAppear {
                    result(value)
                }
        }
    }
    
    @ViewBuilder
    func windowBackground() -> some View {
        if #available(macOS 14, *) {
            self.background(.windowBackground)
        } else {
            self.background(.background)
        }
    }
}

#Preview {
    ContentView()
}

class TabModel: ObservableObject {
    @Published var activetab: Tab = .home
    @Published private (set) var isTabBarAdded: Bool = false
    
    @Published var hideTabBar = false
    
    private let id: String = UUID().uuidString
    
    func addTabBar() {
        guard !isTabBarAdded else {
            return
        }
        if let applicationWindow = NSApplication.shared.mainWindow {
            let customTabBar = NSHostingView(rootView: FloatingTabBarView().environmentObject(self))
            let floatingWindow = NSWindow()
            floatingWindow.styleMask = .borderless
            floatingWindow.contentView = customTabBar
            floatingWindow.backgroundColor = .clear
            floatingWindow.title = id
            
            let windowSize = applicationWindow.frame.size
            let windowOrigin = applicationWindow.frame.origin
            
            floatingWindow.setFrameOrigin(NSPoint.init(x: windowOrigin.x - 50, y: windowOrigin.y + (windowSize.height - 150)/2))
            
            applicationWindow.addChildWindow(floatingWindow, ordered: .above)
            isTabBarAdded = true
        }else {
            print("no window found")
        }
    }
    
    func updateTabPosition() {
        if let floatingWindow = NSApplication.shared.windows.first(where: { $0.title == id }), let applicationWindow = NSApplication.shared.mainWindow {
            let windowSize = applicationWindow.frame.size
            let windowOrigin = applicationWindow.frame.origin
            
            floatingWindow.setFrameOrigin(NSPoint.init(x: windowOrigin.x - 50, y: windowOrigin.y + (windowSize.height - 150)/2))
        }
    }
}

enum Tab: String, CaseIterable {
    case home = "house.fill"
    case favourites = "suit.heart.fill"
    case notifications = "bell.fill"
    case settings = "gearshape"
}

fileprivate struct FloatingTabBarView: View {
    
    @EnvironmentObject private var tabModel: TabModel
    @Environment(\.colorScheme) private var colorScheme
    
    @Namespace private var animation
    private let animationID: UUID = .init()
    
    var body: some View {
        VStack {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                Button(action: { tabModel.activetab = tab }, label: {
                    Image(systemName: tab.rawValue)
                        .font(.title3)
                        .foregroundStyle(tabModel.activetab == tab ? ( colorScheme == .dark ? .black : .white) : .primary )
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background {
                            if tabModel.activetab == tab {
                                Circle()
                                    .fill(.primary)
                                    .matchedGeometryEffect(id: animationID, in: animation)
                            }
                        }
                        .contentShape(.rect)
                        .animation(.bouncy, value: tabModel.activetab)
                })
                .buttonStyle(.plain)
            }
        }
        .padding(5)
        .frame(width: 45, height: 180)
        .windowBackground()
        .clipShape(.capsule)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(width: 50)
        .contentShape(.capsule)
        .offset(x: tabModel.hideTabBar ? 60 : 0)
        .animation(.snappy, value: tabModel.hideTabBar)
        
    }
}


fileprivate struct HideTabBar: NSViewRepresentable {
    func makeNSView(context: Context) -> some NSView {
        return .init()
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.06, execute: {
            if let tabView = nsView.superview?.superview?.superview as? NSTabView {
                tabView.tabViewType = .noTabsNoBorder
                tabView.tabViewBorderType = .none
                tabView.tabPosition = .none
            }
        })
    }
    
}
