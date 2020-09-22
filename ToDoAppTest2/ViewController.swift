import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textField: UITextField!
    
    var todos: Array<String> = []
    
    let userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        textField.delegate = self
        
        if let aaa = userDefaults.object(forKey: "todos") {
            todos = aaa as! Array<String>
            print("aaaIsWhat\(aaa)")
            print("ここでとめます")
        }
        
        

        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
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
