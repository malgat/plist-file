import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    var mks = [MKAnnotation]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.mapType = MKMapType.standard
        
        mapView.delegate = self
        
        //plist 화일 불러오기
        let path = Bundle.main.path(forResource: "myData", ofType: "plist")
        print(path!)
        
        //화일 내용 하기
        let contents = NSArray(contentsOfFile: path!)
        print(contents!)
        
        //화일 내용 처리
        //optional binding
        if let myItem = contents{
            
            for item in myItem {
                let lat = (item as AnyObject).value(forKey: "lat")
                let long = (item as AnyObject).value(forKey: "long")
                let title = (item as AnyObject).value(forKey: "title")
                let subtitle = (item as AnyObject).value(forKey: "subtitle")
                
                print(lat!)
                print(long!)
                print(title!)
                print(subtitle!)
                
                //위도, 경도 double로 형변환
                let myLat = (lat as! NSString).doubleValue
                let myLng = (long as! NSString).doubleValue
                
                let pin = MKPointAnnotation()
                pin.coordinate.latitude = myLat
                pin.coordinate.longitude = myLng
                pin.title = title as? String
                pin.subtitle = subtitle as? String
                
                //pins 배열에 append
                mks.append(pin)
            }
        } else {
            print("nil 발생")
        }
        
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
        let alert = UIAlertController(title: view.annotation?.title!, message: view.annotation?.subtitle!, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: false)
    }
}

