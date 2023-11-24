//
//  ContentView.swift
//  AlertToastDemo
//
//  Created by Peace Cho on 10/14/22.
//

import AlertToast
import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject var viewModel: AlertViewModel
    
    var body: some View {
        NavigationView{
            
           Group{
               NavigationLink("Move to Second View", destination: SecondView().environmentObject(viewModel))
           }
           
        }
        .toast(isPresenting: $viewModel.show, duration: 2){
            //Return AlertToast from ObservableObject
            viewModel.alertToast
        }
    }
}

struct SecondView: View{
    
    @EnvironmentObject var viewModel: AlertViewModel
    
    var body: some View{
        VStack{
            
             //Presenting alert from ObservableObject
            Button("Show Alert"){
                viewModel.show.toggle()
            }
            
            //You can also change the alert type, present
            //a different one and show (because of didSet)
            Button("Change Alert Type to complete"){
                viewModel.alertToast = AlertToast(type: .complete(.green), title: "Completed!", subTitle: nil)
            }
            
            Button("Change Alert Type to error"){
                viewModel.alertToast = AlertToast(type: .error(.red), title: "Error occur", subTitle: "Try again later.")
            }
            
            Button("Change Alert Type to loading"){
                viewModel.alertToast = AlertToast(type: .loading, title: "Loading..", subTitle: nil)
            }

            Button("Show a banner toast"){
                viewModel.alertToast = AlertToast(
                    displayMode: .banner(.pop),
                    type: .systemImage("checkmark.circle", Color.purple),
                    title: "Well done!",
                    subTitle: "Here be a subtitle, matey!",
                    style: .style(
                        backgroundColor: Color.green,
                        titleColor: Color.purple,
                        subTitleColor: Color.pink,
                        titleFont: Font.title,
                        subTitleFont: Font.custom("Marker Felt", size: 12),
                        bannerAligmnent: .center
                    )
                )
            }

            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//Create an ObservableObject:
class AlertViewModel: ObservableObject{
    
    @Published var show = false
    @Published var alertToast = AlertToast(type: .regular, title: "this is regular alert!"){
        didSet{
            show.toggle()
        }
    }

}
