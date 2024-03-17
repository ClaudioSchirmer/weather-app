//
//  ViewController.swift
//  lab3
//
//  Created by Cláudio Schirmer Guedes on 2024-03-14.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherConditionImage: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationLabelError: UILabel!
    @IBOutlet weak var switchMetrics: UISwitch!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var measurementsLabel: UILabel!
    
    private let locationManager = CLLocationManager()
    private var temperatureCelsius: Float = 0.0
    private var temperatureFahrenheit: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        locationManager.delegate = self
        locationLabelError.isHidden = true
        weatherCondition.isHidden = true
        locationLabel.isHidden = true
        switchMetrics.isHidden = true
        temperatureLabel.isHidden = true
        measurementsLabel.isHidden = true
    }
    
    @IBAction func onLocationTapped(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @IBAction func onSearchTapped(_ sender: UIButton) {
        executeGetWeatherQuery(location: searchTextField.text)
    }
    
    @IBAction func switchMetricsTapped(_ sender: UISwitch) {
        showTemperature()
    }
    
    private func executeGetWeatherQuery(location: String?) {
        searchTextField.text = ""
        locationLabelError.isHidden = true
        
        Task { @MainActor in
            let result = await Pipeline.dispatch(query: GetWeatherQuery(location: location))
            switch result {
            case let sucess as PipelineResultSuccess<GetWeatherQuery>:
                let weatherDTO = sucess.result
                
                weatherCondition.isHidden = false
                locationLabel.isHidden = false
                switchMetrics.isHidden = false
                temperatureLabel.isHidden = false
                measurementsLabel.isHidden = false
                
                temperatureCelsius = weatherDTO.current.temp_c
                temperatureFahrenheit = weatherDTO.current.temp_f
                locationLabel.text = weatherDTO.location.name
                weatherCondition.text = weatherDTO.current.condition.text
                
                showTemperature()
                
                let config = UIImage.SymbolConfiguration(paletteColors: [
                    .systemTeal, .systemIndigo, .systemIndigo
                ])
                
                let symbolName = weatherDTO.current.condition.code.getSymbol(isDay: weatherDTO.current.is_day == 1)
                weatherConditionImage.image = UIImage(systemName: symbolName, withConfiguration: config)
                
            case let notification as PipelineResultNotification:
                let notificationDTO = notification.notificationDTO
                
                if let genericMessage = notificationDTO.getGenericMessages().first {
                    showAlert(title: "Error", message: genericMessage)
                }
                
                if let fieldLocationError = notificationDTO.getMessagesFor(field: "location").first {
                    locationLabelError.text = fieldLocationError
                    locationLabelError.isHidden = false
                }
            case let error as PipelineResultError:
                showAlert(title: "Error", message: error.error as? String ?? "Unknown error.")
            default:
                break
            }
        }
    }
    
    private func showTemperature() {
        let measurement: Measurement = if (switchMetrics.isOn) {
            Measurement(value: Double(temperatureCelsius) , unit: UnitTemperature.celsius)
        } else {
            Measurement(value: Double(temperatureFahrenheit) , unit: UnitTemperature.fahrenheit)
        }
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .medium
        measurementFormatter.numberFormatter.maximumFractionDigits = 1
        measurementFormatter.unitOptions = .providedUnit
        temperatureLabel.text = measurementFormatter.string(from: measurement)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okButton)
        self.show(alert, sender: nil)
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        executeGetWeatherQuery(location: textField.text)
        return true
    }
}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            executeGetWeatherQuery(location: "\(lat),\(lon)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if manager.authorizationStatus != .authorizedAlways && manager.authorizationStatus != .authorizedWhenInUse {
            showAlert(title: "GPS", message: "Please allow this app to access your location.")
        }
    }
}
