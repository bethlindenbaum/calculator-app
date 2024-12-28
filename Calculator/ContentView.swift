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
let darkLavendar = Color(red: 115/255, green: 79/255, blue: 150/255)
let periwinkle = Color(red: 167/255, green: 199/255, blue: 231/255)
let saphireBlue = Color(red: 65/255, green: 105/255, blue: 225/255)
let royalBlue = Color(red: 150/255, green: 222/255, blue: 209/255)
let pink = Color(red: 255/255, green: 192/255, blue: 203/255)

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
            return periwinkle
        case .clear, .negative, .percent:
            return blushPink
        default:
            return pink
        }
    }
}

struct ContentView: View {
    
    @State var value = "0"
    
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
            darkPink.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Spacer()
                // Text display
                HStack{
                    Spacer()
                    Text(value)
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
                                    . font(. system(size: 40))
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
            break
        case .clear:
            self.value = "0"
        case .decimal, .percent, .negative:
            break
        default:
            let number = button.rawValue
            if (self.value == "0") {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
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
