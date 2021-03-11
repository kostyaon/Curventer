import Foundation
import UIKit

class TabBarController: UITabBarController{
    // MARK: - View lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupVCs()
    }
    
    
    // MARK: - Private methods
    private func setupTabBar() {
        tabBar.tintColor = .label
        UITabBar.appearance().tintColor = .systemGreen
    }
    
    private func createNavController(for rootVC: UIViewController, title: String, image: UIImage?, largeTitle: Bool) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootVC)
        
        // Setup navController
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = largeTitle
        rootVC.navigationItem.title = title
        
        return navController
    }
    
    
    // MARK: - Helper methods
    func setupVCs() {
        viewControllers = [
            createNavController(for: ConverterVC(), title: "Converter", image: UIImage(systemName: "function"), largeTitle: false),
            createNavController(for: RatesVC(), title: "Rates", image: UIImage(systemName: "doc.plaintext"), largeTitle: true),
            createNavController(for: ConvertVC(), title: "Convert", image: UIImage(systemName: "bitcoinsign.square.fill"), largeTitle: false)
        ]
    }
    
    func pushController(for viewController: UIViewController, to navigationController: UINavigationController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
