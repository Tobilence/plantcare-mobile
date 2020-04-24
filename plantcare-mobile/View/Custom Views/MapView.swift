//
//  MapView.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 16.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

///a map view that places all plant boxes as
struct MapView: UIViewRepresentable {
    
    @Binding var locations:[MKPointAnnotation]
    var mainPlantBox:String?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.addAnnotations(locations)
        var centerCoordinate: CLLocationCoordinate2D = locations[0].coordinate
        if let main = mainPlantBox {
            let filteredLocations = locations.filter {$0.title == main}
            if filteredLocations.count > 0 {
                centerCoordinate = filteredLocations[0].coordinate
            }
        }
        let span = MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4)
        mapView.setCenter(centerCoordinate, animated: true)
        mapView.setRegion(MKCoordinateRegion(center: centerCoordinate, span: span), animated: true)
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator{
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate{
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        private func mapView(_ mapView: MKMapView, viewFor annotation: MKPointAnnotation) -> MKAnnotationView? {
            let identifier = "plantbox"
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }
    }
}
