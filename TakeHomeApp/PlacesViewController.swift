import UIKit

class PlacesViewController: UIViewController {
    
    let placesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: "PlaceTableViewCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        initialSetup()
        setUpNavigation()
    }
    
    func initialSetup() {
        
        view.addSubview(placesTableView)
        
        placesTableView.dataSource = self
        placesTableView.delegate = self
    }
    
    func setUpNavigation() {
        navigationItem.title = "Places"
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
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceTableViewCell", for: indexPath) as! PlaceTableViewCell
        cell.nameLabel.text = "hello"
        return cell
    }
    
    
}
