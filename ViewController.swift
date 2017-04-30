//
//  ViewController.swift
//  KindleBasic
//
//  Created by Hoe Zhan Hui on 4/25/17.
//  Copyright © 2017 VMax. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var books: [Book]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        
        tableView.register(BookCell.self, forCellReuseIdentifier: "cellId")
        tableView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        tableView.separatorColor = UIColor(white: 1, alpha: 0.2)
        
        //to remove extra table rows after initial row set
        tableView.tableFooterView = UIView()
    
        //set title on navBar
        navigationItem.title = "Kindle"
        setupNavigationBarStyles()
      //  setupBooks()
        
        fetchBooks()
        setupNavBarButton()
        
    }
    
    //Anchor
    //UIsegmentedControl
    //
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        
        //footerView.translatesAutoresizingMaskIntoConstraints = false
       // footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        footerView.backgroundColor = UIColor(red: 40/225, green: 40/225, blue: 40/225, alpha: 1)

        
        let segmentedControl = UISegmentedControl(items: ["Cloud", "Device"])
        
        segmentedControl.tintColor = .white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(segmentedControl)
        
        segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        segmentedControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        segmentedControl.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        //GridButton
        let gridButton = UIButton(type: .system)
        gridButton.setImage(#imageLiteral(resourceName: "grid").withRenderingMode(.alwaysOriginal), for: .normal)
        gridButton.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(gridButton)
        
        gridButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        gridButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        gridButton.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 8).isActive = true
        gridButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        
        //sortButton
        let sortButton = UIButton(type: .system)
        sortButton.setImage(#imageLiteral(resourceName: "sort").withRenderingMode(.alwaysOriginal), for: .normal)
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(sortButton)
        
        sortButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sortButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sortButton.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -8).isActive = true
        sortButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func setupNavBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuPress))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "amazon_icon").withRenderingMode(.alwaysOriginal), style:.plain, target: self, action: #selector(handleAmazonIconPress))
    }
    
    
    func handleMenuPress() {
        print("Menu Pressed")
    }
    
    func handleAmazonIconPress() {
        print("AmazonIcon Pressed")
    }
    
    
    
    
    func setupNavigationBarStyles() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 40/225, green: 40/225, blue: 40/225, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    //1. tableView numberofRowsInSection
    //2. tableView cellforRowAt
    //3. tableView.register  UITableViewCell.self --> forCelReuseIdentifier
    //4. tableView.tableFooterView = UIView()
    //5. heightForRow
    //6. cell.textLabel?.label = ""
    //7. use indexPath to sync with array item index @ cellForRow
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedBook = self.books?[indexPath.row]
        
        
        let layout = UICollectionViewFlowLayout()
        let bookPagerController = BookPagerController(collectionViewLayout: layout)
        
        let navController = UINavigationController(rootViewController: bookPagerController)
        
        bookPagerController.book = selectedBook

        present(navController, animated: true, completion: nil)
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! BookCell
        let book = books?[indexPath.row]
    
        cell.book = book

//          inaccessible due to private var
//        cell.coverImageView.image = book?.image
//        cell.titleLabel.text = book?.title
//        cell.authorLabel.text = book?.author
        
        //can downcast to book because of the cellId
        
//        cell.textLabel?.text = book?.title
//        cell.imageView?.image = book?.image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = books?.count {
            return count
        }
        return 0
    }
    
    
    //create new function for print
    //use URLSession with static method "shared" and then access dataTask method (use if let to unwrap safely)
    //provide url using URL(string:...)
    //remember to use resume function at the end of URLSession
    func fetchBooks() {
        print("Fetching books...")
        
        if let url = URL(string: "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json"){
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if let err = error {
                    print("Failed to print page from JSON URL: ", err)
                    return
                }
                //print(response)
                
                guard let data = data else { return }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    
                    self.books = []
                    //parse json down with a key of String with any type
                    guard let bookDictionaries = json as? [[String:Any]] else { return }
                    
                    for bookDictionary in bookDictionaries {

                        let book = Book(dictionary: bookDictionary)
                        self.books?.append(book)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
//                        if let title = bookDictionary["title"] as? String,
//                            let author = bookDictionary["author"] as? String {
//                            // use the [] as accessor to JSON object
//                            
//                            let book = Book(title: title, author: author, image: #imageLiteral(resourceName: "steve_jobs"), pages: [])
//                            
//                
//                            self.books?.append(book)
                    
            
                    //print("All of our books: ", self.books)
                    
                    
                    //Make sure the reload is done on main thread but not on the background thread where JSON data is being retrieved
                
                    }
                } catch let jsonError {
                    print("Failed to parse JSON properly: ", jsonError)
                }
                
                
                
            }).resume()

        }
        
    }
    
//    func setupBooks() {
//        let page1 = Page(number: 1, text: "This is text for page 1")
//        let page2 = Page(number: 2, text: "This is text for page 2")
//        
//        let pages = [page1, page2]
//        
//        let book1 = Book(title: "Steve Jobs", author: "Walter Isaacson", image: #imageLiteral(resourceName: "steve_jobs"), pages: pages)
//        //        print("Title: \(book.title), Author: \(book.author)")
//        
//        
//        
//        let book2 = Book(title: "Bill Gates: A Biography", author: "Michael Becraft", image: #imageLiteral(resourceName: "bill_gates"), pages: [
//            Page(number: 1, text: "Text for page 1"),
//            Page(number: 2, text: "Text for page 2"),
//            Page(number: 3, text: "Text for page 3"),
//            Page(number: 4, text: "Text for page 4")
//            ])
//        
//        //        print("Title: \(book2.title), Author: \(book2.author)")
//        
//        self.books = [book1,book2]
    
        
        //Another way to unwrap optional (guard)
       // guard let books = self.book else { return }
        
//        for book in books {
//            print(book.title)
//            for page in book.pages {
//                print(page.text)
//            }
//        }
        ///////////////////////////////////
        
        
        // Safe way to unwrap optionals! (if let)
        //        if let unwrappedBooks = self.book {
        //            for book in unwrappedBooks {
        //                print(book.title)
        //                for page in book.pages {
        //                    print(page.text)
        //                }
        //            }
        
//   }
}

