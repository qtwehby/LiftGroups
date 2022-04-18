//
//  ViewA.swift
//  UIPlayground
//
//  Created by Wehby, Quinton on 3/31/22.
//

import SwiftUI

/*extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}*/

struct ViewA: View {
    var body: some View {
        
        let thirdTextColor = Color.green
        //let liftColor = Color(UIColor(rgb: 0x03c7be))
        
        ZStack {
            
            Image("background2").resizable().ignoresSafeArea()
            
            VStack {
                
                Text("Home")
                    .bold()
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                
                ScrollView {
                    
                    VStack {
                        
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous).fill(.white).frame( height: 330).padding(.horizontal, 15.0)
                            
                            VStack(alignment: .leading) {
                                
                                
                                
                                Text("Workouts this week")
                                    .bold()
                                    .font(.system(size: 30))
                                    .padding(.leading, 20)
                    
                                HStack {
                                    Image("blankProfilePic")
                                        .resizable()
                                        .frame(width: 70, height: 70, alignment: .center)
                                        
                                    VStack(alignment: .leading) {
                                        Text("Alex Demann")
                                            .bold()

                                        Text("Cutting")
                                            .italic()
                                            
                                        Text("Recent: Back/Bi").foregroundColor(thirdTextColor)
                                            
                                    }.padding(.horizontal, 10)
                                    Spacer()
                                    VStack(alignment: .center) {
                                        Text("6")
                                            .bold()
                                            .scaleEffect(2.5)
                                            .padding(5)
                                        Text("Lifts")
                                    }.padding(.trailing, 5.0)
                                }
                                .padding(.horizontal, 20.0)
                                
                                Image("greyLine")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal)
                                    .aspectRatio(contentMode: .fit)
                                
                                HStack {
                                    Image("blankProfilePic")
                                        .resizable()
                                        .frame(width: 70, height: 70, alignment: .center)
                                        
                                    VStack(alignment: .leading) {
                                        Text("Owen Louis")
                                            .bold()
                                    
                                        Text("Bulking")
                                            .italic()
                                            
                                        Text("Recent: Chest/Tri").foregroundColor(thirdTextColor)
                                            
                                    }.padding(.horizontal, 10)
                                    Spacer()
                                    VStack(alignment: .center) {
                                        Text("5")
                                            .bold()
                                            .scaleEffect(2.5)
                                            .padding(5)
                                        Text("Lifts")
                                    }.padding(.trailing, 5.0)
                                }
                                .padding(.horizontal, 20.0)
                                
                                Image("greyLine")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal)
                                    .aspectRatio(contentMode: .fit)
                                
                                HStack {
                                    Image("blankProfilePic")
                                        .resizable()
                                        .frame(width: 70, height: 70, alignment: .center)
                                        
                                    VStack(alignment: .leading) {
                                        Text("Evan Ossege")
                                            .bold()
                                    
                                        Text("Lean Bulk")
                                            .italic()
                                            
                                        Text("Recent: Legs").foregroundColor(thirdTextColor)
                                            
                                    }.padding(.horizontal, 10)
                                    Spacer()
                                    VStack(alignment: .center) {
                                        Text("3")
                                            .bold()
                                            .scaleEffect(2.5)
                                            .padding(5)
                                        Text("Lifts")
                                    }.padding(.trailing, 5.0)
                                }
                                .padding(.horizontal, 20.0)
                                
                            }.padding(.horizontal, 10)
                        }
                        
                        Spacer()
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 15, style: .continuous).fill(.white).frame( height: 330).padding(.horizontal, 15.0)
                            
                            VStack(alignment: .leading) {
                                Text("New Maxes")
                                    .bold()
                                    .font(.system(size: 30))
                                    .padding(.leading, 20)
                                HStack {
                                    Image("blankProfilePic")
                                        .resizable()
                                        .frame(width: 70, height: 70, alignment: .center)
                                        
                                    VStack(alignment: .leading) {
                                        Text("Alex Demann")
                                            .bold()
                                    
                                        Text("Benchpress")
                                            .italic()
                                            
                                        Text("April 18th").foregroundColor(thirdTextColor)
                                            
                                    }.padding(.horizontal, 10)
                                    Spacer()
                                    VStack(alignment: .center) {
                                        Text("225")
                                            .bold()
                                            .scaleEffect(2.5)
                                            .padding(5)
                                        Text("Pounds")
                                    }.padding(.trailing, 5.0)
                                }
                                .padding(.horizontal, 20.0)
                                
                                Image("greyLine")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal)
                                    .aspectRatio(contentMode: .fit)
                                
                                HStack {
                                    Image("blankProfilePic")
                                        .resizable()
                                        .frame(width: 70, height: 70, alignment: .center)
                                        
                                    VStack(alignment: .leading) {
                                        Text("Evan Ossege")
                                            .bold()
                                    
                                        Text("Barbell Curl")
                                            .italic()
                                            
                                        Text("April 7th").foregroundColor(thirdTextColor)
                                            
                                    }.padding(.horizontal, 10)
                                    Spacer()
                                    VStack(alignment: .center) {
                                        Text("135")
                                            .bold()
                                            .scaleEffect(2.5)
                                            .padding(5)
                                        Text("Pounds")
                                    }.padding(.trailing, 5.0)
                                }
                                .padding([.leading, /*.bottom,*/ .trailing], 20.0)
                                
                                // Last item
                                Image("greyLine")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal)
                                    .aspectRatio(contentMode: .fit)
                                
                                HStack {
                                    Image("blankProfilePic")
                                        .resizable()
                                        .frame(width: 70, height: 70, alignment: .center)
                                        
                                    VStack(alignment: .leading) {
                                        Text("Alex Demann")
                                            .bold()
                                    
                                        Text("Leg Press")
                                            .italic()
                                            
                                        Text("March 30th").foregroundColor(thirdTextColor)
                                            
                                    }.padding(.horizontal, 10)
                                    Spacer()
                                    VStack(alignment: .center) {
                                        Text("155")
                                            .bold()
                                            .scaleEffect(2.5)
                                            .padding(5)
                                        Text("Pounds")
                                    }.padding(.trailing, 5.0)
                                }
                                .padding(.horizontal, 20.0)
                                
                            }.padding(.horizontal, 10)
                        }
                        
                        Spacer()
                         
                        
                    }.frame(height: 685)
                }.frame(height: .infinity)
            }
            
            /*VStack {
                Rectangle().fill(liftColor).frame(height: 50)
                Spacer()
            }.ignoresSafeArea()*/
            
            
            
        }
        
        
        
    }
}

struct ViewA_Previews: PreviewProvider {
    static var previews: some View {
        ViewA()
            
    }
}
