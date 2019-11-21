//
//  main.swift
//  Assgn6
//
//  Created by Jacob Rakestraw on 11/20/19.
//  Copyright © 2019 Jacob Rakestraw. All rights reserved.
//

import Foundation

if let val = try interpret(exp: numC(fromV: numV(fromV: 20)), env: [:]) as? numV{
    print(val.v == 20)
}else{
    print("Failed 1")
}

if let val = try interpret(exp: idC(fromV: "num"), env: ["num": numV(fromV: 20)]) as? numV{
    print(val.v == 20)
}else{
    print("Failed 2")
}
if let val = try interpret(exp: ifC(fromTest: idC(fromV: "test"), fromT: numC(fromV: numV(fromV: 20)), fromE: numC(fromV: numV(fromV: 30))), env: ["test": boolV(fromV: true)]) as? numV{
    print(val.v == 20)
}else{
    print("Failed 3")
}
if let val = try interpret(exp: ifC(fromTest: idC(fromV: "test"), fromT: numC(fromV: numV(fromV: 20)), fromE: numC(fromV: numV(fromV: 30))), env: ["test": boolV(fromV: false)]) as? numV{
    print(val.v == 30)
}else{
    print("Failed 4")
}

