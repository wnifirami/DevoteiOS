//
//  ContentView.swift
//  DevoteIos
//
//  Created by Rami Ounifi on 17/5/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - Proprties
    @State var task: String = ""
    @State private var showNewTaskItem: Bool = false
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    // Fetching data
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            ZStack {
              //  MARK: - Main view
                VStack {
                    // MARK: - Header
                    HStack(spacing: 10) {
                        // title
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                        // editButton
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2)
                            )
                        //Appearance button
                        Button(action: {
                            isDarkMode.toggle()
                            playSound(sound: "sound-tap", type: "mp3")
                            feedback.notificationOccurred(.success)
                            
                        }, label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .font(.system(.title, design: .rounded))
                        })
                    }//: HStack
                    .padding()
                    .foregroundColor(.white)
                    Spacer(minLength: 80)
                    // MARK: - New task button
                    Button(action: {
                        showNewTaskItem = true
                        playSound(sound: "sound-ding", type: "mp3")
                        feedback.notificationOccurred(.success)
                    }, label: {
                       Image(systemName: "plus.circle")
                        .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        
                    })
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.pink, .blue]), startPoint: .leading, endPoint: .trailing)
                            .clipShape(Capsule())
                    )
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
                    // MARK: - Tasks
                    List {
                        ForEach(items) { item in
          ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    }//: list
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                }//: VStack
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5))
                
                // MARK: -New task item
                if showNewTaskItem {
                    BlankView(
                        backGroundColor: isDarkMode ? .black : .gray,
                        backgroundOpacity: isDarkMode ? 0.3 : 0.5)
                        .onTapGesture {
                            withAnimation {
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)                }
            }//: ZStack
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = .clear
            })
                .navigationBarTitle("Daily tasks", displayMode: .large)
            .navigationBarHidden(true)

            .background(
                BackgroundImageView()
                    .blur(radius: showNewTaskItem ? 8.0 : 0 , opaque: false)
            )
            .background(
                backgroundGradient.ignoresSafeArea(.all)
            )
     
         
        }//: Navigation
        .navigationViewStyle(StackNavigationViewStyle())
        
    }



    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .previewDevice("iPhone 12 Pro")
    }
}
