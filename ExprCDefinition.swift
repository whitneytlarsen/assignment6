//
// Created by Jacob Rakestraw on 11/18/19.
//

import Foundation
import RGMEValues

//definitions for ExprC
struct numC {
    var v: numV
}
struct idC {
    var v: String
}
struct ifC {
    var test: ExprC
    var t: ExprC
    var e: ExprC
}
struct lamC {
    var args: Array<ExprC>
    var body: ExprC
}
typealias ExprC = numC & idC & ifC & lamC
