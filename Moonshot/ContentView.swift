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
        Text("\(astronauts.count)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
