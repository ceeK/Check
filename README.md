# Check

[![Version](https://img.shields.io/cocoapods/v/Check.svg?style=flat)](http://cocoapods.org/pods/Check) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
 [![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/hyperium/hyper/master/LICENSE)

Check is a Swift mock library for creating concise, [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) mocks.

Check has been designed to work when using protocols to inject dependencies. 

## Creating a mock

You can create a mock by subclassing `Mock`, conforming to the protocol you want to mock, and implementing either `stub()` or `spy()` in your function implementations.

```swift
class MockDolphin: Mock, Dolphin {
	
	func click() -> String {
		return stub()
	}

	func jump(numberOfTimes: Int) -> String {
		return stub(args: [numberOfTimes])
	}

	func swim() {
		spy()
	}

	func dive(handler: (depth: Float, success: Bool) -> ()) {
		guard let stub: (Float, Bool) = stub() else { return }
		handler(depth: stub.0, success: stub.1)
	}

}
```

## Using the mock in your tests 

To stub a response in your test class:

```swift
	mockDolphin.responses["click"] = "Click!"
	mockDolphin.responses["dive"] = (5.4, true)
```

To verify a method call:

```swift
	mockDolphin.checkMethodCall(named: "swim")
```

To verify an argument:

```swift
	mockDolphin.checkArguments(method: "jump", argument: 3)
```

## More detailed usage

#### Stubbing a method

To enable the stubbing of a method's response from the test spec, simply return `stub()` in the call:

```swift
	func click() -> String {
		return stub()
	}
```

To be able to track the arguments passed into a function, record which arguments you wish to track:

```swift
	func jump(numberOfTimes: Int) -> String {
		return stub(args: [numberOfTimes])
	}
```

#### Stubbing a variable

It's also possible to stub the response of a variable. To get around the Swift type system, you may need to force unwrap the response of `stub()`: 

```swift
	var dolphinGender: Gender {
		return stub()!
	}

	var isDolphinSwimming: Bool  {
        get {
            return stub()!
        }
        set {}
    }
```

#### Stubbing a method with a closure

```swift
	func dive(handler: (depth: Float, success: Bool) -> ()) {
		guard let stub: (Float, Bool) = stub() else { return }
		handler(depth: stub.0, success: stub.1)
	}
```

#### Spying on a method

If you don't need to stub a method response, you can show your intent by instead calling `spy()` in the function implementation:

```swift
	func swim() {
		spy()
	}
```

## Installation

Check is available through CocoaPods and Carthage. 

### Cocoapods

To install, simply add the following line to your podfile:

```ruby
pod "Check"
```

Then run `pod install`

### Carthage

Add the `ceek/Check` project to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile)

```ruby
github "ceeK/Check"
```

Then run `carthage update --platform iOS`

## License
The MIT License (MIT)

Copyright (c) 2016 Chris Howell

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.