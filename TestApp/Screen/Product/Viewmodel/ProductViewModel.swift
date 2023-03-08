
import Foundation

final class ProductViewModel {

    var products: [Product] = []
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure

    func fetchProducts() {
        self.eventHandler?(.loading)
        APIManager.shared.request(
            modelType: [Product].self,
            type: ProductEndPoint.products) { response in
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let products):
                    self.products = products
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
}

extension ProductViewModel {

    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }

}
