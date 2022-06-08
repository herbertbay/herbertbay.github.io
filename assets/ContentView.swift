//
//  ContentView.swift
//  audioweather
//
//  Created by Herbert on 08.06.2022.
//

import SwiftUI
import WeatherKit
import CoreLocation

class WeatherState: ObservableObject {
    @Published var temperature: Double? = 0.0

    @MainActor
    func getWeather() async {
        let weatherService = WeatherService()
        let location = CLLocation(latitude: 47, longitude: 11)
        
        let weather = try? await weatherService.weather(for: location)
        let localTemperature = weather?.currentWeather.temperature
        temperature = localTemperature?.value
    }
}

struct ContentView: View {
    @StateObject var weatherState = WeatherState()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text("\(weatherState.temperature ?? 0)")
        }
        .task {
            await weatherState.getWeather()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
