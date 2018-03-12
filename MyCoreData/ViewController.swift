//  ViewController.swift
//  MyCoreData

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var uNameOutlet: UITextField!
    @IBOutlet weak var passOutlet: UITextField!
    @IBOutlet weak var lNameOutlet: UITextField!
    @IBOutlet weak var fNameOutlet: UITextField!
    
    var userName = [String?]()
    var password = [String?]()
    var name = [String?]()
    let user1 = DataBaseManager(nameOfentity: "SignUp")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signUpbtn(_ sender: UIButton) {
        let user = user1.getRow() as! SignUp
        user.firstName = fNameOutlet.text!
        user.lastName = lNameOutlet.text!
        user.password = passOutlet.text!
        user.userName = uNameOutlet.text!
        userName.append(uNameOutlet.text!)
        password.append(passOutlet.text!)
        name.append(fNameOutlet.text!)
        //userName.append(fNameOutlet.text!)
        user1.save(rowValue: user)
        //tableViewOutlet.reloadData()
        
    }
    
    
    @IBAction func ViewAllDataBtn(_ sender: UIButton) {
        let table = user1.fetchTable()
        userName.removeAll()
        password.removeAll()
        name.removeAll()
        for row in table!
        {
            userName.append(row.value(forKey: "userName") as? String)
            password.append(row.value(forKey: "lastName") as? String)
            name.append(row.value(forKey: "firstName") as? String)
        }
        tableViewOutlet.reloadData()
    }
    
    @IBAction func deleteBtn(_ sender: UIButton) {
        user1.deleteAllData()
        userName.removeAll()
        password.removeAll()
        name.removeAll()
        tableViewOutlet.reloadData()
    }

    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let table = user1.fetchTable()
//        for row in table!
//        {
//            print(row.value(forKey: "firstName") as! String)
//            print(row.value(forKey: "lastName") as! String)
//            print(row.value(forKey: "password") as! String)
//            print(row.value(forKey: "userName") as! String)
//        }
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "TableViewCellID") as! TableViewCell
        cell.nameOutlet?.text = userName[indexPath.row]
        cell.passwordOutlet.text = password[indexPath.row]
        cell.userNameOutlet.text = name[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            userName.remove(at: indexPath.row)
            password.remove(at: indexPath.row)
            name.remove(at: indexPath.row)
            print("Calling delete")
            user1.deleteDataByIndex(index: indexPath)
            tableViewOutlet.reloadData()
        }
    }

//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        let row = (user1.updateData(index: indexPath)) as! SignUp
//        fNameOutlet.text = row.firstName
//        lNameOutlet.text = row.lastName
//        passOutlet.text = row.password
//        uNameOutlet.text = row.userName
//        userName[indexPath.row] = uNameOutlet.text!
//        password[indexPath.row] = lNameOutlet.text!
//        name[indexPath.row] = fNameOutlet.text!
//         print("willSelectRowAt")
//        return indexPath
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("didSelectRowAt")
//    }
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        print("didDESelectRowAt")
//    }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        let row = (user1.updateData(index: indexPath)) as! SignUp
        row.firstName = name[indexPath.row]
        row.lastName = password[indexPath.row]
        row.password = passOutlet.text!
        row.userName = userName[indexPath.row]
        user1.save(rowValue: row)
        print("willDeselectRowAt")
        userName[indexPath.row] = uNameOutlet.text!
        password[indexPath.row] = lNameOutlet.text!
        name[indexPath.row] = fNameOutlet.text!
        tableViewOutlet.reloadData()
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myView = UIView(frame: CGRect(x:0,y:10,width: view.frame.width,height:40))
        let fname = UILabel(frame: CGRect(x: 20, y: 0, width: Int(myView.frame.width/4), height: 30))
        fname.text = "First Name"
        fname.backgroundColor = UIColor.gray
        fname.textColor = UIColor.white
        fname.textAlignment = .center
        //myView.backgroundColor = UIColor.red
        myView.addSubview(fname)
        let lName = UILabel(frame: CGRect(x: 150, y: 0, width: Int(myView.frame.width/4), height: 30))
        lName.text = "LastName"
        lName.backgroundColor = UIColor.gray
        lName.textColor = UIColor.white
        lName.textAlignment = .center
        //myView.backgroundColor = UIColor.red
        myView.addSubview(lName)
        let userName = UILabel(frame: CGRect(x: 290, y: 0, width: Int(myView.frame.width/4), height: 30))
        userName.text = "User name"
        userName.textAlignment = .center
        userName.backgroundColor = UIColor.gray
        userName.textColor = UIColor.white
        //myView.backgroundColor = UIColor.red
        myView.addSubview(userName)
        return myView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 1) {
            var rotation:CATransform3D ;
            rotation = CATransform3DMakeRotation( CGFloat((90.0*Double.pi)/180), 0.0, 0.7, 0.4);
            rotation.m34 = 1.0 / -600;
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 10, height: 10)
            cell.alpha = 0;
            
            cell.layer.transform = rotation;
            cell.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
            UIView.animate(withDuration: 1, animations: {
                cell.layer.transform = CATransform3DIdentity;
                cell.alpha = 1;
                cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            }, completion: nil)
        }
    }
    
}

