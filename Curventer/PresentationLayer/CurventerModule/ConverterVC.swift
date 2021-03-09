import Foundation
import UIKit

class ConverterVC: UIViewController {
    // MARK: - View lifecycle methods
    override func loadView() {
        let conventerView = ConverterView()
        self.view = conventerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
