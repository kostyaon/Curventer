import Foundation
import UIKit

class TabBarController: UITabBarController{
    // MARK: - Properties
    var currencies: [String] = []
    
    
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
        
        // Setup navbar
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(settingMenu))
        rootVC.navigationItem.title = title
        rootVC.navigationItem.rightBarButtonItem = settingsButton
        
        return navController
    }
    
    
    // MARK: - Helper methods
    @objc func settingMenu() {
        // TODO: Change controllerr
        self.present(SettingsVC(), animated: true, completion: nil)
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: ConvertVC(), title: "Convert", image: UIImage(systemName: "bitcoinsign.square.fill"), largeTitle: false),
            createNavController(for: RatesVC(), title: "Rates", image: UIImage(systemName: "doc.plaintext"), largeTitle: false)
        ]
    }
    
    func pushController(for viewController: UIViewController, to navigationController: UINavigationController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
