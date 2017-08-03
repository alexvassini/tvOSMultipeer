
//  ViewController.swift
//  tvOS Bonjour Server
//
//  Created by Alexandre  Vassinievski on 28/07/17.
//  Copyright © 2017 Alexandre  Vassinievski. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ServiceManagerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let service = MultipeerServiceManager()
    
    var users:[String] = [] //Array.init(repeating: "", count: 8)
    var messages:[String] = [] //Array.init(repeating: "", count: 8)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()

        service.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCollectionView", for: indexPath) as! CardCollectionViewCell
        
        
      //  let range = NSMakeRange(cell.messageField.text.characters.count - 1, 1)
        
      //  cell.messageField.scrollRangeToVisible(range)
        
        
        cell.messageField.text = self.messages[indexPath.row]
     
        cell.userNameLabel.text = self.users[indexPath.row]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.users.count
    }
    
    
    
    
    
    
    
    func connectedDevicesChanged(manager: MultipeerServiceManager, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            
          //  self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    func receiveData(manager : MultipeerServiceManager, user: String, message: String){
    
        OperationQueue.main.addOperation {
            
            if let index = self.users.index(of: user){
                
                self.messages[index] =  message
                
            }
            
            else
            {
                self.users.append(user)
                self.messages.append(message)
            }
            
            
            self.collectionView.reloadData()
        }
    }

    
}

