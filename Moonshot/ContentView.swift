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
  
    var body: some View {
      NavigationView {
      List(missions) { mission in
          NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
              Image(mission.image)
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 44, height: 44)

              VStack(alignment: .leading) {
                  Text(mission.displayName)
                      .font(.headline)
                  Text(mission.formattedLaunchDate)
              }
          }
      }
      .navigationBarTitle("Moonshot")
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
