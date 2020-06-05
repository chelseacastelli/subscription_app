//
//  ViewController.swift
//  VinylsSubscription
//
//  Created by ChelseaAnne Castelli on 4/7/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gradientLayer: CAGradientLayer!
    
    var firstView: UIView!
    var secondView: UIView!
    var thirdView: UIView!
    var pagesArray: [UIView] = []
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let container: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        return view
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        pageControl.pageIndicatorTintColor = UIColor(white: 0.5, alpha: 0.5)
        pageControl.currentPageIndicatorTintColor = UIColor.gray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        stylePages()
        
        
    }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
    
    func stylePages() {
        
        scrollView.addSubview(container)
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        container.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        container.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        
        
        firstView = createOnboardingPage(message: "Tell us what artists &\ngenres you're into", imageName: "first_screen", isLastPage: false, color: .white)
        secondView = createOnboardingPage(message: "Let us send you 3 albums based on your preferences", imageName: "second_screen", isLastPage: false, color: .white)
        thirdView = createOnboardingPage(message: "Enjoy!\n(on the couch or wherever)", imageName: "third_screen", isLastPage: true, color: .white)
        
        pagesArray = [firstView, secondView, thirdView]
        
        for page in pagesArray {
            container.addArrangedSubview(page)
            page.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
            
        }
        
        pageControl.numberOfPages = pagesArray.count
        view.addSubview(pageControl)
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    

    func createOnboardingPage(message: String, imageName: String, isLastPage: Bool, color: UIColor) -> UIView {
        
        
        let page = UIView()
        
        let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 20
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.distribution = .fill
            return stackView
        }()
        
        let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        let messageLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont(name: "Kefa", size: 20)
            label.textColor = UIColor(white: 0.3, alpha: 0.8)
            return label
        }()
        
        let continueButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont(name: "Kefa", size: 20)
            button.setTitle("Subscribe Now", for: .normal)
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            button.backgroundColor = UIColor(white: 0.1, alpha: 0.9)
            return button
        }()
        
        page.backgroundColor = color
        page.addSubview(stackView)
        stackView.widthAnchor.constraint(equalTo: page.layoutMarginsGuide.widthAnchor, multiplier: 0.75).isActive = true
        stackView.heightAnchor.constraint(equalTo: page.layoutMarginsGuide.heightAnchor, multiplier: 0.5).isActive = true
        stackView.centerXAnchor.constraint(equalTo: page.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: page.centerYAnchor).isActive = true
        
        let image = UIImage(named: imageName)
        imageView.image = image
        page.addSubview(imageView)
        imageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.6).isActive = true
        
        messageLabel.text = message
        page.addSubview(messageLabel)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(messageLabel)
        
        if isLastPage {
            page.addSubview(continueButton)
            continueButton.leadingAnchor.constraint(equalTo: page.leadingAnchor, constant: 40).isActive = true
            continueButton.trailingAnchor.constraint(equalTo: page.trailingAnchor, constant: -40).isActive = true
            continueButton.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
            continueButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        return page
    }
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}

