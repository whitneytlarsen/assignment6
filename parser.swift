#!/usr/bin/swift -frontend -interpret -enable-source-import -I.
//
// Created by Jacob Rakestraw on 11/18/19.
//

import Foundation

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}
extension Substring {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}

enum parseError: Error {
    case invalidSyntax
}

public class ExprC{}

//definitions for ExprC
public class numC : ExprC {
    init (fromV: numV){
        v = fromV
    }
    var v: numV
}
public class idC : ExprC {
    init (fromV: String){
        v = fromV
    }
    var v: String
}
public class ifC : ExprC {
    init (fromTest: ExprC, fromT: ExprC, fromE: ExprC) {
        test = fromTest
        t = fromT
        e = fromE
    }
    var test: ExprC
    var t: ExprC
    var e: ExprC
}
public class lamC : ExprC {
    init (fromArgs: Array<ExprC>, fromBody: ExprC) {
        args = fromArgs
        body = fromBody
    }
    var args: Array<ExprC> = []
    var body: ExprC
}
public class appC : ExprC {
    init (fromFunct: ExprC, fromArgs: Array<ExprC>) {
        funct = fromFunct
        args = fromArgs
    }
    var args: Array<ExprC> = []
    var funct: ExprC
}

public class Val{}

public class numV: Val {
    init (fromV: Double){
        v = fromV
    }
    var v: Double
}
public class boolV : Val {
    init (fromV: Bool){
        v = fromV
    }
    public func equals(other: boolV) -> Bool{
        return v == other.v
    }
    var v: Bool
}
public class nullV : Val {
    var v = 0
}

func parse(sexp : String) throws -> ExprC {
    if(sexp.isInt) {
        return numC(fromV: numV(fromV: Double(sexp)!))
    }
    if (sexp.prefix(1) != "{") {
        return idC(fromV: sexp)
    }
    guard (sexp[sexp.startIndex] == "{") && (sexp[sexp.index(before: sexp.endIndex)] == "}") else {
        throw parseError.invalidSyntax
    }
    let start_ind = sexp.index(sexp.startIndex, offsetBy: 1)
    let end_ind = sexp.index(sexp.endIndex, offsetBy: -1)
    let range = start_ind..<end_ind
    var sexp = String(sexp[range])
    var exprs: Array<String> = []
    while (sexp.count > 0) {
        let next_exp = try get_next_exp(str: sexp)
        print(next_exp)
        exprs.append(String(next_exp))
        print(next_exp.startIndex)
        let new_start = next_exp.endIndex
        let new_range = new_start..<end_ind
        print(new_range)
        print(sexp.count)
        sexp = String(String(sexp.trimmingCharacters(in: .whitespacesAndNewlines))[new_range])
    }
    print(exprs)
    return numC(fromV: numV(fromV: 1))
}

func get_next_exp(str: String) throws -> String {
    let new_str = String(str.trimmingCharacters(in: .whitespacesAndNewlines))
    if(new_str.prefix(1) != "{") {
        return new_str.components(separatedBy: " ")[0]
    }
    var open_parens: Int = 0
    var close_parens: Int = 0
    for i in 0..<new_str.count {
        if(new_str[i] == "{") {
            open_parens += 1
        }
        if(new_str[i] == "}") {
            close_parens += 1
            if(open_parens == close_parens) {
                return String(new_str[...i])
            }
        }
    }
    throw parseError.invalidSyntax
}

do {
    try dump(parse(sexp: "3"))
    try dump(parse(sexp: "a"))
    try dump(parse(sexp: "\"a\""))
    try dump(parse(sexp: "{+ 1 2}"))
    try dump(parse(sexp: "{lam {x} {+ x 2}}"))
    try dump(parse(sexp: "{var {x = 1}\n{+ x 2}}"))
    try dump(get_next_exp(str: " {+ x 2} 3"))
}
