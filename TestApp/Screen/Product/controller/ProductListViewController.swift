

import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var productTableView : UITableView!
    
    private var viewModel = ProductViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        configuration()
    }
}


extension ProductListViewController {

    func configuration() {
        initViewModel()
        observeEvent()
    }

    func initViewModel() {
        viewModel.fetchProducts()
    }

    // Data binding event observe karega - communication
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }

            switch event {
            case .loading:
                /// Indicator show
                print("Product loading....")
            case .stopLoading:
                // Indicator hide kardo
                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    // UI Main works well
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }

}

extension ProductListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
}

