//
//  ChatExample.swift
//  Angel Hack
//
//  Created by Jonathan Velazquez on 07/05/16.
//  Copyright © 2016 Julio Guzman. All rights reserved.
//

import UIKit
import BEMSimpleLineGraph
import LTMorphingLabel

let offset_HeaderStop:CGFloat = 40.0
let offset_B_LabelHeader:CGFloat = 95.0
let distance_W_LabelHeader:CGFloat = 35.0


class ProfileController: UIViewController,BEMSimpleLineGraphDataSource,BEMSimpleLineGraphDelegate,UIScrollViewDelegate {

    
    @IBOutlet weak var chart: BEMSimpleLineGraphView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var avatarImage: AvatarImageView!
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet var headerImageView:UIImageView!
    @IBOutlet var headerBlurImageView:UIImageView!
    var blurredHeaderImageView:UIImageView?
    
    var workSalaries:[CGFloat] = [0,10000,0]
    var xAxisLabel = ["10,000","20,000","10,000"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        graphConfig()
        scrollConfig()
        iniciaTimer()
    }
    
    func iniciaTimer() {
        NSTimer.scheduledTimerWithTimeInterval(3,
                                               target: self,
                                               selector: #selector(doStuff),
                                               userInfo: nil,
                                               repeats: true)
    }
    
    @IBOutlet weak var morphingLabel: LTMorphingLabel!
    var counter = 0
    let thingsToSay = ["µ = $20,000",
                       "σ = $5,000",
                       ]
    func doStuff() {
        morphingLabel.text = thingsToSay[counter%thingsToSay.count]
        counter = counter + 1
    }
    
    override func viewDidAppear(animated: Bool) {
        /*var colorSpace = CGColorSpaceCreateDeviceRGB();
        var num_locations = 2;
        var locations:[CGFloat] = [0.0,1.0];
        var components:[CGFloat] = {1.0, 0, 0, 1.0,
            1.0, 0, 1.0, 0}
        var gradiente = CGGradientCreateWithColors(colorSpace, components, locations)
        
        self.chart.gradientBottom = gradiente!*/
    } 
    
    func scrollConfig() {
        scrollView.delegate = self
        
        // Header - Image
        
        headerImageView = UIImageView(frame: header.bounds)
        headerImageView?.image = UIImage(named: "header_bg")
        headerImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        header.insertSubview(headerImageView, belowSubview: headerLabel)
        
        // Header - Blurred Image
        
        headerBlurImageView = UIImageView(frame: header.bounds)
        headerBlurImageView?.image = UIImage(named: "header_bg")?.blurredImageWithRadius(10, iterations: 20, tintColor: UIColor.clearColor())
        headerBlurImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        headerBlurImageView?.alpha = 0.0
        header.insertSubview(headerBlurImageView, belowSubview: headerLabel)
        
        header.clipsToBounds = true

    }
    
    
    func graphConfig() {
        
        self.chart.delegate = self
        self.chart.dataSource = self
        
        self.chart.enableYAxisLabel = false
        self.chart.enableXAxisLabel = true
        self.chart.autoScaleYAxis = true
        self.chart.alwaysDisplayDots = true
        self.chart.enableReferenceXAxisLines = false
        self.chart.enableReferenceYAxisLines = true
        self.chart.enableReferenceAxisFrame = true
        
    }
    
    
    //Data Source Graph

    
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        return workSalaries.count
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: Int) -> CGFloat {
        return workSalaries[index]
    }
    
    
    //Delegate Graph
    
   
    func lineGraph(graph: BEMSimpleLineGraphView, labelOnXAxisForIndex index: Int) -> String {
        return xAxisLabel[index]
    }
    
    
    //Delegate Scroll
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        // PULL DOWN -----------------
        
        if offset < 0 {
            
            let headerScaleFactor:CGFloat = -(offset) / header.bounds.height
            let headerSizevariation = ((header.bounds.height * (1.0 + headerScaleFactor)) - header.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            header.layer.transform = headerTransform
        }
            
            // SCROLL UP/DOWN ------------
            
        else {
            
            // Header -----------
            
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            
            //  ------------ Label
            
            let labelTransform = CATransform3DMakeTranslation(0, max(-distance_W_LabelHeader, offset_B_LabelHeader - offset), 0)
            headerLabel.layer.transform = labelTransform
            
            //  ------------ Blur
            
            headerBlurImageView?.alpha = min (1.0, (offset - offset_B_LabelHeader)/distance_W_LabelHeader)
            
            // Avatar -----------
            
            let avatarScaleFactor = (min(offset_HeaderStop, offset)) / avatarImage.bounds.height / 1.4 // Slow down the animation
            let avatarSizeVariation = ((avatarImage.bounds.height * (1.0 + avatarScaleFactor)) - avatarImage.bounds.height) / 2.0
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            
            if offset <= offset_HeaderStop {
                
                if avatarImage.layer.zPosition < header.layer.zPosition{
                    header.layer.zPosition = 0
                }
                
            }else {
                if avatarImage.layer.zPosition >= header.layer.zPosition{
                    header.layer.zPosition = 2
                }
            }
        }
        
        // Apply Transformations
        
        header.layer.transform = headerTransform
        avatarImage.layer.transform = avatarTransform
    }

    
}






