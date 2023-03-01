//
//  ViewController.swift
//  PageViewControllerPOC
//
//  Created by Guru Mahan on 27/02/23.
//

import UIKit

class ViewController: UIViewController{
   
   
    @IBOutlet weak var pageView: UIView!
    
    var currentVC = 0
 
    let datasourse = ["GuruMahan ","Syed ","Naba ","Abdhullah","Palani","Balaji"]
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
        pageView.roundCorners([.topRight,.bottomRight], radius: 20)
       
    }
   
    func configurePageViewController(){
//        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: PageViewController.self)) as? PageViewController else {
//            return
//        }
        let pageViewController = PageViewController(nibName: "PageViewControllerXIB", bundle: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
      
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
    pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
      //  pageViewController.view.backgroundColor = .green
        pageView?.addSubview(pageViewController.view)
      
        let views: [String : Any] = ["pageview" : pageViewController.view!]

        pageView?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageview]-0-|",
                                                              options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                              metrics: nil,
                                                              views: views))



        pageView?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageview]-0-|",
                                                              options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                              metrics: nil,
                                                              views: views))



        guard let startVC = detailsViewController(index1: currentVC) else {
            return
            
        }
        
        pageViewController.setViewControllers([startVC], direction: .forward, animated: true)
        
       
    }
    func detailsViewController(index1: Int) -> DataViewControllerXIB? {
        
//        guard let dataVC = storyboard?.instantiateViewController(withIdentifier: String(describing: DataViewController.self)) as? DataViewController else {
//            return nil
//        }
        
     let dataVC = DataViewControllerXIB(nibName: "DataViewControllerXIB", bundle: nil)

        dataVC.index = index1
        dataVC.displayText = datasourse[index1]
      
      
        
  return dataVC
    }
}

extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
   
    
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentVC
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return datasourse.count
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let dataVC = viewController as? DataViewControllerXIB
        
        guard var currentIndex = dataVC?.index else {return nil}
        
        currentVC  =  currentIndex
        currentIndex -= 1
        if currentIndex < 0{
            currentIndex = datasourse.count - 1
        }

        return detailsViewController(index1: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let dataVC = viewController as? DataViewControllerXIB
        
        guard var currentIndex = dataVC?.index else {return nil}
        
        if currentIndex >= 5{
            currentIndex = datasourse.count + 1
            
        }
        
        currentIndex += 1
        if currentIndex >= datasourse.count{
           currentIndex = 0
        }
        currentVC = currentIndex
        return detailsViewController(index1: currentIndex)
    }
}

