//
//  FunctionCall.swift
//  Check
//
//  Created by Chris Howell on 29/07/2016.
//  Copyright © 2016 Chris Howell. All rights reserved.
//

import Foundation

struct FunctionCall {
    /// The name of the function
    let name: String
    
    /// The arguments passed in to the function
    let args: [Any]?
}

extension FunctionCall {
    
    /**
     Verifies whether an argument has been provided.
     
     - parameter argument: The argument to check for.
     
     - returns: Whether that argument was used in this `FunctionCall`
     */
    func checkArgument<T: Equatable>(argument: T) -> Bool {
        guard let args = args else { return false }
        return args.contains {
            guard let typed = $0 as? T else { return false }
            return typed == argument
        }
    }
    
}
