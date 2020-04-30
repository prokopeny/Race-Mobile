
import UIKit

class TableViewController: UIViewController {
    
    var array = ["1","2","3","4"]
    var records = RecordsManager.shared
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var recordsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cancelButton.roundCorners()
        recordsTableView.reloadData()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        buttonSound.stop(SoundName: "buttonSound")
        buttonSound.play(SoundName: "buttonSound", numberOfLoops: 0)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.resultArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? RecordsTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.nameLabel.text = records.resultArray[indexPath.row].nameItem
        cell.scoreLabel.text = ("очки: \(String(records.resultArray[indexPath.row].countItem!))")
        cell.userPhotoImageView.layer.cornerRadius = 10
        cell.userPhotoImageView.contentMode = .scaleAspectFill
        cell.userPhotoImageView.image = UIImage(data: records.resultArray[indexPath.row].imageItem!)
        return cell
    }
}
