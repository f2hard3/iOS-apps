//
//  OnboaringPageViewController.swift
//  OnboardingView
//
//  Created by Sunggon Park on 2024/03/19.
//

import UIKit

class OnboaringPageViewController: UIPageViewController {
    var pages = [UIViewController]() {
        didSet {
            lastIndex = pages.count - 1
        }
    }
    var buttonBottomConstraint: NSLayoutConstraint?
    let startIndex = 0
    var lastIndex = 2
    var currentIndex = 0 {
        didSet {
            pageControl.currentPage = currentIndex
        }
    }
    var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        
        makePageVCs()
        setupViews()
        setupViewControllers()
    }
    
    private func makePageVCs() {
        let onboardVC1 = OnboaringViewController(nibName: "OnboaringViewController", bundle: nil)
        onboardVC1.titleText = "Focus on your ideal buyer"
        onboardVC1.descriptionText = "When you write a product description with a huge crowd of buyers in mind, your descriptions become wishy-washy and you end up addressing no one at all."
        onboardVC1.image = UIImage(named: "onboarding1")
        
        let onboardVC2 = OnboaringViewController(nibName: "OnboaringViewController", bundle: nil)
        onboardVC2.titleText = "Entice with benefits"
        onboardVC2.descriptionText = "When we sell our products, we get excited about individual product features and specifications. We live and breathe out company, out website and out products."
        onboardVC2.image = UIImage(named: "onboarding2")
        
        let onboardVC3 = OnboaringViewController(nibName: "OnboaringViewController", bundle: nil)
        onboardVC3.titleText = "Avoid yeah yeah phrase"
        onboardVC3.descriptionText = "When we're stuck for words and don't know what else to add our product description, we often add something bland like \"excellent product quality\"."
        onboardVC3.image = UIImage(named: "onboarding3")
        
        pages += [onboardVC1, onboardVC2, onboardVC3]
    }
    
    private func setupViews() {
        let button = makeButton()
        view.addSubview(button)
        buttonBottomConstraint = button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 100)
        buttonBottomConstraint?.isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let pageControl = makePageControl()
        view.addSubview(pageControl)
        pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func makeButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }
    
    @objc func buttonTapped() {
        dismiss(animated: true)
    }
       
    private func makePageControl() -> UIPageControl{
        pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = startIndex
        pageControl.isUserInteractionEnabled = true
        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
        
        return pageControl
    }
    
    @objc func pageControlTapped(sender: UIPageControl) {
        let direction: UIPageViewController.NavigationDirection = sender.currentPage > currentIndex ? .forward : .reverse
        setViewControllers([pages[sender.currentPage]], direction: direction, animated: true)
        
        currentIndex = sender.currentPage
        presentButton()
    }
    
    private func setupViewControllers() {
        guard let pageToShow = pages.first else { return }
        setViewControllers([pageToShow], direction: .forward, animated: true)
    }
}

extension OnboaringPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        return currentIndex == startIndex ? pages.last : pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        return currentIndex == lastIndex ? pages.first : pages[currentIndex + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first else { return }
        guard let currentIndex = pages.firstIndex(of: currentVC) else { return }
        self.currentIndex = currentIndex
        
        presentButton()
    }
    
    private func presentButton() {
        currentIndex == lastIndex ? showButton() : hideButton()
  
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func showButton() {
        buttonBottomConstraint?.constant = 0
    }
    
    private func hideButton() {
        buttonBottomConstraint?.constant = 100
    }
}
