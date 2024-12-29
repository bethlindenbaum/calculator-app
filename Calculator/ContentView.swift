//
//  ContentView.swift
//  Calculator
//
//  Created by Beth Lindenbaum on 12/27/24.
//

import SwiftUI

let lightPink = Color(red: 255/255, green: 182/255, blue: 193/255)
let blushPink = Color(red: 254/255, green: 130/255, blue: 140/255)
let darkPink = Color(red: 170/255, green: 51/255, blue: 106/255)
let darkLavender = Color(red: 115/255, green: 79/255, blue: 150/255)
let periwinkle = Color(red: 167/255, green: 199/255, blue: 231/255)
let saphireBlue = Color(red: 65/255, green: 105/255, blue: 225/255)
let royalBlue = Color(red: 150/255, green: 222/255, blue: 209/255)
let pink = Color(red: 255/255, green: 192/255, blue: 203/255)
let mauve = Color(red: 135/255, green: 76/255, blue: 98/255)
let customMauve = Color(red: 145/255, green: 76/255, blue: 108/255)
let pastelPink = Color(red: 255/255, green: 209/255, blue: 220/255)
let fuchsia = Color(red: 100/255, green: 0/255, blue: 100/255)
let hotPink = Color(red: 255/255, green: 105/255, blue: 180/255)
let dustyRose = Color(red: 201/255, green: 135/255, blue: 135/255)
let rose = Color(red: 255/255, green: 0/255, blue: 127/255)
let pink2 = Color(red: 231/255, green: 84/255, blue: 128/255)
let flamingo = Color(red: 252/255, green: 142/255, blue: 172/255)
let mauvelous = Color(red: 239/255, green: 152/255, blue: 170/255)
let schaussPink = Color(red: 255/255, green: 145/255, blue: 175/255)

enum CalcButton: String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "−"
    case multiply = "×"
    case divide = "÷"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "+/-"
    
    var buttonColor: Color{
        switch self{
        case .add, .subtract, .multiply, .divide, .equal:
            return mauve
        case .clear, .negative, .percent:
            return pastelPink
        default:
            return schaussPink
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    
    @State var strValue = "0"
    @State var numValue = 0
    @State var runningNumber: Double = 0
    @State var currentOperation: Operation = .none
    @State var decimalTapped = false
    @State var negativetapped = false
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    
    ]
    
    var body: some View {
        ZStack
        {
            hotPink.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Spacer()
                // Text display
                HStack{
                    Spacer()
                    Text(strValue)
                        .foregroundColor(.white)
                        .bold()
                        .font(.system(size: 80))
                }
                .padding()
                
                //Buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12){
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    . font(. system(size: 45))
                                    .frame(width: self.buttonWidth(item: item), height: self.buttonHeight())
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            switch button {
            case .add:
                self.currentOperation = .add
                self.runningNumber = Double(self.strValue) ?? 0
                print("self.runningNumber: \(self.runningNumber)")
            case .subtract:
                self.currentOperation = .subtract
                self.runningNumber = Double(self.strValue) ?? 0
            case .multiply:
                self.currentOperation = .multiply
                self.runningNumber = Double(self.strValue) ?? 0
            case .divide:
                self.currentOperation = .divide
                self.runningNumber = Double(self.strValue) ?? 0
            case .equal:
                let runningValue = self.runningNumber
                let currentValue = Double(self.strValue) ?? 0
                switch self.currentOperation {
                case .add:
                    self.strValue = "\(runningValue + currentValue)"
                case .subtract:
                    self.strValue = "\(runningValue - currentValue)"
                case .multiply:
                    self.strValue = "\(runningValue * currentValue)"
                case .divide:
                    self.strValue = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            default:
                break
            }
            
            if button != .equal {
                self.strValue = "0"
            }
        case .percent:
            let newNum = 0.01 * (Double(self.strValue) ?? 0)
            self.strValue = "\(newNum)"
            print("self.strValue: \(self.strValue)")
        case .clear:
            self.strValue = "0"
            runningNumber = 0
        case .decimal:
            if (!self.strValue.contains(".")) {
                self.strValue = "\(self.strValue)."
            }
        case .negative:
            var tempValue = Double(self.strValue) ?? 0
            tempValue *= -1
            self.strValue = "\(tempValue)"
        default:
            let number = button.rawValue
            if (self.strValue == "0") {
                strValue = number
            }
            else {
                self.strValue = "\(self.strValue)\(number)"
                print("self.strValue: \(self.strValue)")
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if (item == .zero) {
            return 2 * (UIScreen.main.bounds.width - (4*12)) / 4
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

#Preview {
    ContentView()
}
