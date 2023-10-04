import SwiftUI

struct MessageView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var messageWrapper: MessageWrapper?
    
    var body: some View {
        
        VStack {
            if let messageWrapper {
                switch messageWrapper.messageType {
                    case .error(let error):
                        VStack {
                            Text(error.localizedDescription)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }.padding()
                            .background(.red)
                        
                    case .info(let message):
                        Text(message ?? "")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .background(.orange)
                           
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous))
        .padding()
        .foregroundColor(.white)
        .task {
            try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            messageWrapper = nil
        }
    }
}
