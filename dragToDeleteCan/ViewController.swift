//
//  ViewController.swift
//  dragToDeleteCan
//
//  Created by Ahmed Eid on 05/03/2018.
//  Copyright © 2018 Ahmed Eid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var docLeft : NSLayoutConstraint?
  var docTop : NSLayoutConstraint?
  
  
  lazy var doc: UIImageView = {
    let d = UIImageView()
    d.isUserInteractionEnabled = true
    d.contentMode = .scaleAspectFit
    d.image = #imageLiteral(resourceName: "docIcon")
    d.image?.withRenderingMode(.alwaysTemplate)
    d.translatesAutoresizingMaskIntoConstraints = false
    return d
  }()

  lazy var trash: UIImageView = {
    let t = UIImageView()
    t.isUserInteractionEnabled = true
    t.contentMode = .scaleAspectFit
    t.image = #imageLiteral(resourceName: "trash")
    t.image?.withRenderingMode(.alwaysTemplate)
    t.translatesAutoresizingMaskIntoConstraints = false
    return t
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(doc)
    view.addSubview(trash)
    addConstraints()
    addInteractions()
  }
  
  func addConstraints(){
    addDocConstraints()
    addTrashConstraints()
  }
  func addInteractions(){
    addDocInteractions()
    addTrashInteractions()
  }
  
  func addDocConstraints(){
    docTop =  doc.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
    docTop?.isActive = true
    
    docLeft =  doc.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0)
    docLeft?.isActive = true
    
    doc.widthAnchor.constraint(equalToConstant: 100).isActive = true
    doc.heightAnchor.constraint(equalToConstant: 100).isActive = true
  }
  
  func addTrashConstraints(){
    trash.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    trash.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
    trash.widthAnchor.constraint(equalToConstant: 100).isActive = true
    trash.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
  }
  
  func addDocInteractions(){
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleDocTap))
    doc.addGestureRecognizer(tap)
    let pan = UIPanGestureRecognizer(target: self, action: #selector(self.handleTrashPan(sender:)))
    doc.addGestureRecognizer(pan)
  }
  
  @objc func handleDocTap(){
    print("doc tapped")
  }
  
  @objc func handleTrashPan(sender: UIPanGestureRecognizer){
    doc.layoutIfNeeded()
    let translation = sender.translation(in: view)
    let x = translation.x
    let y = translation.y
    
    docLeft?.isActive = false
    docTop?.isActive = false
    
    switch(sender.state){
    case .changed, .began:
      
      docLeft = doc.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: x)
      docLeft?.isActive = true
      
      docTop = doc.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: y)
      docTop?.isActive = true
      
      print("x", view.bounds.width - x   , "  y" , view.bounds.height - y )
      
      if(view.bounds.width - x < 220  && view.bounds.height - y < 220){
        trash.tintColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        trash.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
      }else{
        trash.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        trash.backgroundColor = UIColor.clear
      }
      
      
    case .ended:
      
      if(view.bounds.width - x < 220  && view.bounds.height - y < 220){
        doc.removeFromSuperview()
        trash.backgroundColor = UIColor.clear
      }else{
        docLeft?.constant = 0
        docTop?.constant = 0
        docLeft?.isActive = true
        docTop?.isActive = true
        UIView.animate(withDuration: 0.5, animations: {
          self.doc.layoutIfNeeded()
          self.view.layoutIfNeeded()
        })
      }
    default:
      break
    }
  }
  
  func addTrashInteractions(){
  }
}
















