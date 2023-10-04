import Foundation

enum MessageType {
    case error(Error)
    case info(String?)
}

struct MessageWrapper: Identifiable {
    let id = UUID()
    let messageType: MessageType
}
