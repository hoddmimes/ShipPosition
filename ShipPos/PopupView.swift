//
//  PopupView.swift
//  ShipPos
//
//  Created by Pär Bertilsson on 2023-02-06.
//

import SwiftUI


enum EventType {
    case warn,error,info,success
}

struct PopupView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var title: String
    @Binding var message: String
    @Binding var event: EventType
    

    var body: some View {

        VStack {
            Text("")
       
            if event == .info {
               Image( systemName: "info.circle").resizable()
                    .frame(width: 40, height: 40)
            } else if event == .success {
                Image( systemName: "checkmark.circle.fill").resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.green)
            } else if event == .warn {
                Image( systemName: "exclamationmar.circle.fill").resizable()
                    .frame(width: 40, height: 40).foregroundColor(.yellow)
            } else if event == .error {
                Image( systemName: "xmark.circle.fill").resizable()
                    .frame(width: 40, height: 40).foregroundColor(.red)
            }
            
            if title != "" {
                Text( title )
                    .frame(width: UIScreen.main.bounds.width-40, height: 50)
                    .font(.title)
            }
            Text(message)
            Spacer()
            Button("ok") {
                dismiss()
            }
            .frame(width: 80, height: 26).foregroundColor(Color.white)
                .background(Color.blue).font(SwiftUI.Font.title3)
              .cornerRadius(25)
            Text("")
        }.frame(width: UIScreen.main.bounds.width-50, height: 240)
         .background(Color.black.opacity(0.2))
                     .cornerRadius(12)
                     .clipped()
        
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView(
                  title: .constant("Test Title"),
                  message: .constant( "Test Message"),
                  event: .constant(EventType.success))
    }
}
