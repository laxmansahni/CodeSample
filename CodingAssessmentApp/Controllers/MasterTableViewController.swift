//
//  MasterTableViewController.swift
//  CodingAssessmentApp
//
//  Created by Laxman Sahni on 26/06/18.
//  Copyright © 2018 Nagarro. All rights reserved.
//

import UIKit
import SDWebImage
import MBProgressHUD

protocol ArticleSelectionDelegate: class {
    func articleSelected(_ articleDetail:Article?)
}

class MasterTableViewController: UITableViewController
{
    var isDetailViewController:Bool = true
    var tableDataSource = [Article]()

     weak var delegate: ArticleSelectionDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.splitViewController?.delegate = self
        //to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
        
         self.tableView.tableFooterView = UIView()

        self.tableView.estimatedRowHeight = 115
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.accessibilityIdentifier = UIMessages.kTableViewAccessibilityIdentifier
        
        let hud = MBProgressHUD.showAdded(to:self.view, animated:true)
        
        hud.label.text = "Fetching articles..."
        
        self.fetchArticleList()
        
    }

   
    
    func fetchArticleList()
    {
        AppApiManager.sharedInstance.getArticlesList { (response,customError) in
            
            MBProgressHUD.hide(for:self.view, animated:true)
            
            if customError != nil
            {
                //Handle Error
                //TO-DO
            }
            else
            {
                if let res = response
                {
                    self.tableView.isHidden = false
                    self.tableDataSource = res
                    self.tableView.reloadData()
                }
            }
            
            
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tableDataSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       
        // Configure the cell...
        
        var cell : UITableViewCell?
        
        if let articleCell = tableView.dequeueReusableCell(withIdentifier:String(describing: ArticleTableViewCell.self), for: indexPath) as? ArticleTableViewCell
        {
            
            let article = tableDataSource[indexPath.row]
            if let abstractString = article.abstract
            {
                articleCell.articleAbstractLabel.text = abstractString
                
            }
            
            if let byLineString = article.byLine
            {
                articleCell.byLineLabel.text = byLineString
                
            }
            
            if let publishedDate = article.dateString
            {
                articleCell.dateLabel.text = publishedDate
                
            }
            
            
            
            if let imageUrl = article.imageUrl
            {
                
                articleCell.articleIconImageView.sd_setImage(with: URL(string:imageUrl), placeholderImage:nil)
                
                
            }

            
            
            cell = articleCell
            
            
            
        }
        
       
       
        return cell ?? UITableViewCell()
        
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedArticle = tableDataSource[indexPath.row]
        
        delegate?.articleSelected(selectedArticle)
        isDetailViewController = false

        if let detailViewController = delegate as? DetailViewController,
            let detailNavigationController = detailViewController.navigationController
        {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
        
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
//    {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//
//        guard let detailController = segue.destination as? DetailViewController
//        else {
//
//            fatalError("Expected viewcontroller")
//        }
//
//        detailController.
//
//    }


}

extension MasterTableViewController:UISplitViewControllerDelegate
{
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        return isDetailViewController
    }
    
}
