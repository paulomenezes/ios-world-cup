//
//  MapViewController.swift
//  CampeosDasCopas
//
//  Created by Paulo Menezes on 24/07/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, UIActionSheetDelegate {
    var countriesData: [String: (MapResult, [WorldCup])] = [:]
    var worldCups: [WorldCup] = []
    var requestCount = 0
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        loadWorldCups()
        
        for worldCup in worldCups {
            requestInfo(worldCup: worldCup)
        }
    }
    
    func loadWorldCups() {
        let fileURL = Bundle.main.url(forResource: "winners", withExtension: ".json")!
        let jsonData = try! Data(contentsOf: fileURL)

        do {
          worldCups = try JSONDecoder().decode([WorldCup].self, from: jsonData)
        } catch  {
          print(error.localizedDescription)
        }
    }
    
    func zoomAllAnnotations() {
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    
    func addAnnotation(mapResult: MapResult, title: String, subtitle: String) {
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: mapResult.geometry.lat, longitude: mapResult.geometry.lng)
        annotation.coordinate = centerCoordinate
        annotation.title = title
        annotation.subtitle = subtitle
        
        self.mapView.addAnnotation(annotation)
    }
    
    func requestInfo(worldCup: WorldCup) {
        let worldCupCountry = worldCup.country.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = URL(string: "https://api.opencagedata.com/geocode/v1/json?q=\(worldCupCountry!)&key=b3429adb17d0473e87560fd643848746")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
           
            do {
                let position = try JSONDecoder().decode(Map.self, from: data)
                
                if position.results.count > 0 {
                    DispatchQueue.main.async {
                        self.requestCount += 1
                       
                        if self.countriesData[worldCup.country] != nil {
                            self.countriesData[worldCup.country]?.1.append(worldCup)
                        } else {
                            self.countriesData[worldCup.country] = (position.results[0], [worldCup])
                        }
                        
                        if self.requestCount == self.worldCups.count {
                            for item in self.countriesData {
                                let data = item.value.1.map({ worldCup in String(worldCup.year) }).joined(separator: ", ")
                                
                                self.addAnnotation(mapResult: item.value.0, title: item.value.1[0].country, subtitle: data)
                                self.zoomAllAnnotations()
                            }
                            print(self.requestCount)
                        }
                    }
                }
            } catch  {
              print(error.localizedDescription)
            }
        }

        task.resume()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "WorldCup"
        
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
          dequeuedView.annotation = annotation
          view = dequeuedView
        } else {
          view = MKMarkerAnnotationView(
            annotation: annotation,
            reuseIdentifier: identifier
          )
            
          view.canShowCallout = true
          view.calloutOffset = CGPoint(x: -5, y: 5)
          view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let worldCupViewController = storyBoard.instantiateViewController(withIdentifier: "WorldCupViewController") as! WorldCupViewController

        if let country = view.annotation?.title {
            let data = countriesData[country!]
            
            if let items = data?.1 {
                if items.count > 1 {
                    let actionSheetControllerIOS8: UIAlertController = UIAlertController(
                        title: data?.1[0].country,
                        message: "Selecione o ano",
                        preferredStyle: .actionSheet
                    )

                    actionSheetControllerIOS8.addAction(UIAlertAction(title: "Cancelar", style: .cancel) { _ in
                        print("Cancel")
                    })
                    
                    for worldCup in items {
                        actionSheetControllerIOS8.addAction(UIAlertAction(title: String(worldCup.year), style: .default) { _ in
                            worldCupViewController.worldCup = worldCup
                            self.navigationController?.pushViewController(worldCupViewController, animated: true)
                        })
                    }
                    
                    self.present(actionSheetControllerIOS8, animated: true, completion: nil)
                } else {
                    worldCupViewController.worldCup = data?.1[0]
                    self.navigationController?.pushViewController(worldCupViewController, animated: true)
                }
            }
        }
    }
}
