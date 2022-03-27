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
        
        view.backgroundColor = .red
        initialSetup()
        setUpNavigation()
        getPlaces()
    }
    
    func initialSetup() {
        
        view.addSubview(placesTableView)
        
        placesTableView.dataSource = self
        placesTableView.delegate = self
        
        activityIndicator = UIActivityIndicatorView(style: .large)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setUpNavigation() {
        navigationItem.title = "Places"
    }
    
    func getPlaces() {
        let placesViewModel = PlacesViewModel()
        
        activityIndicator.startAnimating()
        placesViewModel.getPlaces { response in
            self.activityIndicator.stopAnimating()
            
            if let placesArray = response, !placesArray.isEmpty {
                self.placesList = placesArray
                self.placesTableView.reloadData()
                
            } else {
                print("error or empty")
            }
        }
    }
    
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
        cell.thumbnailImageView.sd_setImage(with: URL.init(string: placesList[indexPath.row].thumbnail), completed: nil)
        
        return cell
    }
    
    
}
