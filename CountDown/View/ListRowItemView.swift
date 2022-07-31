//
//  ListRowItemView.swift
//  CountDown
//
//  Created by Tri Pham on 7/29/22.
//

import SwiftUI

struct ListRowItemView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var item: Item
    
    private func countdown(dueDate: Date) -> String {
        if dueDate < Date.init() {
            return "0D"
        }
        
        var returnStr = ""
  
        let components = Calendar.current.dateComponents([.year, .month, .day], from: Date.init(), to: dueDate)
        let year = components.year ?? 0
        let month = components.month ?? 0
        let day = components.day ?? 0
        
        if year == 0 && month == 0 && day == 0 {
            return "0D"
        }
        
        if year > 0 {
            returnStr += "\(year)Y"
        }
        
        if month > 0 {
            returnStr += "\(month)M"
        }
        
        if day > 0 {
            returnStr += "\(day)D"
        }
        
        return returnStr
        
    }
    
    
    
    
    var body: some View {
        Toggle(isOn: $item.completion) {
            HStack {
                Text(item.task ?? "")
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundColor(item.completion ? Color.pink : Color.primary)
                    .padding(.vertical, 12)
                    .animation(.default, value: item.completion)
                    .frame(alignment: .leading)
                Spacer()
                
                Text("\(countdown(dueDate: item.countdown ?? Date.init()))")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(item.completion ? Color.pink : Color.primary)
                    .padding(.vertical, 12)
                    .animation(.default, value: item.completion)
                    .frame(alignment: .trailing)
            }
            
        }
        .toggleStyle(CheckBoxStyle())
        .onReceive(item.objectWillChange, perform: { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        })
        
    }
}
