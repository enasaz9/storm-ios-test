import UIKit
import SDWebImage

class PlacesViewController: UIViewController {
    
    let placesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: "PlaceTableViewCell")
        return tableView
    }()
    
    var placesList: [PlacesModel] = []
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        getPlaces()
    }
    
    func initialSetup() {
        navigationItem.title = "Places"
        
        view.addSubview(placesTableView)
        
        placesTableView.dataSource = self
        placesTableView.delegate = self
        
        // Adding activity indicator and its layout constraint
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // API call to get all the places
    func getPlaces() {
        let placesViewModel = PlacesViewModel()
        activityIndicator.startAnimating()
        
        placesViewModel.getPlaces { response in
            self.activityIndicator.stopAnimating()
            
            if let placesArray = response, !placesArray.isEmpty {
                self.placesList = placesArray
                self.placesTableView.reloadData()
                
            } else {
                var msg = "There's no places, please try again later!"
                
                if response == nil {
                    msg = "Error in server, please try again later!"
                }
                
                let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // Set the tableview frame to the view bounds to be displayed
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        placesTableView.frame = view.bounds
    }
}

extension PlacesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceTableViewCell", for: indexPath) as! PlaceTableViewCell
        cell.nameLabel.text = placesList[indexPath.row].name
        
        // Using SDWebImage to fix the cashing issue with every relaod
        cell.thumbnailImageView.sd_setImage(with: URL.init(string: placesList[indexPath.row].thumbnail), completed: nil)
        
        if (indexPath.row % 2) == 1 {
            cell.backgroundColor = .systemGray5
        } else {
            cell.backgroundColor = .white
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photosVC = PhotosViewController()
        photosVC.selectedPlace = placesList[indexPath.row]
        
        self.navigationController?.pushViewController(photosVC, animated: true)
    }
    
    
}
