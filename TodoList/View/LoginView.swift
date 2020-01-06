//
//  LoginView.swift
//  TodoList
//
//  Created by 尹毓康 on 2020/1/6.
//  Copyright © 2020 yukangyin. All rights reserved.
//

import SwiftUI


struct LoginView: View {
    
    // @Environment的作用是从环境中取出预定义的值
    // 从实体中获取数据的属性
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // users的长度是1，就是正在使用该app的用户
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(key: "username", ascending: true)]) var users: FetchedResults<User>
    
    @State private var email = ""
    @State private var password = ""
    
    // 记录用户是否已经注册
    @State private var alreadySignUp = false
    

    
    
    var body: some View {
        ZStack{
            Image("designSixBg")
                .resizable()
            VStack{
                // Logo
                Spacer()
                VStack {
                    Text("Welcome")
                        .scaledFont(name: "RobotoSlab-Bold", size: 34)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    Text("Please sign in to continue.")
                        .scaledFont(name: "RobotoSlab-Light", size: 18)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    
                }
                Spacer()
                //Form
                VStack(alignment: .center, spacing: 30) {
                    VStack(alignment: .center, spacing: 10) {
                        // 输入email和密码
                        VStack(alignment: .center, spacing: 30){
                            // 输入email
                            VStack(alignment: .center, spacing: 10) {
                                HStack(alignment: .center, spacing:10){// input email
                                    Image("username") // search email icon
                                        .frame(width:20,height:20)
                                    CustomTextField(
                                        placeholder: Text("Email")
                                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))),
                                        text: $email)
                                }
                                Divider()
                                    .background(Color.gray)
                            }
                            
                            // input password
                            VStack(alignment: .leading,spacing: 10) {
                                HStack(alignment: .center, spacing: 10){
                                    Image("password")
                                        .frame(width: 20, height: 20, alignment: .center)
                                    CustomSecureField(
                                        placeholder: Text("Password").foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))),
                                        password: $password
                                    )
                                }
                                Divider()
                                    .background(Color.gray)
                            }
                        }
                        
                        // forgot password
                        HStack {
                            Spacer()
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                Text("Forgot Password?")
                                    .scaledFont(name: "RobotoSlab-Light", size: 14)
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            }
                        }
                    }
                    .padding(.horizontal,30)
                    
                    // Button
                    //Spacer.frame(height:10)
                    Button(action: {
                        // 注册密码找回等情况下清空输入框
                        if (self.users.count == 0) {
                            print("没有用户注册这个App")
                            self.email = ""
                            self.password = ""
                            // TODO: 跳出一个弹框：请您先注册
                        }
//                        else if (self.users.count > 1) {
//                            self.email = ""
//                            self.password = ""
//                            print("此时不止有一名用户在本地登录APP!")
//                        }
                        else {
                            let currentUser = self.users[0]
                            // 验证邮箱和密码
                            if (currentUser.email == self.email && currentUser.password == self.password) {
                                // 验证通过，允许用户进入todolist界面
                                // 待定：修改用户数据表中的auth字段，持久化存储用户的状态
                                self.users[0].auth = "authorized"
                                do {
                                    try self.managedObjectContext.save()
                                } catch {
                                    print(error)
                                }
                                self.email = ""
                                self.password = ""
                            } else {
                                // TODO: 跳出弹框：验证失败，提醒用户重新输入邮箱和密码
                            }
                        }
                    }) {
                        Image(systemName: "arrow.right")
                            .accentColor(Color.white)
                            .font(.headline)
                            .frame(width:60,height: 60)
                            .background(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                            .cornerRadius(30)
                        
                    }
                }
                
                //Footer
                Spacer()
                Button(action: {
                    // alreadySignUp由false到true
                    self.alreadySignUp.toggle()
                }) {
                    Text("Sign up, if you’re new!")
                        .scaledFont(name: "RobotoSlab-Light", size: 18)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                }
                .sheet(isPresented: $alreadySignUp) {
                    SignUpView()
                        .environment(\.managedObjectContext, (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
                }
                .padding(.bottom, 40)
            }
            
            
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
