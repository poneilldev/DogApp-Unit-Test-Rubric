//
//  ViewState.swift
//  Dog-app
//
//  Created by Paul O'Neill on 3/29/21.
//

import Foundation

enum ViewState<Element> {
    case loading
    case error(Error)
    case noAuth
    case oneResult(Element)
    case results([Element])
}


//enum ViewState {
//    case loading
//    case error(Error)
//    case noAuth
//    case oneResult(Any)
//    case results([Any])
//}
