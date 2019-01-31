// For License please refer to LICENSE file in the root of Persei project

import UIKit

open class MenuView: StickyHeaderView {
    
    // MARK: - Init
    override func commonInit() {
        super.commonInit()
        
        if backgroundColor == nil {
            backgroundColor = UIColor(red: 51 / 255, green: 51 / 255, blue: 76 / 255, alpha: 1)
        }
    }
    
    // MARK: - Delegate
    @IBOutlet open weak var delegate: MenuViewDelegate?

    open override func applyContentContainerTransform(_ progress: CGFloat) {
        super.applyContentContainerTransform(progress)
        
        if progress == 0 {
            delegate?.menu(statusChanged: false)
        } else {
            delegate?.menu(statusChanged: true)
        }
    }
}
