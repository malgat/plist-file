import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    var mks = [MKPointAnnotation]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        //MapType 설정
        //mapView.mapType = MKMapType.satellite
        //mapView.mapType = MKMapType.hybrid
        //mapView.mapType = MKMapType.standard
        
        // DIT 위도 경도 설정.
        let location = CLLocationCoordinate2D(latitude: 35.165005, longitude: 129.071484)
        
        //반경 설정
        //let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.01)
       
        //regin 설정
        //MKCoordinateSapn 을 쓸 경우 밑에 것 쓸 것
        //let region = MKCoordinateRegion(center: location, span: span)
        
        //let region = MKCoordinateRegion(center : location, latitudinalMeters : 100, longitudinalMeters: 100)
        
        //mapView에 add
        //mapView.setRegion(region, animated: true)
        
        //pin 꼽기
        let mk01 = MKPointAnnotation()
        mk01.coordinate = location
        mk01.title = "동의과학대학교"
        mk01.subtitle = "We are DIT"
        //mapView.addAnnotation(mk01)
        mks.append(mk01)
        
        let mk02 = MKPointAnnotation()
        mk02.coordinate.latitude = 35.168380
        mk02.coordinate.longitude = 129.057845
        mk02.title = "부산시민공원"
        mk02.subtitle = "부산시민공원"
        //mapView.addAnnotation(mk02)
        mks.append(mk02)
        
        let mk03 = MKPointAnnotation()
        mk03.coordinate.latitude = 35.147884
        mk03.coordinate.longitude = 129.130048
        mk03.title = "광안대교"
        mk03.subtitle = "부산의 랜드마크"
        //mapView.addAnnotation(mk03)
        mks.append(mk03)
        
        let mk04 = MKPointAnnotation()
        mk04.coordinate.latitude = 35.071969
        mk04.coordinate.longitude = 129.057528
        mk04.title = "영도 목장원"
        mk04.subtitle = "부산의 랜드마크"
        //mapView.addAnnotation(mk03)
        mks.append(mk04)
        
        //반경 지정 없이 모든 핀을 화면 내에 나타나게 함.
        //mapView.showAnnotations([mk01,mk02,mk03,mk04], animated: true)
        mapView.showAnnotations(mks, animated: true)
    }
    
    @IBAction func satellite(_ sender: Any) {
        mapView.mapType = MKMapType.satellite
    }
    @IBAction func hybrid(_ sender: Any) {
        mapView.mapType = MKMapType.hybrid
    }
    @IBAction func standard(_ sender: Any) {
        mapView.mapType = MKMapType.standard
    }
    
    //MKMapViewDelegate => 핀이 4개이기 때문에 4번 실행.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //pin의 재활용
        let identifier = "RE"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            
            //오른쪽버튼
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            
            //왼쪽그림
            //let imgV = UIImageView(image: UIImage(named : "p1.jpeg")
  
            annotationView?.animatesDrop = true
 
        } else {
            annotationView!.annotation = annotation
        }
        
        var imgV = UIImageView()
        
        if annotation.title! == "동의과학대학교"{
            annotationView?.pinTintColor = UIColor.brown
            imgV = UIImageView(image: UIImage(named : "p1.jpeg"))
        } else if annotation.title! == "부산시민공원"{
            annotationView?.pinTintColor = UIColor.blue
            imgV = UIImageView(image: UIImage(named : "p2.jpeg"))
        } else if annotation.title! == "광안대교"{
            annotationView?.pinTintColor = UIColor.black
            imgV = UIImageView(image: UIImage(named : "p3.jpeg"))
        } else if annotation.title! == "영도 목장원"{
            annotationView?.pinTintColor = UIColor.white
            imgV = UIImageView(image: UIImage(named : "p4.jpeg"))
            
        }
        imgV.frame = CGRect(x:0, y:0, width:30, height: 30)
        annotationView?.leftCalloutAccessoryView = imgV
        
        
        return annotationView
    }
    
    func mapView(_ _mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped contol: UIControl) {
        
        print("call");
        
        let alert = UIAlertController(title: view.annotation?.title!, message: view.annotation?.subtitle!, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: false)
        
    }
    
    
}

