//
//  Chart.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 22.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation
import SwiftUI
import Charts
import UIKit

struct LineChart: UIViewRepresentable {
    
    typealias UIViewType = LineChartView
    
    func makeUIView(context: Context) -> LineChartView {
        let lineChartView = LineChartView()
        lineChartView.backgroundColor = .red
        lineChartView.rightAxis.enabled = false
        return lineChartView
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        //empty
    }
}
