//
// Created by Jacob Rakestraw on 11/18/19.
//

import Foundation

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
