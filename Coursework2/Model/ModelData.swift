import Foundation
import Combine
import Metal

final class ModelData: ObservableObject {
    @Published var forecast: Forecast
    init() {
        self.forecast = load("5dayForecastLondon.json")
    }
    func loadData(lat: Double, lon: Double) {
        let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=524b5c77b1e932342d2a0f31771e2b2d")
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url!) { data, _, err in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            DispatchQueue.main.async {
                do {
                    let forecastData = try JSONDecoder().decode(Forecast.self, from: data!)
                    self.forecast = forecastData
                    print("Forcast loaded")
                    
                } catch {
                    print(error)
                }
            }
        }.resume()
        
    }
}
    

//    load(lat: 51.517063981037964, lon: -0.1431738452133919)
         
    func load<Forecast: Decodable>(_ filename: String) -> Forecast {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Forecast.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Forecast.self):\n\(error)")
        }
}

