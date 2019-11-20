//
// Created by Jacob Rakestraw on 11/18/19.
//

import Foundation

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
