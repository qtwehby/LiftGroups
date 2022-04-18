//
//  View3.swift
//  UIPlayground
//
//  Created by Wehby, Quinton on 3/31/22.
//

import SwiftUI

struct ViewC: View {
    var body: some View {
        
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
                Text("Groups")
                    .bold()
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                
                ScrollView {
                
                    ZStack {
                        RoundedRectangle(cornerRadius: 15, style: .continuous).fill(.white).frame( height: 440).padding(.horizontal, 15.0)
                    
                    
                            VStack {
                                HStack {
                                    Text("The Council")
                                        .bold()
                                        .font(.system(size: 30))
                                    Spacer()
                                }
                            
     
                            
                            HStack {
                                Image("blankProfilePic")
                                    .resizable()
                                    .frame(width: 70, height: 70, alignment: .center)
                                    
                                VStack(alignment: .leading) {
                                    Text("Alex Demann")
                                        .bold()
                                        .font(.system(size: 18))
                                    Text("Cutting")
                                        .italic()
                                        .font(.system(size: 18))
                                        
                                }.padding(.horizontal, 10)
                                Spacer()
                                
                            }
                            
                            Rectangle().fill(lineColor).frame( height: 2)
                            
                            
                            HStack {
                                Image("blankProfilePic")
                                    .resizable()
                                    .frame(width: 70, height: 70, alignment: .center)
                                    
                                VStack(alignment: .leading) {
                                    Text("Quinton Wehby")
                                        .bold()
                                        .font(.system(size: 18))
                                    Text("Lean Bulking")
                                        .italic()
                                        .font(.system(size: 18))
                                        
                                }.padding(.horizontal, 10)
                                Spacer()
                                
                            }
                            
                            Rectangle().fill(lineColor).frame( height: 2)
                            
                            HStack {
                                Image("blankProfilePic")
                                    .resizable()
                                    .frame(width: 70, height: 70, alignment: .center)
                                    
                                VStack(alignment: .leading) {
                                    Text("Owen Louis")
                                        .bold()
                                        .font(.system(size: 18))
                                    Text("Bulking")
                                        .italic()
                                        .font(.system(size: 18))
                                        
                                }.padding(.horizontal, 10)
                                Spacer()
                                
                            }
                            
                            Rectangle().fill(lineColor).frame( height: 2)
                            
                            HStack {
                                Image("blankProfilePic")
                                    .resizable()
                                    .frame(width: 70, height: 70, alignment: .center)
                                    
                                VStack(alignment: .leading) {
                                    Text("Evan Ossege")
                                        .bold()
                                        .font(.system(size: 18))
                                    Text("Lean Bulking")
                                        .italic()
                                        .font(.system(size: 18))
                                        
                                }.padding(.horizontal, 10)
                                Spacer()
                                
                            }
                            
                            Spacer()
                        }.padding(.horizontal, 30).padding(.vertical, 15)
                    
                    
                }.frame(height: 440)
                

                
                /*ZStack {
                    RoundedRectangle(cornerRadius: 15, style: .continuous).fill(.white).frame( height: 100).padding(.horizontal, 15.0)
                    
                    VStack {
                        HStack {
                            Text("Options: ")
                                .bold()
                                .font(.system(size: 30))
                            Spacer()
                            ZStack {
                                RoundedRectangle(cornerRadius: 15, style: .continuous).fill(.red).frame( height: 70).padding(.horizontal, 25.0)
                                Text("LEAVE")
                                    .bold()
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        
                
                        
                    }.padding(.horizontal, 30).padding(.vertical, 15)
                    
                }.frame(height: 100)*/
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15, style: .continuous).fill(.red).frame( height: 50).padding(.horizontal, 15.0).padding(.vertical, 5)
                    Text("Leave group")
                        .bold()
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                }
                
                
                Spacer()
                }
            }
        }.background(Color("greyBar"))
    }
}

struct ViewC_Previews: PreviewProvider {
    static var previews: some View {
        ViewC()
            
    }
}
