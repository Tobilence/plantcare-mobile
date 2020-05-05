//
//  MockData.swift
//  plantcare-mobile
//
//  Created by Tobias Furtlehner on 30.04.20.
//  Copyright © 2020 Tobias Furtlehner. All rights reserved.
//

import Foundation

struct MockData {
    
    func sampleData(sampleType: SensorType, displayRange: ChartDisplayType) -> [(x: Double, y: Double)] {
        switch displayRange {
            case .day:
                return day(sampleType: sampleType)
            case .week:
                return week(sampleType: sampleType)
            case .month:
                return month(sampleType: sampleType)
            case .year:
                return year(sampleType: sampleType)
        }
    }
    
    private func day(sampleType: SensorType) -> [(x: Double, y: Double)] {
        
        var data: [(x: Double, y: Double)] = []
        switch sampleType {
            case .airPressure:
                data.append((x: 1, y: 12.5))
                data.append((x: 2, y: 11))
                data.append((x: 3, y: 13))
                data.append((x: 4, y: 12))
                data.append((x: 5, y: 11.5))
                data.append((x: 6, y: 11))
                data.append((x: 7, y: 12))
                data.append((x: 8, y: 11.5))
            case .groundHumidity:
                data.append((x: 1, y: 40))
                data.append((x: 2, y: 42.5))
                data.append((x: 3, y: 70))
                data.append((x: 4, y: 55))
                data.append((x: 5, y: 47))
                data.append((x: 6, y: 45))
                data.append((x: 7, y: 43))
                data.append((x: 8, y: 42))
            case .light:
                data.append((x: 0, y: 25))
                data.append((x: 1, y: 30))
                data.append((x: 2, y: 35))
                data.append((x: 3, y: 20))
                data.append((x: 4, y: 45))
                data.append((x: 5, y: 45))
                data.append((x: 6, y: 35))
                data.append((x: 7, y: 35))
            case .temperature:
                data.append((x: 0, y: 10))
                data.append((x: 1, y: 16))
                data.append((x: 2, y: 17))
                data.append((x: 3, y: 20))
                data.append((x: 4, y: 20))
                data.append((x: 5, y: 17))
                data.append((x: 6, y: 14))
                data.append((x: 7, y: 12))
                data.append((x: 7, y: 11))
        }
        return data
    }
    
    private func week(sampleType: SensorType) -> [(x: Double, y: Double)] {

        var data: [(x: Double, y: Double)] = []
        switch sampleType {
            case .airPressure:
                data.append((x: 0, y: 12.4))
                data.append((x: 1, y: 13.2))
                data.append((x: 2, y: 12.6))
                data.append((x: 3, y: 12.5))
                data.append((x: 4, y: 11.8))
                data.append((x: 5, y: 13.3))
                data.append((x: 6, y: 12.1))
                data.append((x: 7, y: 11.5))
            case .groundHumidity:
                data.append((x: 0, y: 50))
                data.append((x: 1, y: 48))
                data.append((x: 2, y: 53))
                data.append((x: 3, y: 32))
                data.append((x: 4, y: 45))
                data.append((x: 5, y: 48))
                data.append((x: 6, y: 46))
                data.append((x: 7, y: 54))
            case .light:
                data.append((x: 0, y: 25))
                data.append((x: 1, y: 25))
                data.append((x: 2, y: 50))
                data.append((x: 3, y: 30))
                data.append((x: 4, y: 35))
                data.append((x: 5, y: 40))
                data.append((x: 6, y: 45))
                data.append((x: 7, y: 35))
            case .temperature:
                data.append((x: 0, y: 17))
                data.append((x: 1, y: 15))
                data.append((x: 2, y: 16))
                data.append((x: 3, y: 16))
                data.append((x: 4, y: 20))
                data.append((x: 5, y: 19))
                data.append((x: 6, y: 22))
                data.append((x: 7, y: 18))
        }
        return data
    }
    
    private func month(sampleType: SensorType) -> [(x: Double, y: Double)] {
        
        var data: [(x: Double, y: Double)] = []
        switch sampleType {
            case .airPressure:
                data.append((x: 0, y: 20))
                data.append((x: 1, y: 16))
                data.append((x: 2, y: 14))
                data.append((x: 3, y: 15))
                data.append((x: 4, y: 18))
                data.append((x: 5, y: 20))
                data.append((x: 6, y: 19))
                data.append((x: 7, y: 19.5))
            case .groundHumidity:
                data.append((x: 0, y: 40))
                data.append((x: 1, y: 45))
                data.append((x: 2, y: 42.5))
                data.append((x: 3, y: 45))
                data.append((x: 4, y: 47))
                data.append((x: 5, y: 50))
                data.append((x: 6, y: 43))
                data.append((x: 7, y: 47))
            case .light:
                data.append((x: 0, y: 40))
                data.append((x: 1, y: 50))
                data.append((x: 2, y: 45))
                data.append((x: 3, y: 43))
                data.append((x: 4, y: 38))
                data.append((x: 5, y: 48))
                data.append((x: 6, y: 45))
                data.append((x: 7, y: 44))
            case .temperature:
                data.append((x: 0, y: 20))
                data.append((x: 1, y: 23))
                data.append((x: 2, y: 22))
                data.append((x: 3, y: 18.4))
                data.append((x: 4, y: 20))
                data.append((x: 5, y: 16))
                data.append((x: 6, y: 18))
                data.append((x: 7, y: 14))
        }
        return data
    }
    
    private func year(sampleType: SensorType) -> [(x: Double, y: Double)] {
        
        var data: [(x: Double, y: Double)] = []
        switch sampleType {
            case .airPressure:
                data.append((x: 0, y: 12.8))
                data.append((x: 1, y: 15.1))
                data.append((x: 2, y: 13.2))
                data.append((x: 3, y: 14))
                data.append((x: 4, y: 12))
                data.append((x: 5, y: 13))
                data.append((x: 6, y: 12.5))
                data.append((x: 7, y: 13.4))
                data.append((x: 8, y: 12.9))
                data.append((x: 9, y: 14))
                data.append((x: 10, y: 15))
                data.append((x: 11, y: 14.5))
            case .groundHumidity:
                data.append((x: 0, y: 50))
                data.append((x: 1, y: 45))
                data.append((x: 2, y: 55))
                data.append((x: 3, y: 52))
                data.append((x: 4, y: 54))
                data.append((x: 5, y: 60))
                data.append((x: 6, y: 57.3))
                data.append((x: 7, y: 64))
                data.append((x: 8, y: 48))
                data.append((x: 9, y: 52))
                data.append((x: 10, y: 54))
                data.append((x: 11, y: 47.5))
            case .light:
                data.append((x: 0, y: 40))
                data.append((x: 1, y: 38))
                data.append((x: 2, y: 44))
                data.append((x: 3, y: 43))
                data.append((x: 4, y: 50))
                data.append((x: 5, y: 46))
                data.append((x: 6, y: 57.3))
                data.append((x: 7, y: 52))
                data.append((x: 8, y: 48))
                data.append((x: 9, y: 44))
                data.append((x: 10, y: 49))
                data.append((x: 11, y: 47.5))
            case .temperature:
                data.append((x: 0, y: 5))
                data.append((x: 1, y: 6))
                data.append((x: 2, y: 10))
                data.append((x: 3, y: 18))
                data.append((x: 4, y: 20))
                data.append((x: 5, y: 33))
                data.append((x: 6, y: 28))
                data.append((x: 7, y: 22))
                data.append((x: 8, y: 14))
                data.append((x: 9, y: 6))
                data.append((x: 10, y: 2))
                data.append((x: 11, y: -1))
        }
        return data
    }
}
