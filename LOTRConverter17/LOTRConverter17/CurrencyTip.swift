//
//  CurrencyTip.swift
//  LOTRConverter17
//
//  Created by Sunggon Park on 2024/04/02.
//

import Foundation
import TipKit

struct CurrencyTip: Tip {
    var title = Text("Change Currency")
    
    var message: Text? = Text("You can tap the left of right currency to bring up the Select Currency screen.")
}
