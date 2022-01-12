# IGTest (iOS)

The point of this task is to demonstrate my thinking process, deductive reasoning, problem solving and how well I could interpret and implement a brief application. 

### Requirements

- Xcode 13 or later.

- Swift 5.0 or later.

- iOS 13 or later.

## About
It was used the **MVVM-C** pattern, a combination of Model-View-ViewModel architecture and the Coordinator pattern, where each View on the screen will be backed by a View Model that represents the data for the view and a routing manager.

## How to use it
### Installing
Just CMD + R to run the project. There is no thirdy library or pre configuration to do.

## Tests
### Steps to run test cases.
1. Cmd U for running all test cases.
2. To run an individual test case, just go to a specific test case file and click on run from the left bar.

## Coding style
#### View Controllers:
It is used only to display data.

#### View Models
It is used to provide data to the view and should be able to accomodate the complete view.
It should not contain networking code or data access code, directity.

## Authors
* **Enrique Melgarejo**

## License
This project is licensed under the MIT License.
