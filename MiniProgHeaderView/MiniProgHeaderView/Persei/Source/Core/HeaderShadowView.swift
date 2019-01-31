// For License please refer to LICENSE file in the root of Persei project
import UIKit

class HeaderShadowView : UIView {
    
    var dotColor: UIColor?
    var backColor: UIColor?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.dotColor = UIColor.red
        self.backColor = UIColor.clear
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //初始化几个点
    func setupUI() {
        self.backgroundColor = self.backColor
        self.dotViewLeft.backgroundColor = self.dotColor
        self.dotViewCenter.backgroundColor = self.dotColor
        self.dotViewRight.backgroundColor = self.dotColor
        self.addSubview(self.dotViewLeft)
        self.addSubview(self.dotViewRight)
        self.addSubview(self.dotViewCenter)
        //注意要让中间点在最上面,
    }
    
    func updateAnimationWithOffsetY(_ offsetY: CGFloat) {
        
        let startCentterHeight: CGFloat = 10.0//拖动到多高后,中心点将保持Y方向居中
        let maxCenterHeight: CGFloat = 54//拖动到多高以后,中心点将不再保持Y方向居中, 而是跟随view下移
        var dotCenterY: CGFloat = 0//点的Y中心
        var centerDotWidth: CGFloat = 0//中心点的宽度
        let maxCenterDotWidth: CGFloat = 10.0//中心点最大宽度
        var centerDotAlpha: CGFloat = 0.0//中心点的不透明度
        let centerDotStartAlpha: CGFloat = 0.0//中心点初始不透明度
        let sideDotWidth: CGFloat = 6.0//旁边点的宽度
        var sideDotOffsetX: CGFloat = 0//旁边点相对中心点的距离
        var sideDotAlpha: CGFloat = 1.0//旁边点的不透明度
        let maxSideDotOffsetX: CGFloat = 25.0//旁边点X方向最大偏移长度
        let maxSideDotOffsetHeight: CGFloat = 60.0//拖动到多高后, 旁边点X方向上偏移达到最大
        
        if offsetY < maxCenterHeight {
            if offsetY < startCentterHeight {
                centerDotWidth = offsetY/startCentterHeight*maxCenterDotWidth
                centerDotAlpha = centerDotStartAlpha+offsetY/startCentterHeight*(1.0-centerDotStartAlpha)
                sideDotAlpha = 0.0
            } else {
                centerDotAlpha = 1.0
                sideDotAlpha = 1.0
                if offsetY < maxSideDotOffsetHeight {
                    sideDotOffsetX = (maxSideDotOffsetX-2.0)*(offsetY-startCentterHeight)/(maxSideDotOffsetHeight-startCentterHeight)+2.0
                    centerDotWidth = maxCenterDotWidth-(maxCenterDotWidth-sideDotWidth)*(offsetY-startCentterHeight)/(maxSideDotOffsetHeight-startCentterHeight)
                } else {
                    sideDotOffsetX = maxSideDotOffsetX
                    centerDotWidth = sideDotWidth
                    
                }
            }
        } else {
            
            centerDotWidth = sideDotWidth
            sideDotOffsetX = maxSideDotOffsetX
            centerDotAlpha = 1.0
        }
        
        dotCenterY = self.bounds.size.height-centerDotWidth-startCentterHeight

        self.dotViewCenter.frame = CGRect.init(x: self.bounds.size.width/2.0-centerDotWidth/2.0, y: dotCenterY, width: centerDotWidth, height: centerDotWidth)
        self.dotViewCenter.layer.cornerRadius = centerDotWidth/2.0
        self.dotViewCenter.alpha = centerDotAlpha
        self.dotViewLeft.frame = CGRect.init(x: self.bounds.size.width/2.0-sideDotOffsetX,  y: dotCenterY+(centerDotWidth-sideDotWidth)/2.0, width:sideDotWidth, height:sideDotWidth)
        self.dotViewLeft.alpha = sideDotAlpha
        self.dotViewLeft.layer.cornerRadius = sideDotWidth/2.0
        self.dotViewRight.frame = CGRect.init(x: self.bounds.size.width/2.0+sideDotOffsetX-sideDotWidth,  y: dotCenterY+(centerDotWidth-sideDotWidth)/2.0, width:sideDotWidth, height:sideDotWidth)
        self.dotViewRight.alpha = sideDotAlpha
        self.dotViewRight.layer.cornerRadius = sideDotWidth/2.0
    }
    
    private let dotViewLeft: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true

        return view
    }()
    
    private let dotViewCenter: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        
        return view
    }()

    private let dotViewRight: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        
        return view
    }()
}

