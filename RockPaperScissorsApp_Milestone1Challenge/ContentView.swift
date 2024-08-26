//
//  ContentView.swift
//  RockPaperScissorsApp_Milestone1Challenge
//
//  Created by Jesse Sheehan on 7/30/24.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var moves = ["rock", "paper", "scissors"].shuffled()
    
    @State private var computerMove = Int.random(in:0...2)
    
    @State private var playerMove = 0
    @State private var playerWin = Bool.random()
    @State private var roundIsOver = false
    @State private var winState = false
    
    @State private var score = 0
    @State private var gameResult = ""
    
    @State private var numberOfRounds = 0
    @State private var gameIsOver = false

    
    
    var body: some View {
        NavigationStack {
            
                VStack {
                    Text("\(playerWin ? "Win" : "Lose") the Game!")
                        .font(.largeTitle)
                        .padding()
                    VStack {
                        Text("Opponent's Move")
                        
                        //REPLACE BELOW WITH IMAGE
                        
                        Image(moves[computerMove])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, alignment: .center)
                        
                    }
                    Spacer()
                    //REPLACE BELOW WITH IMAGE
                    //Text("Player's Choice Goes here")
                    
//                    Image(moves[playerMove])
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 300, alignment: .center)
                    
                    Spacer()
                    Section("Choose an Attack to \(playerWin ? "Win" : "Lose")") {
                        HStack {
                            ForEach(0..<moves.count, id: \.self) {number in
                                Button {
                                    playerMove = number
                                    ChoseMove(moves[playerMove])
                                }
                            label: {
                                Image(moves[number])
                                    .resizable()
                                    .scaledToFit()
                            }
                            }
                        }
                    }.font(.title)
                    
                    
                }.navigationTitle("Rock, Paper, Scissors")
                    .padding()
            
                    .alert(gameResult, isPresented: $roundIsOver) {
                        Button ("Next Round", action: newRound)
                        } message: {
                            Text("\(winState ? "You picked right!" : "You picked wrong") \n Score is:  \(score)  ")
                        }
                        .alert(score > 5 ? "You Won!" : "You Lose!", isPresented: $gameIsOver) {
                            Button ("Play Again", action: newGame)
                            } message: {
                                Text("\(score > 5 ? "Great job!" : "You needed 5 points to win") \n Final Score:  \(score)  ")
                            }
                
            Text("Score: \(score)")
                .foregroundStyle(score >= 0 ? .blue : .red)
            Text("Round: \(numberOfRounds + 1)")
        }
    }
    
    func ChoseMove(_ move: String) {
        let opponent = moves[computerMove]
        print(opponent)
        let player = move
        print(player)
        
        
        switch opponent {
            
        case "rock":
            if (player == "paper" && playerWin) || (player == "scissors" && !playerWin) {
                winState = true
            } else {
                winState = false
            }
                
        case "paper":
            if (player == "scissors" && playerWin) || (player == "rock" && !playerWin){
                winState = true
            } else {
                winState = false
            }
            
        case "scissors":
            if (player == "rock" && playerWin) || (player == "paper" && !playerWin){
                winState = true
            } else {
                winState = false
            }
            
        default:
            print("There's been an error")
        }
        
        
        gameResult = winState ? "Correct!" : "Incorrect :("
        
        if winState == true {
            score += 1
        } else {
            score -= 1
        }
        
        numberOfRounds += 1
        numberOfRounds < 10 ? roundIsOver.toggle() : gameIsOver.toggle()
    }
        
            
    
    
    func newRound() {
        winState = false
        moves.shuffle()
        computerMove = Int.random(in: 0...2)
        playerMove = 0
        roundIsOver = false
        playerWin = Bool.random()
    }
    
    func newGame() {
        score = 0
        numberOfRounds = 0
        gameIsOver = false
        newRound()
    }
    
}

#Preview {
    ContentView()
}
