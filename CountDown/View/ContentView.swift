//
//  ContentView.swift
//  CountDown
//
//  Created by Tri Pham on 7/28/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State var task: String = ""
    @State var dueDate: Date = Date.init()
    @State private var showNewTaskItem: Bool = false
    @State private var showSettingsView: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext


    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack(spacing: 5) {
                        Text("Countdown")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2)
                            )
                        
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
                        
                        Button(action: {
                            showSettingsView = true
                            playSound(sound: "sound-tap", type: "mp3")
                            feedback.notificationOccurred(.success)
                        }, label: {
                            
                            Image(systemName: isDarkMode ? "gearshape.fill" : "gearshape")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        })

                    }
                    .padding()
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 80)
                    
                    Button(action: {
                        showNewTaskItem = true
                        playSound(sound: "sound-ding", type: "mp3")
                        feedback.notificationOccurred(.success)
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Countdown")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    })
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading, endPoint: .trailing)
                        .clipShape(Capsule())
                    )
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0, y: 4)
                    
                    
                    List {
                        ForEach(items) { item in
                            ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 8)
                    .frame(maxWidth: 640)
                    .cornerRadius(12)
                }
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                .blur(radius: showSettingsView ? 8.0 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5), value: 0.5)
                
                if showNewTaskItem {
                    BlankView(
                        backgroundColor: isDarkMode ? Color.black : Color.gray,
                        backgroundOpacity: isDarkMode ? 0.3 : 0.5)
                        .onTapGesture {
                            withAnimation() {
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
                
                if showSettingsView {
                    BlankView(
                        backgroundColor: isDarkMode ? Color.black : Color.gray,
                        backgroundOpacity: isDarkMode ? 0.3 : 0.5)
                        .onTapGesture {
                            withAnimation() {
                                showSettingsView = false
                            }
                        }
                    SettingsView(isShowing: $showSettingsView)
                }
                
            }
            .onAppear() {
                UITableView.appearance().backgroundColor = UIColor.clear
            }
            .navigationBarTitle("Countdown", displayMode: .large)
            .navigationBarHidden(true)
            .background(
                BackgroundImageView()
                    .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
            )
            .background(
                backGroundGradient.ignoresSafeArea(.all)
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
