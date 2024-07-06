import SwiftUI

struct ContentView: View {
    
    var jokes = [Joke(setup: "Why did the chicken cross the road?",
                      punchline: "To get to the other side!"),
                 Joke(setup: "Why couldn't the bicycle stand up?",
                      punchline: "It was two tired!"),
                 Joke(setup: "Is this pool safe for diving?",
                      punchline: "It deep ends"),
                 Joke(setup: "Where do you learn to make ice cream?",
                      punchline: "Sunday School"),
                 Joke(setup: "Did you hear about the cheese factory that exploded in France?",
                      punchline: "There was nothing left but de Brie"),
                 Joke(setup: "Dad, can you put my shoes on?",
                      punchline: "I dont think they'll fit me")]
    
    @State private var showPunchline = false
    @State private var currentJoke = 0
    @State private var isFeedbackPresented = false
    
    @State private var isPositive: Bool = false
    @State private var displaySheet: Bool = false
    
    @State private var punchlineSize: CGFloat = 0.1
    @State private var punchlineRotation: Angle = .zero
    @State private var opacity: Double = 0
    @State private var tapToContinueOffset: CGFloat = 50
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .onTapGesture {
                    if showPunchline {
                        currentJoke += 1
                        showPunchline = false
                        isFeedbackPresented = true
                    }
                }
            VStack {
                Text(jokes[currentJoke % jokes.count].setup)
                    .padding()
                
                Button {
                    print("Button tapped!!")
                    withAnimation {
                        showPunchline = true
                    }
                } label: {
                    Text("What?")
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(.white)
                }
                .padding()
                
                if showPunchline {
                    Text(jokes[currentJoke % jokes.count].punchline)
                        .padding()
                        .scaleEffect(punchlineSize)
                        .rotationEffect(punchlineRotation)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                punchlineSize = 1
                                punchlineRotation = .degrees(360 * 2)
                                opacity = 1
                                tapToContinueOffset = 0
                            }
                        }
                        .onDisappear {
                            punchlineSize = 0.1
                            punchlineRotation = .zero
                            opacity = 0
                            tapToContinueOffset = 50
                        }
                    
                    Text("Tap to continue")
                        .italic()
                        .padding()
                        .opacity(opacity)
                        .offset(y: tapToContinueOffset)
                }
            }
        }
        .alert("Did you like the last joke?", isPresented: $isFeedbackPresented) {
            Button("😍") {
                print("good")
                isPositive = true
                displaySheet = true
            }
            Button("😒") {
                print("you're a terrible person")
                isPositive = false
                displaySheet = true
            }
        }
        .sheet(isPresented: $displaySheet) {
            FeedbackResponseView(isPositive: isPositive)
        }
    }
}

#Preview {
    ContentView()
}
