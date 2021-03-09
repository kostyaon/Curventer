import Foundation
import UIKit

class TabBar: UITabBarController{
    // MARK: - Navigation controllers
    lazy var nav1: UINavigationController = {
        return createNavController(for: RatesVC(), title: "Rates", image: UIImage(systemName: "doc.plaintext"))
    }()
    
    lazy var nav2: UINavigationController = {
        return createNavController(for: ConverterVC(), title: "Converter", image: UIImage(systemName: "function"))
    }()
    
    
    // MARK: - View lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupVCs()
    }
    
    
    // MARK: - Private methods
    private func setupTabBar() {
        tabBar.tintColor = .label
        UITabBar.appearance().tintColor = .systemGreen
    }
    
    private func createNavController(for rootVC: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootVC)
        
        // Setup navController
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootVC.navigationItem.title = title
        
        return navController
    }
    
    
    // MARK: - Helper methods
    func setupVCs() {
        viewControllers = [nav1, nav2]
    }
    
    func pushController(for viewController: UIViewController, to navigationController: UINavigationController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
