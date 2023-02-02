//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardTabView()
                .tabItem {
                    VStack {
                        Text("Dashboard")
                        Image(systemName: "chart.pie")
                    }
            }
            .tag(0)
            
            MonthlyView()
                .tabItem {
                    VStack {
                        Text("Budget")
                        Image(systemName: "rectangle.stack.badge.person.crop")
                    }
                }
                .tag(1)
            
            LogsTabView()
                .tabItem {
                    VStack {
                        Text("Expenses")
                        Image(systemName: "tray")
                    }
            }
            .tag(2)
        }
    }
}
