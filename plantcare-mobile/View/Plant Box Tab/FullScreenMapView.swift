//
//  FullScreenMapView.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 16.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import SwiftUI
import MapKit

struct FullScreenMapView: View {
    
     @State var plantLocations:[MKPointAnnotation]
    
    var body: some View {
        MapView(locations: $plantLocations)
    }
}

struct FullScreenMapView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenMapView(plantLocations: [MKPointAnnotation]())
    }
}
