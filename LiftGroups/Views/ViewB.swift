//
//  View2.swift
//  UIPlayground
//
//  Created by Wehby, Quinton on 3/31/22.
//

import SwiftUI

struct ViewB: View {
    var body: some View {
        
        let itemColor = Color.white
        
        ZStack {
            
            VStack {
                Image("background2")
                    .resizable()
                    .ignoresSafeArea()
                    .frame(height: 150)
                Spacer()
            }
            
            //Image("background2").resizable().ignoresSafeArea()
            
            VStack {
                
                HStack {
                    Spacer()
                    Image("leftArrow").resizable().frame(width: 40, height: 40)
                    Spacer()
                    Text("Benchpress")
                        .bold()
                        .font(.system(size: 30)).frame(width: 220)
                        .foregroundColor(Color.white)
                    Spacer()
                    Image("rightArrow").resizable().frame(width: 40, height: 40)
                    Spacer()
                }
                
                ScrollView {
                    VStack {
                        
                        
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous).fill(itemColor).frame( height: 100).padding(.horizontal, 15.0)
                            
                            HStack {
                                Image("blankProfilePic")
                                    .resizable()
                                    .frame(width: 70, height: 70, alignment: .center)
                                    
                                VStack(alignment: .leading) {
                                    Text("Alex Demann")
                                        .bold()

                                    Text("Cutting")
                                        .italic()
                                        
                                    Text("April 18th").foregroundColor(.green)
                                        
                                }.padding(.horizontal, 10)
                                Spacer()
                                VStack(alignment: .center) {
                                    Text("225")
                                        .bold()
                                        .scaleEffect(2.5)
                                        .padding(5)
                                    Text("Pounds")
                                }.padding(.trailing, 10.0)
                            }.padding(.horizontal, 25)
                            
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous).fill(itemColor).frame( height: 100).padding(.horizontal, 15.0)
                            
                            HStack {
                                Image("blankProfilePic")
                                    .resizable()
                                    .frame(width: 70, height: 70, alignment: .center)
                                    
                                VStack(alignment: .leading) {
                                    Text("Owen Louis")
                                        .bold()

                                    Text("Bulking")
                                        .italic()
                                        
                                    Text("April 15th").foregroundColor(.green)
                                        
                                }.padding(.horizontal, 10)
                                Spacer()
                                VStack(alignment: .center) {
                                    Text("190")
                                        .bold()
                                        .scaleEffect(2.5)
                                        .padding(5)
                                    Text("Pounds")
                                }.padding(.trailing, 10)
                            }.padding(.horizontal, 25)
                            
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous).fill(itemColor).frame( height: 100).padding(.horizontal, 15.0)
                            
                            HStack {
                                Image("blankProfilePic")
                                    .resizable()
                                    .frame(width: 70, height: 70, alignment: .center)
                                    
                                VStack(alignment: .leading) {
                                    Text("Quinton Wehby")
                                        .bold()

                                    Text("Lean Bulk")
                                        .italic()
                                        
                                    Text("December 3rd").foregroundColor(.green)
                                        
                                }.padding(.horizontal, 10)
                                Spacer()
                                VStack(alignment: .center) {
                                    Text("165")
                                        .bold()
                                        .scaleEffect(2.5)
                                        .padding(5)
                                    Text("Pounds")
                                }.padding(.trailing, 10.0)
                            }.padding(.horizontal, 25)
                            
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous).fill(itemColor).frame( height: 100).padding(.horizontal, 15.0)
                            
                            HStack {
                                Image("blankProfilePic")
                                    .resizable()
                                    .frame(width: 70, height: 70, alignment: .center)
                                    
                                VStack(alignment: .leading) {
                                    Text("Evan Ossege")
                                        .bold()

                                    Text("Lean Bulk")
                                        .italic()
                                        
                                    Text("Febuary 28th").foregroundColor(.green)
                                        
                                }.padding(.horizontal, 10)
                                Spacer()
                                VStack(alignment: .center) {
                                    Text("150")
                                        .bold()
                                        .scaleEffect(2.5)
                                        .padding(5)
                                    Text("Pounds")
                                }.padding(.trailing, 10.0)
                            }.padding(.horizontal, 25)
                            
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous).fill(itemColor).frame( height: 100).padding(.horizontal, 15.0)
                            
                            HStack {
                                Image("blankProfilePic")
                                    .resizable()
                                    .frame(width: 70, height: 70, alignment: .center)
                                    
                                VStack(alignment: .leading) {
                                    Text("Jerrod Watts")
                                        .bold()

                                    Text("Bulking")
                                        .italic()
                                        
                                    Text("January 10th").foregroundColor(.green)
                                        
                                }.padding(.horizontal, 10)
                                Spacer()
                                VStack(alignment: .center) {
                                    Text("135")
                                        .bold()
                                        .scaleEffect(2.5)
                                        .padding(5)
                                    Text("Pounds")
                                }.padding(.trailing, 10.0)
                            }.padding(.horizontal, 25)
                            
                        }
                        
                        Spacer()
                        
                    }
                }.frame(height: .infinity)
            }
        }.background(Color("greyBar"))
    }
}

struct ViewB_Previews: PreviewProvider {
    static var previews: some View {
        ViewB()
            
    }
}
