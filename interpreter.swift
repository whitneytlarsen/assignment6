//
// Created by Jacob Rakestraw on 11/19/19.
//
import Foundation

public func interpret(exp: ExprC, env: [String: Val]) throws -> Val {
    switch exp {
    case let numExp as numC:
        return numExp.v as Val
    case let idExp as idC:
        return env[idExp.v] as! Val
    case let ifCexp as ifC:
        if let test = try interpret(exp: ifCexp.test, env: env) as? boolV{
            if test.equals(other: boolV(fromV: true)) {
                return try interpret(exp: ifCexp.t, env: env)
            }else{
                return try interpret(exp: ifCexp.e, env: env)
            }
        }else{
            return nullV() as Val
        }
    default:
        return nullV() as Val
    }
}

