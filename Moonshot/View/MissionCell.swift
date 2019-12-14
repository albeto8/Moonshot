//
//  MissionCell.swift
//  Moonshot
//
//  Created by Mario Alberto Barragan Espinosa on 11/7/19.
//  Copyright © 2019 Mario Alberto Barragan Espinosa. All rights reserved.
//

import SwiftUI

struct MissionCell: View {

  let mission: Mission
  let showLaunchDate: Bool

  init(mission: Mission, showLaunchDate: Bool = true) {
    self.mission = mission
    self.showLaunchDate = showLaunchDate
  }

  var detailText: String {
    if self.showLaunchDate {
      return mission.formattedLaunchDate
    }
    var members = "Members: "
    for member in mission.crew {
      members += "\(member.name.capitalized) "
    }
    return members
  }

    var body: some View {
      HStack {
        Image(decorative: mission.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 44, height: 44)

        VStack(alignment: .leading) {
            Text(mission.displayName)
                .font(.headline)
            Text(detailText)
        }
        .accessibilityElement(children: .ignore)
        .accessibility(label: Text("Mission \(mission.displayName) \(self.showLaunchDate ? "Mission date was on" : "Mission crew members were") \(detailText)"))
        Spacer()
      }
    }
}

struct MissionCell_Previews: PreviewProvider {
  static let missions: [Mission] = Bundle.main.decode("missions.json")

    static var previews: some View {
      MissionCell(mission: missions[0])
    }
}
