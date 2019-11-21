//
// Created by Jacob Rakestraw on 11/18/19.
//

import Foundation

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

enum parseError: Error {
    case invalidSyntax
}

func parse(sexp : String) throws -> ExprC {
    guard (sexp[sexp.startIndex] == "{") && (sexp[sexp.index(before: sexp.endIndex)] == "}") else {
        throw parseError.invalidSyntax
    }
    let start_ind = sexp.index(sexp.startIndex, offsetBy: 1)
    let end_ind = sexp.index(sexp.endIndex, offsetBy: -1)
    let range = start_ind..<end_ind
    let sexp = sexp[range]
    let splitstr = sexp[sexp.startIndex...sexp.index(before: sexp.endIndex)].components(separatedBy: " ")
    print(splitstr)
    if(splitstr[0].isInt) {
        return numC(fromV: Int(splitstr[0])!)
    } else {
        throw parseError.invalidSyntax
    }
}

do {
    try dump(parse(sexp: "{3}"))
    try dump(parse(sexp: "{a}"))
    try dump(parse(sexp: "{\"a\"}"))
}
