//
//  AstronautView.swift
//  Moonshot
//
//  Created by Mario Alberto Barragan Espinosa on 11/6/19.
//  Copyright © 2019 Mario Alberto Barragan Espinosa. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
  let astronaut: Astronaut

  let missions: [Mission] = Bundle.main.decode("missions.json")
  let astronautMissions: [Mission]

  init(astronaut: Astronaut) {
      self.astronaut = astronaut

      var matches = [Mission]()

    for mission in missions {
      if mission.crew.first(where: { $0.name == astronaut.id }) != nil {
        matches.append(mission)
      }
    }
    self.astronautMissions = matches
  }


    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()

                  ForEach(self.astronautMissions, id: \.id) { mission in
                    MissionCell(mission: mission).padding(.horizontal)
                  }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
  static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
