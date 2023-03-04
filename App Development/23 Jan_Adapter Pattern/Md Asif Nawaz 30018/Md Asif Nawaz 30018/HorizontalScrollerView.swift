//
//  HorizontalScrollerView.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 23/1/23.
//

import UIKit

protocol HorizontalScrollerViewDataSource : AnyObject {
    func numberOfViews (in horizontalScrollerView : HorizontalScrollerView) -> Int
    func horizontalScrollerView (_ horizontalScrollerView : HorizontalScrollerView, viewAt index : Int) -> UIView
}
protocol HorizontalScrollerViewDelegate : AnyObject {
    func horizontalScrollerView (_ horizontalScrollerView : HorizontalScrollerView, didSelectViewAt index : Int) -> UIView
}

class HorizontalScrollerView: UIView {
    
    weak var dataSource : HorizontalScrollerViewDataSource?
    weak var delegate : HorizontalScrollerViewDelegate?
    
    private enum ViewConstants {
        static let Padding : CGFloat =  100
        static let Dimension : CGFloat = 100
        static let Offset: CGFloat = 100
    }
    private let scroller = UIScrollView()
    private var contentViews = [UIView]()
    
    func scrollToView(at index: Int, animated: Bool = true) {
        let centralView = contentViews[index]
        let targetCenter = centralView.center
        let targetOffsetX = targetCenter.x - (scroller.bounds.width / 2)
        scroller.setContentOffset(CGPoint (x: targetOffsetX, y: 0), animated: animated)
    }
    
    @objc func scrollerTapped(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: scroller)
        guard let index = contentViews.firstIndex(where: { $0.frame.contains(location)}) else {return }
        delegate?.horizontalScrollerView(self, didSelectViewAt: index)
        scrollToView(at: index)
    }
    func view (at index : Int) -> UIView {
        return contentViews[index]
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
