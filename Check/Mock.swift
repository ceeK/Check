//
//  Mock.swift
//  Check
//
//  Created by Chris Howell on 29/07/2016.
//  Copyright © 2016 Chris Howell. All rights reserved.
//

import Foundation

class Mock {
    
    /// All of the calls received by this Mock
    private(set) var calls: [FunctionCall] = []
    
    /// All of the responses that this mock should return
    /// "methodName" : response
    var responses: [String : Any] = [:]
    
    /**
     Stubs a response and tracks the method call.
     
     - parameter functionName: The function name to track, usually not provided
     - parameter args:         The arguments to track
     
     - returns: The stubbed response to return
     */
    func stub<T>(functionName: String = #function, args: [Any]? = nil) -> T? {
        let shortFunctionName = functionName.componentsSeparatedByString("(").first!
        calls.append(FunctionCall(name: shortFunctionName, args: args))
        return responses[shortFunctionName] as? T
    }
    
    /**
     Tracks the method call without providing a stubbed response.
     
     - parameter functionName: The function name to track, usually not provided
     - parameter args:         The arguments to track
     */
    func spy(functionName: String = #function, args: [Any]? = nil) {
        let shortFunctionName = functionName.componentsSeparatedByString("(").first!
        calls.append(FunctionCall(name: shortFunctionName, args: args))
    }
    
}

extension Mock {
    
    /**
     Returns a particular function call if it exists.
     
     - parameter name: The name of the function call.
     
     - returns: An optional function call
     */
    func fetchCall(named name: String) -> FunctionCall? {
        return calls.filter { $0.name == name }.first
    }
    
    /**
     Verifies whether a particular function was called.
     
     - parameter name:       The name of the function.
     - parameter occurances: The number of times that the function should have been called.
     
     - returns: Whether the function was called.
     */
    func checkMethodCall(named name: String, occurances: Int = 1) -> Bool {
        return calls.filter { $0.name == name }.count == occurances
    }
    
    /**
     Verifies whether an argument was used within a method call.
     
     - parameter method:   The method to check the argument against.
     - parameter argument: The argument to check against.
     
     - returns: Whether the argument occured in the function call.
     */
    func checkArguments<T: Equatable>(method method: String, argument: T) -> Bool {
        guard let function = calls.filter({ $0.name == method }).first else { return false }
        return function.checkArgument(argument)
    }
    
}
