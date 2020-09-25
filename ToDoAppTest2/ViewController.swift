import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var colourView: UIImageView!
    
    
    var todos: Array<String> = []
    var colour = true
    
    let userDefaults = UserDefaults.standard
    
    lazy var colourSwitch: UISwitch = {
        let viewWidth = view.frame.width
        let viewHeight = view.frame.height
        
        let colourSwitch  = UISwitch()
        colourSwitch.frame = CGRect(x:viewWidth * 0.07, y:viewHeight * 0.92, width:75, height:50)
        colourSwitch.isOn = false
        colourSwitch.addTarget(self, action: Selector(("onClick:")), for: UIControl.Event.valueChanged)
        return colourSwitch
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(colourSwitch)
        tableView.dataSource = self
        tableView.delegate = self
        
        textField.delegate = self

        
        if let aaa = userDefaults.object(forKey: "todos") {
            todos = aaa as! Array<String>
            print("aaaIsWhat\(aaa)")
            print("ここでとめます")
        }
        
        if let bbb = userDefaults.object(forKey: "colour"){
            colour = bbb as! Bool
            print("bbbIsWhat_\(colour)")
        }
        
        if colour == true{
            colourView.backgroundColor = UIColor.red
            colourSwitch.isOn = true
        }else{
            colourView.backgroundColor = UIColor.blue
            colourSwitch.isOn = false
        }
    
    }
    
    @objc func onClick(_ sender: UISwitch){
            
        if sender.isOn {
                print("ON")
                colour = true
                colourView.backgroundColor = UIColor.red
                userDefaults.set(colour, forKey: "colour")
                print("userDefault=\(userDefaults)")
                print(colour)
            }
            else {
                print("OFF")
                colour = false
                colourView.backgroundColor = UIColor.blue
                userDefaults.set(colour, forKey: "colour")
                print("userDefault=\(userDefaults)")
                print(colour)
            }
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

    
extension ViewController: UITextFieldDelegate{
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {// returnキーを押した時の処理
        // 引数がテキストフィールドの値なのでシュッドリターンになるのか？？？
        
        if let text = self.textField.text {
            // テキストがnilでないなら
            //テキストを　todos　に追加
            todos.append(text)
            // set todos to userDefaults
            userDefaults.set(todos, forKey: "todos")
            print("userDefault=\(userDefaults)")
            // record forever
            userDefaults.synchronize()
            //保存して取り出している　不要なのではないか
            todos = userDefaults.object(forKey: "todos") as! Array<String>
            print("todos=\(todos)")
        }
        
        self.textField.text = ""
        
        self.tableView.reloadData() //データをリロードする
        return true
    }
    
}



extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("you tapped me")
    }
}



extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        true
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // セルの数
        return todos.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {// セクションの数
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {// セルの内容を決める。
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let todo = todos[indexPath.row]
        
        cell.textLabel?.text = todo
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
                }
        userDefaults.set(todos, forKey: "todos")
        // record forever
        userDefaults.synchronize()
        //保存して取り出している　不要なのではないか
        todos = userDefaults.object(forKey: "todos") as! Array<String>
        print("todos=\(todos)")
        
        self.tableView.reloadData() //データをリロードする
    }
    
}
