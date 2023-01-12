//
//  ContentView.swift
//  Stay Focused2
//
//  Created by Sara bayan alharbi on 12/06/1444 AH.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State var isVoiceOverPressed = false
    @State var accessibilityInputLabels = ["Start Timer", "Go To Goals"]
    @State var sendMessage = false
    @State var Start = false
    @State var to : CGFloat = 0
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var count = 25
    @State var TimeRemaining = 1500
    func ConvertSecondsToTime(timeInSeconds : Int)-> String{
        let minutes = timeInSeconds / 60
        let seconds = timeInSeconds % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
   
    var body: some View {
//     NavigationView{
            
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(red: 0.1, green: 0.72, blue: 0.655))
                    .ignoresSafeArea()
                    .padding(.top, -30)
                    .padding(.top, 1.0)
                Text("Timer")
                      .font(.title)
                          .fontWeight(.bold)
                          .foregroundColor(Color.white)
                          .padding(.bottom, 744.0)
                
                RoundedRectangle(cornerRadius: 45.0)
                .padding(.horizontal)
                    .frame(width: 350.0, height: 650.0)
                    .foregroundColor(.white)
                
                
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading){
                            Button {
                                print("Done Tapd")
                            } label: { NavigationLink(destination: Tips(isVoiceOverPressed: false), label: {
                                Image(systemName: "lightbulb.circle")
                                    .padding(.leading, 220.0)
                                    .font(.system(size: 35))
                                    .foregroundColor(Color(hue: 0.081, saturation: 0.459, brightness: 0.949))

                                    .accessibilityLabel("Tips")
                                    .accessibilityAction {
                                        isVoiceOverPressed = true
                                    }
                            })
                            }
                        }
                   }
    
                   
                        
                Button {
                    print("s")}
            label: {
                NavigationLink(destination: new(isVoiceOverPressed: false), label: {

                    ZStack{
                        RoundedRectangle (cornerRadius: 12.0)
                            .frame(width: 200.0 ,height: 50.0)
                            .foregroundColor(Color(red: 0.978, green: 0.602, blue: 0.252))
                            .padding(.leading, 10.0)
                            .padding(.top,500.0)
                            
                            .accessibilityLabel("Goals")
                            .accessibilityAction {
                                isVoiceOverPressed = true
                            }
                        
                      
                        Text ("Goals")
                            .font(.title)
                         .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .padding(.leading, 10.0)
                            .padding(.top, 500.0)
                          
                        }
                   
                })
          
            }

                
                ZStack{
                    Circle()
                        .trim(from: 0, to: 55)
                        .stroke(Color.black.opacity(0.30), style: StrokeStyle(lineWidth:10, lineCap: .round))
                        .frame (width: 250, height: 245)
                    
                    Circle()
                        .trim(from: 0, to: self.to)
                        .stroke(Color(red: 0.982, green: 0.598, blue: 0.252), style: StrokeStyle(lineWidth:10, lineCap: .round))
                        .frame (width: 250, height: 245)
                }
                
                        .rotationEffect(.init(degrees: -90))
                      
                VStack{
                    Text(ConvertSecondsToTime(timeInSeconds: TimeRemaining))
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.978, green: 0.602, blue: 0.252))
                    HStack(spacing: 15){
                        Button(action:{
                            if self.TimeRemaining == 1500{
                                self.TimeRemaining = 1500
                                withAnimation(.default){
                                    self.to = 0
                                }
                            }
                            self.Start.toggle()
                        })
                        {
                            Image(systemName: self.Start ?  "pause" : "play")
                                .frame(width: 34, height: 48)
                                .font(.title)
                                .foregroundColor(Color(red: 0.982, green: 0.602, blue: 0.252))
//
                        }
                    }
                               .padding(.vertical)
                               .clipShape(Capsule())
                   
                }

                
                .onAppear(perform: {
                    UNUserNotificationCenter.current().requestAuthorization(options:
                    [.badge,.sound, .alert]) { (_,_) in }
                })
                
                .onReceive(self.time) { (_) in
                    if self.Start{
                        if self.TimeRemaining != 0{
                            self.TimeRemaining -= 1
                            print("hello \(TimeRemaining)")
                            
                            withAnimation(.default){
                                self.to = CGFloat(self.TimeRemaining) / 1500
                            }
                        }
                        else{
                            self.Start.toggle()
                            self.Notify()
                        }
                    }
                }
                
                
//            }
        
        }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
                    ContentView()
        }
    }
    
    func Notify(){
        let content = UNMutableNotificationContent()
        content.title = "Message"
        content.body = "Time Take a break"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let req = UNNotificationRequest(identifier: "MSG", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }
}


