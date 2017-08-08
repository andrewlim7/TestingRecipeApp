//
//  MainVC.swift
//  TestingRecipeApp
//
//  Created by Andrew Lim on 03/08/2017.
//  Copyright © 2017 Andrew Lim. All rights reserved.
//

import UIKit

class MainVC: UIViewController, XMLParserDelegate {
    
    @IBOutlet weak var addRecipeButton: UIBarButtonItem!{
        didSet{
            addRecipeButton.target = self
            addRecipeButton.action = #selector(didTapAddRecipeButton(_:))
        }
    }
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    var recipes : [Recipe] = []
    var categories : [String] = []
    var eName : String = String()
    var recipeTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.url(forResource: "Recipe", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path){
                parser.delegate = self
                parser.parse()
            }
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didTapAddRecipeButton(_ sender: Any){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "CreateRecipeVC")
        
        present(nextVC, animated: true, completion: nil)
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        eName = elementName
        if elementName == "recipetype" {
            recipeTitle = String()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "recipetype" {
//            let recipe = Recipe()
//            recipe.title = recipeTitle
            
            categories.append(recipeTitle)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (!data.isEmpty) {
            if eName == "name" {
                recipeTitle += data
            }
        }
    }

}

extension MainVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let currentRow = categories[indexPath.row]
        
        cell.textLabel?.text = currentRow
        
        return cell
    }
    
}

extension MainVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentRow = categories[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "SelectedCategoryVC") as! SelectedCategoryVC
        
        nextVC.getCategory = currentRow
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
