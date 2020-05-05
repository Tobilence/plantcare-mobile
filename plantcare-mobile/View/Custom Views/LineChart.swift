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
    var dataSet: [(x: Double, y: Double)]
    var type: ChartDisplayType
    
    func makeUIView(context: Context) -> LineChartView {
        let lineChartView = LineChartView()
        lineChartView.rightAxis.enabled = false
        lineChartView.tintColor = .black
        lineChartView.drawBordersEnabled = false
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.highlightPerDragEnabled = false
        lineChartView.pinchZoomEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.legend.enabled = false
        
        var values: [String] = []
        switch type {
            case .year:
                values = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
            case .month:
                values = ["1-10", "11-20", "20-30"]
            case .week:
                values = ["Mon", "Tue", "Wed", "Thu", "Fri"]
            case.day:
                values = ["9AM", "12 PM", "3PM", "6PM", "9PM"]
        }
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: values)
        lineChartView.xAxis.granularity = 1
        lineChartView.xAxis.avoidFirstLastClippingEnabled = true
        
        
        var dataEntries:[ChartDataEntry] = []
        for data in dataSet {
            dataEntries.append(ChartDataEntry(x: data.x, y: data.y))
        }
        var dataSet = LineChartDataSet(entries: dataEntries)
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.highlightEnabled = false
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 2
        dataSet.highlightColor = .black
        dataSet.colors = [UIColor.black]
        print("In make: \(dataSet.entries.count)")
        
        lineChartView.data = LineChartData(dataSet: dataSet)
        return lineChartView
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        var dataEntries:[ChartDataEntry] = []
        for data in dataSet {
            dataEntries.append(ChartDataEntry(x: data.x, y: data.y))
        }
        var dataSet = LineChartDataSet(entries: dataEntries)
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.highlightEnabled = false
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 2
        dataSet.highlightColor = context.environment.colorScheme == .dark ? .green : .black
        dataSet.colors = [context.environment.colorScheme == .dark ? .green : .black]
        uiView.data = LineChartData(dataSet: dataSet)
        
        
        var values: [String] = []
        switch type {
            case .year:
                values = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
            case .month:
                values = ["1st", "5th", "10th", "15th", "20th", "25th", "30th"]
            case .week:
                values = ["Mon", "Tue", "Wed", "Thu", "Fri"]
            case.day:
                values = ["3AM", "6AM", "9AM", "12 PM", "3PM", "6PM", "9PM", "12AM"]
        }
        uiView.xAxis.valueFormatter = IndexAxisValueFormatter(values: values)
        uiView.xAxis.granularity = 1
        uiView.xAxis.avoidFirstLastClippingEnabled = true
    }
}

enum ChartDisplayType: Int {
    case year = 3
    case month = 2
    case week = 1
    case day = 0
}
