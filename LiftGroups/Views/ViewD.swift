//
//  View3.swift
//  UIPlayground
//
//  Created by Wehby, Quinton on 3/31/22.
//

import SwiftUI

struct ViewD: View {

    var body: some View {
        
        let textSize = CGFloat(22)
        let lineColor = Color.gray
        
        ZStack {
            
            
            VStack {
                Image("background2")
                    .resizable()
                    .ignoresSafeArea()
                    .frame(height: 150)
                Spacer()
            }
            
            
            
            VStack {
                Text("Profile")
                    .bold()
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                
                ZStack {
                    Circle().fill(.white).frame(width:200, height: 200)
                    
                    Image("blankProfilePic").resizable().frame(width:180, height: 180)
                    
                    ZStack {
                        Circle().fill(.gray).frame(width:40, height: 40)
                        Image(systemName: "camera.fill")
            
                    }.padding([.top, .leading], 140)
                     
                    
                    
                }.padding(.bottom)
                
                ScrollView {
                
                HStack {

                    HStack {
                            Text("Full Name")
                                .font(.system(size: textSize))
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }.frame(width: 110)
                    
                        Text("Alex Demann")
                            .font(.system(size: textSize))
                            .multilineTextAlignment(.leading)
                        Spacer()

                    }.padding(.leading, 25).padding(10)
                
                    Rectangle().fill(lineColor).frame( height: 2).padding(.horizontal)
                
                    HStack {

                        HStack {
                            Text("Email")
                                .font(.system(size: textSize))
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }.frame(width: 110)

                        Text("Ajdemann@gmail.com")
                            .font(.system(size: textSize))
                            .multilineTextAlignment(.leading)
                            .lineLimit(0)
                        Spacer()

                    }.padding(.leading, 25).padding(10)
                
                    Rectangle().fill(lineColor).frame( height:  2).padding(.horizontal)
                
                    HStack {

                        HStack {
                            Text("Diet")
                                .font(.system(size: textSize))
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }.frame(width: 110)

                        Text("Bulking")
                            .font(.system(size: textSize))
                            .multilineTextAlignment(.leading)
                        Spacer()

                    }.padding(.leading, 25).padding(10)
                
                    Rectangle().fill(lineColor).frame( height: 2).padding(.horizontal)
                
                    HStack {
                    
                        HStack {
                            Text("Group")
                                .font(.system(size: textSize))
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }.frame(width: 110)
                    
                        Text("The Council")
                            .font(.system(size: textSize))
                            .multilineTextAlignment(.leading)
                        Spacer()

                    }.padding(.leading, 25).padding(10)
                
            
                    Spacer()
                        
                }
            }
        }.background(Color("greyBar"))
    }
}

struct ViewD_Previews: PreviewProvider {
    static var previews: some View {
        ViewD()
    }
}
