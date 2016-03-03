//: Playground - noun: a place where people can play

import UIKit


/*****   Variables   ******/
var str = "Hello, playground"
print(str)

let implicitInteger = 10
let implicitDouble = 70.0
let explicitDouble: Float = 4

let label = "The width is: "
let width = 94
let widthLabel = label + String(width)

let apples = 3.5
let name = "Pedro"
let appleSummary = "\(name) has \(apples) apples."

//Array
var shoppingList = ["Apple","Drugs","water"]
shoppingList[1] = "Oranges"
 print(shoppingList)

//Dictionary
var occupations = [
    "Pedro": "Developer",
    "Mario": "Chango"
]


//empty array & dictionary with initializers
let emptyArray = [String]()
let emptyDictionary = [String: Float]()

//Inferred empty array
shoppingList = []
occupations = [:]


/************************************ Control flow **********************************************/
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0

for score in individualScores{
    if score > 50 {
        teamScore += 3
    }else{
        teamScore++
    }
}

print(teamScore)



/************* Optional Value **************/
var optionalString: String? = "Hello"
print(optionalString == nil)

var optionalName: String? = nil//"John"
var greeting = "Hello!"
if let name = optionalName{
    greeting = "Hello \(name)"
}


let nickName: String? = nil
let fullName: String = "Panchito"

let informalGreeting = "Hi \(nickName ?? fullName)"

/*************** Switch *****************/
let vegetable = "red pepper"
switch vegetable{
    case "celery":
        print("Add some raising and make ants on a log.")
    case "cucumber", "watercress":
        print("That would make a good tea sandwich.")
    case let x where x.hasSuffix("pepper"):
        print("Is it a spicy \(x)?")
    default:
        print("Everything tastes good in soup.")
}

/********** for-in over dictionaries **********/

let interestingNumbers = [
    "Prime": [2,3,5,7,11,13],
    "Fibonacci": [1,1,2,3,5,8],
    "Square": [1,4,9,16,25],
    "Test": [1,2,3,4,100]
]

var largest = 0

for (kind, numbers) in interestingNumbers{
    for number in numbers{
        if number > largest{
            largest = number;
        }
    }
}

print(largest)



/********** While **********/
var n = 2
while n < 100 {
    n = n * 2
}
print(n)


/*********** Repeat-While ************/
var m = 2
repeat{
    m = m * 2
} while m<100
print(m)



/******** Index in a loop *******/

//Using ..< omits its upper value
//Using ... include the upper value in the range
var firstForLoop = 0

for i in 0..<4 {
    firstForLoop += i
}
print(firstForLoop)

//Traditional way
var secondForLoop = 0
for var i = 0; i<4; ++i{
    secondForLoop += i
}
print(secondForLoop)


/************************************************* Functions and Closures *********************************************/
//use func to declare a function
//use -> to set return type
func greet(name: String, day: String) ->String {
    return "Hello \(name), today is \(day)"
}
greet("Bob",day: "Monday")




/******** function returning multiple parameters: ********/
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int){
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores{
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        
        sum += score
    }
    
    return (min,max,sum)
}

let statistics = calculateStatistics([5,3,100,3,9])
print(statistics.sum)
print(statistics.2)



/*********** Functions with multiple parameters ********/
func sumOf(numbers: Int...) -> Int{
    var sum = 0
    
    for number in numbers {
        sum += number
    }
    
    return sum
}
sumOf()
sumOf(1,2,3,4)

func averageOf(numbers: Float...) -> Float{
    var avg: Float = 0
    
    if numbers.count == 0 { return 0 }
    
    for number in numbers {
        avg += number
    }
    
    
    return avg/Float(numbers.count)
}

averageOf()
averageOf(1,2,3,4)


/******************** Closures **********************/
func returnFifteen() -> Int {
    var y = 10
    func add(){
        y += 5
    }
    
    add()
    return y
}

returnFifteen()



/***** function returning another functions *******/
func makeIncrementer() -> ((Int) -> Int){
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    
    return addOne
}

var increment = makeIncrementer()
increment(7)


/******************** Functions taking another function as parameters ***********************/
func hasAnyMatches(list: [Int], condition:(Int) -> Bool) -> Bool{
    for item in list{
        if condition(item){
            return true
        }
    }
    
    return false
}

func lessThanTen(number: Int) -> Bool{
    return number < 10
}

var numbers = [20,19,7,12]

hasAnyMatches(numbers, condition: lessThanTen)


/******************* Closure without a name **********/
//Version 1
let mappedNumbers = numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result
})

print(mappedNumbers)

//version 2 -lambda expression style
let mappedNumbers2 = numbers.map({
    number in 3 * number
})

print(mappedNumbers2)

//“When a closure is the only argument to a function, you can omit the parentheses entirely.”
let sortedNumbers = numbers.sort { $0 > $1 }
print(sortedNumbers)


/************************************************************** Objects and Classes ********************************************/
class Shape {
    var numberOfSides = 0
    let constantVariable = "constant"
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
    
    func anotherDescription() -> String {
        return "\(constantVariable) variables need let at the beginning."
    }
}

var shape = Shape()
shape.simpleDescription()
shape.anotherDescription()


/********* Another version of the class with constructor ************/
class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String){
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

/********* Subclassing and Overriding *******/
class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String){
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}

let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()




/************** Getter and Setters ************/
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String){
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get{
            return 3.0 * sideLength
        }
        
        set{
           sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with side of length \(sideLength)"
    }
}

var triangle = EquilateralTriangle(sideLength: 3.1, name: "A triangle")
print(triangle.perimeter)
triangle.perimeter = 9.9
print(triangle.sideLength)


//“If you don’t need to compute the property but still need to provide code that is run before and after setting a new value, use willSet and didSet. ”

class TriangleAndSquare {
    var triangle: EquilateralTriangle{
        willSet{
            square.sideLength = newValue.sideLength
        }
    }
    
    var square: Square {
        willSet{
            triangle.sideLength = newValue.sideLength
        }
    }
    
    init(size: Double, name: String){
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}

var triangleAndSquare: TriangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)

//“When working with optional values, you can write ? before operations like methods, properties, and subscripting. If the value before the ? is nil, everything after the ? is ignored and the value of the whole expression is nil.”
let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength


/************************************************ Enumerations and Structures ************************************/
enum Rank: Int{
    case Ace = 1
    case Two,Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    
    func simpleDescription() -> String {
        switch self{
            
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
    
}

let ace = Rank.Ace
let aceRawValue = ace.rawValue



enum Suit {
    case Spades, Hearts, Diamonds, Clubs
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
}
let hearts = Suit.Hearts
let heartsDescription = hearts.simpleDescription()



//“Use the init?(rawValue:) initializer to make an instance of an enumeration from a raw value.”
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}

/******** Structures *******/
struct Card{
    var rank: Rank
    var suit: Suit
    
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}
let threeOfSpades = Card(rank: .Three, suit: .Spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()






//I need to practice this again...
enum ServerResponse {
    case Result(String, String)
    case Error(String)
}

let success = ServerResponse.Result("6 AM", "8 PM")
let failure = ServerResponse.Error("Out of cheese.")

switch success{
case let .Result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset)")
    
case let .Error(error):
    print("Failure... \(error)")
}


/******************************** Protocols and Extensions **********************************************/
protocol ExampleProtocol{
    var simpleDescription: String { get }
    mutating func adjust()
}


//Classes, enumerations, and structs can all adopt protocols:
//class
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += " Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription


//Structure
struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    
    //mutating is required for value types that want to modify its internal values (struct, enums)
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription

//Enumeration
enum SimpleEnum: ExampleProtocol{
    case Base, Adjusted
    
    var simpleDescription: String {
        get {
            return self.getDescription()
        }
    }
    
    func getDescription() ->String {
        switch self{
        case .Base:
            return "A simple description"
        case .Adjusted:
            return "An adjusted description"
        }
    }
    
    mutating func adjust() {
        self = SimpleEnum.Adjusted
    }
}

var c = SimpleEnum.Base
c.adjust()
let cDescription = c.simpleDescription


/******* Extensions ********/
//“Use extension to add functionality to an existing type, such as new methods and computed properties. ”
extension Int: ExampleProtocol{
    var simpleDescription: String {
        return "The number \(self)"
    }
    
    mutating func adjust() {
        self += 42
    }
}


var numb = 7
print(numb.simpleDescription)
numb.adjust()
print(numb.simpleDescription)


//“You can use a protocol name just like any other named type—for example, to create a collection of objects that have different types but that all conform to a single protocol. When you work with values whose type is a protocol type, methods outside the protocol definition are not available.”
let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
// print(protocolValue.anotherProperty)  // Uncomment to see the error”



/************************************ Generics **********************************************/

//Item is just a generic name. You can type "Papa" as type
func repeatItem<Item>(item: Item, numberOfTimes: Int) -> [Item]{
    var result = [Item]()
    
    //It means that we merely want to execute the block 5 times and we don't care about the index within the block.
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    
    return result
}
repeatItem("knock", numberOfTimes: 3)



//Reimplement the Swift standar library's optional type
enum OptionalValue<Wrapped>{
    case None
    case Some(Wrapped)
}

var possibleInteger: OptionalValue<Int> = .None
possibleInteger = .Some(100)




//“Use where after the type name to specify a list of requirements—for example, to require the type to implement a protocol, to require two types to be the same, or to require a class to have a particular superclass.”
//“Writing <T: Equatable> is the same as writing <T where T: Equatable>.”
func anyCommonElements <T: SequenceType, U: SequenceType where T.Generator.Element: Equatable, T.Generator.Element == U.Generator.Element> (lhs: T, _ rhs: U) -> Bool {
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}
anyCommonElements([1, 2, 3], [3])




