//
//  ContentView.swift
//  Moonshot
//
//  Created by Mario Alberto Barragan Espinosa on 11/5/19.
//  Copyright © 2019 Mario Alberto Barragan Espinosa. All rights reserved.
//

import SwiftUI

struct ContentView: View {

  let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  let missions: [Mission] = Bundle.main.decode("missions.json")
  @State private var showLaunchDate = true
  
    var body: some View {
      NavigationView {
        List(missions) { mission in
          NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
            MissionCell(mission: mission, showLaunchDate: self.showLaunchDate)
          }
        }
      .navigationBarTitle("Moonshot")
        .navigationBarItems(trailing: Button("Show") {
          self.showLaunchDate.toggle()
        })
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
