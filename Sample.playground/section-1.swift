// Playground - noun: a place where people can play

import UIKit

var array = ["one","two","three","four"]
for element in array {
    print(element)
}

var array2 = [1,2,3,4,5,6,7,8,9,10];

func example1(integers: [Int]) {
    
    var number = 0
    
    for element in integers{
    number += element
    }
    print("Sum all array items: \(number)")
}

example1(integers: array2)

func example2() -> [Int] {
    
    var array = [Int]()

    for i in 11...20 {
		array.append(i)
    }
    
    return array
}

var array3 = example2()
//show nsmutable array value sum
example1(integers: array3)

//delete pair items from array
func example3()  {
    
    var array = example2()
	
	array = array.filter({$0 % 2 != 0})
	
    //print pair items from array
    example1(integers: array)
}

//inferred types
func getClassName(obj : Any) -> String {
    let objectClass : AnyClass! = object_getClass(obj)
    let className = objectClass.description()
    
    return className
}

let swiftArray = [1, 2, 3]
let swiftDictionary = ["Name": "John Doe"]
let cocoaArray : NSArray = [10, 20, 30]
var mutableCocoaArray = NSMutableArray()

var 🤔 = 5
var cadena = "hola"

print(getClassName(obj: swiftArray))
print(getClassName(obj: swiftDictionary))
print(getClassName(obj: cocoaArray))
print(getClassName(obj: mutableCocoaArray))
print(getClassName(obj: 🤔))
print(getClassName(obj: cadena))
print(🤔.description)
