//
//  ChatModel.swift
//  Chat
//
//  Created by Sunggon Park on 2024/03/16.
//

enum Who {
    case me
    case you
}

struct ChatModel {
    let who: Who
    let message: String
}
