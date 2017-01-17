//
//  ViewScroll.swift
//  FashionShop
//
//  Created by techmaster on 1/17/17.
//  Copyright © 2017 techmaster. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var slider: UISlider!
    
    var photo = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgView = UIImageView(image: UIImage(named: "shop1-0.jpg"))
        imgView.frame = CGRect(x: 0.0, y: 0.0, width: imgView.frame.size.width, height: imgView.frame.size.height)
        imgView.contentMode = .scaleAspectFit
        imgView.isUserInteractionEnabled = true
        imgView.isMultipleTouchEnabled = true
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapImg(_:)))
        singleTap.numberOfTapsRequired = 1
        imgView.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapImg(_:)))
        doubleTap.numberOfTapsRequired = 2
        imgView.addGestureRecognizer(doubleTap)
        singleTap.require(toFail: doubleTap)
        
        photo = imgView
        
        scrollView.contentSize = CGSize(width: imgView.bounds.width, height: imgView.bounds.height)
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2.0
        scrollView.addSubview(imgView)
        scrollView.delegate = self
    }
    
    func singleTapImg(_ singleTapGesture: UITapGestureRecognizer) {
        let position = singleTapGesture.location(in: photo)
        zoomRectForScale(scale: scrollView.zoomScale * 2.0, center: position)
        slider.value = Float(slider.value * 2.0)
    }
    
    func doubleTapImg(_ doubleTapGesture: UITapGestureRecognizer) {
        let position = doubleTapGesture.location(in: photo)
        zoomRectForScale(scale: scrollView.zoomScale * 0.5, center: position)
        slider.value = Float(slider.value * 0.5)
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) {
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.width = scrollViewSize.width / scale
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        scrollView.zoom(to: zoomRect, animated: true)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photo
    }

    @IBAction func sliderZoomAction(_ sender: UISlider) {
        scrollView.setZoomScale(CGFloat(sender.value), animated: true)
    }
    
}
