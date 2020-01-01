//
//  MissionView.swift
//  Moonshot
//
//  Created by Mario Alberto Barragan Espinosa on 11/6/19.
//  Copyright © 2019 Mario Alberto Barragan Espinosa. All rights reserved.
//

import SwiftUI

struct MissionView: View {

  struct CrewMember {
      let role: String
      let astronaut: Astronaut
  }

  let mission: Mission
  let astronauts: [CrewMember]
    
    func renderScaleEffect(_ geoRect: CGRect, _ fullRect: CGRect) -> CGFloat {
        let finalScale = geoRect.midY / fullRect.midY * 2
        if finalScale < 0.8 {
            return 0.8
        }
        return finalScale
    }

  init(mission: Mission, astronauts: [Astronaut]) {
      self.mission = mission

      var matches = [CrewMember]()

      for member in mission.crew {
          if let match = astronauts.first(where: { $0.id == member.name }) {
              matches.append(CrewMember(role: member.role, astronaut: match))
          } else {
              fatalError("Missing \(member)")
          }
      }

      self.astronauts = matches
  }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { geo in
                        Image(decorative: self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .padding(.top)
                            .frame(width: geo.size.width, height: geo.size.height)
                            .scaleEffect(self.renderScaleEffect(geo.frame(in: .global), geometry.frame(in: .global)))
                        .onTapGesture {
                            print("Global geo center: maxY \(geo.frame(in: .global).maxY) minY \(geo.frame(in: .global).minY) midY: \(geo.frame(in: .global).midY)")
                            print("Global geometry center: maxY \(geometry.frame(in: .global).maxY) minY \(geometry.frame(in: .global).minY) midY: \(geometry.frame(in: .global).midY)")
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.4)
                  Text(self.mission.formattedLaunchDate)
                    .accessibility(label: Text("Mission date was on: \(self.mission.formattedLaunchDate)"))
                    .padding()

                    Text(self.mission.description)
                        .padding()

                  ForEach(self.astronauts, id: \.role) { crewMember in
                    NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                      HStack {
                         Image(decorative: crewMember.astronaut.id)
                              .resizable()
                              .frame(width: 83, height: 60)
                              .clipShape(Circle())
                              .overlay(Circle().stroke(Color.primary, lineWidth: 1))

                          VStack(alignment: .leading) {
                              Text(crewMember.astronaut.name)
                                  .font(.headline)
                              Text(crewMember.role)
                                  .foregroundColor(.secondary)
                          }
                        .accessibilityElement(children: .ignore)
                        .accessibility(label: Text("Astronaut name is \(crewMember.astronaut.name) his role was \(crewMember.role)"))

                          Spacer()
                      }
                      .padding(.horizontal)
                    }
                    .buttonStyle(PlainButtonStyle())
                  }
                  
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}

struct MissionView_Previews: PreviewProvider {
  static let missions: [Mission] = Bundle.main.decode("missions.json")
  static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
