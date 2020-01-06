//
//  TodoListHomeView.swift
//  TodoList
//
//  Created by 尹毓康 on 2020/1/6.
//  Copyright © 2020 yukangyin. All rights reserved.
//

import SwiftUI

let statusBarHeight = UIApplication.shared.windows[0].windowScene?.statusBarManager?.statusBarFrame.height ?? 0
let screen = UIScreen.main.bounds

// 显示todolist以及左侧滑块
struct TodoListHomeView: View {
    
    @State var show: Bool = false
    @State var showProfile: Bool = false
    
    var body: some View {
        ZStack {
            // TodoListView
            TodoListView()
            .blur(radius: show ? 20 : 0)
            .scaleEffect(showProfile ? 0.95 : 1)
            .animation(.default)
//            HomeList()
//                .blur(radius: show ? 20 : 0)
//                .scaleEffect(showProfile ? 0.95 : 1)
//                .animation(.default)
//
//            ContentView()
//                .frame(minWidth: 0, maxWidth: 712)
//                .cornerRadius(30)
//                .shadow(radius: 20)
//                .animation(.spring())
//                .offset(y: showProfile ? 40 + statusBarHeight : screen.height)
            
            MenuButton(show: $show)
                .offset(x: -40, y: showProfile ? statusBarHeight : 80)
                .animation(.spring())

//            MenuRight(show: $showProfile)
//                .offset(x: -16, y: showProfile ? statusBarHeight : 88)
//                .animation(.spring())

            MenuView(show: $show)
            
        }
        .background(Color("background"))
        .edgesIgnoringSafeArea(.all)
    }
}

// 左侧点击滑块的按钮
struct MenuButton: View {
    @Binding var show : Bool
    var body: some View {
        VStack() {
            HStack {
                Button(action: {
                    self.show.toggle()
                }) {
                    HStack {
                        Spacer()
                        Image(systemName: "list.dash")
                            .foregroundColor(.primary)
                    }
                    .padding(.trailing, 18)
                    .frame(width: 90, height: 60)
                    .background(Color("button"))
                    .cornerRadius(30)
                    .shadow(color: Color("buttonShadow"), radius: 10, x: 0, y: 10)
                }
                Spacer()
            }
            Spacer()
        }
    }
}


struct Menu: Identifiable {
    var id = UUID()
    var title : String
    var icon : String
}

let profileMenu = Menu(title: "Profile", icon: "person.crop.circle")
let settingMenu = Menu(title: "Setting", icon: "gear")
let todayMenu = Menu(title: "Today's", icon: "alarm")
let calendarMenu = Menu(title: "Calendar", icon: "calendar")


struct MenuRow: View {
    var image = "person.crop.circle"
    var text = "Hello World!"
    var body: some View {
        HStack {
            Image(systemName: image)
                .imageScale(.large)
                .foregroundColor(.red)
                .frame(width: 32, height: 32)
            Text(text)
                .foregroundColor(.primary)
                .font(.headline)
            Spacer()
        }
    }
}

// 左侧的滑块
struct MenuView: View {
    
    @Binding var show : Bool
    @State var showUpdate = false
//    let menu = menuData
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
//                ForEach(menu) { item in
//                    if (item.title == "setting") {
//                        Button(action: {
//                            self.showUpdate.toggle()
//                        }) {
//                            MenuRow(image: item.icon, text: item.title)
//                        }.sheet(isPresented: self.$showUpdate) {
//                            Settings()
//                        }
//                    } else {
//                        MenuRow(image: item.icon, text: item.title)
//                    }
//                }
                Button(action: {
                    // 打开个人profile
                }) {
                    MenuRow(image: profileMenu.icon, text: profileMenu.title)
                }
                Button(action: {
                    // 打开设置
                }) {
                    MenuRow(image: settingMenu.icon, text: settingMenu.title)
                }
                Button(action: {
                    // 今天到期的事项
                }) {
                    MenuRow(image: todayMenu.icon, text: todayMenu.title)
                }
                
                Button(action: {
                    // 打开日历
                }) {
                    MenuRow(image: calendarMenu.icon, text: calendarMenu.title)
                }
                Spacer()
            }
            .padding(.top, 20)
            .padding(30)
            .background(Color("button"))
            .frame(minWidth: 0, maxWidth: 360)
            .cornerRadius(30.0)
            .padding(.trailing, 60)
            .shadow(radius: 20)
            .animation(.default)
            .rotation3DEffect(Angle(degrees: show ? 0 : 60), axis: (x: 0, y: 10.0, z: 0))
            .offset(x: show ? 0 : -screen.width)
            .onTapGesture {
                self.show.toggle()
            }
            Spacer()
        }
        .padding(.top, statusBarHeight)
    }
}

struct TodoListHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListHomeView()
    }
}
