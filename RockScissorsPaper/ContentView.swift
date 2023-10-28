//
//  ContentView.swift
//  RockScissorsPaper
//
//  Created by stimLite on 28.10.2023.
//

import SwiftUI

struct LiderBoard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.white)
    }
}

extension View {
    func liderBoard() -> some View {
        modifier(LiderBoard())
    }
}

struct ContentView: View {
    
    var moves = ["🤛", "✌️", "🖐️"]
    
    @State private var currentChoise = Int.random(in: 0..<2)
    @State private var winPlayer = 0
    @State private var winPhone = 0
    @State private var isTaped = false
    
    @State private var scorTitle = ""
    @State private var showScor = false
    @State private var newGame = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.2, green: 0.10, blue: 0.35), location: 0.1),
                .init(color: Color(red: 0.76, green: 0.75, blue: 0.36), location: 0.9)
            ], center: .center, startRadius: 100, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Text("Guess the Moves")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    Text("Tap the moves")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.weight(.heavy))
                    

                    Text(isTaped ? moves[currentChoise] : "❓")
                        .font(.system(size: 200))
                    
                    HStack {
                        ForEach(0..<3) { number in
                            Button(moves[number]){
                                if winPhone == 9 || winPlayer == 9 {
                                    startNewGame(number)
                                } else {
                                    movedTaped(number)
                                }
                            }
                            .font(.system(size: 100))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .cornerRadius(20)
                
                VStack {
                    HStack(spacing: 30) {
                        Text("Player")
                            .liderBoard()
                        
                        Text("Phone")
                            .liderBoard()
                    }
                    
                    HStack(spacing: 30) {
                        Text("scor: \(winPlayer)")
                            .liderBoard()
                        
                        Text("scor: \(winPhone)")
                            .liderBoard()
                    }
                }
                .padding(.horizontal, 30)
            }
            .padding()
        }
        .alert(scorTitle, isPresented: $showScor) {
            Button("Continum", action: logickGame)
        }
        .alert(scorTitle, isPresented: $newGame) {
            Button("Continum", action: scoreNewGame)
        }
    }
    
    func movedTaped(_ number: Int) {
        switch number {
        case 0 where moves[currentChoise] == "✌️":
            scorTitle = "You win"
            winPlayer += 1
        case 1 where moves[currentChoise] == "🖐️":
            scorTitle = "You win"
            winPlayer += 1
        case 2 where moves[currentChoise] == "🤛":
            scorTitle = "You win"
            winPlayer += 1
        default:
            if number == currentChoise {
                scorTitle = "Draw"
            } else  {
                scorTitle = "Phone win"
                winPhone += 1
            }
        }
        isTaped = true
        showScor = true
    }
    
    func startNewGame(_ number: Int) {
        if winPhone == 10 {
            scorTitle = "Phone!!!! win: \(winPhone)"
        } else {
            scorTitle = "You!!!! win: \(winPhone)"
        }
        winPhone = 0
        winPlayer = 0
        newGame = true
    }
    
    func scoreNewGame() {
        winPhone = 0
        winPlayer = 0
        logickGame()
    }
    
    func logickGame() {
        isTaped = false
        currentChoise = Int.random(in: 0..<2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
