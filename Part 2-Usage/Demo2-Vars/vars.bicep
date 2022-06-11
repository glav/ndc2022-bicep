param environment string = 'dev'  // default of dev
param someNumber int = 123 // Default value of 123

param someArray array = [  // Array param with default value
  'This'
  'that'
]

var myArray = [   // array
  'one'
  'two'
  'three'
]

var myBool = true   // bool

var myInt = 1  // int

var myString = 'Hello NDC'  //string - note single quotes, not double

var myObj = {   // object
  some:'value'
}

@secure()
param sensistiveObject object   // secureObject in ARM

@secure()   // Decorator
param sensitiveString string    // secureString in ARM
 