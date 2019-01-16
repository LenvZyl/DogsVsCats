
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var checkAnimalButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var classificationLabel: UILabel!
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAnimalButton.isEnabled = false
        imagePicker.delegate = self
    }

    
    @IBAction func selectImageSource(_ sender: Any) {
        
        
        let imageSourceActions = UIAlertController(title: "Image Source", message: "Choose an image source to continue.", preferredStyle: .actionSheet)
        imageSourceActions.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true)
        }))
        imageSourceActions.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(imageSourceActions, animated: true)
    }
    
    @IBAction func checkAnimal(_ sender: Any) {
        AnimalDetector.startAnimalDetection(imageView) { (results) in
            guard let animal = results.first else {
                print("No detection")
                return
            }
            DispatchQueue.main.async {
                self.classificationLabel.text = "It's a \(animal)"
            }
            
        }
    }

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        imageView.image = selectedImage
        imageView.contentMode = .scaleAspectFill
        checkAnimalButton.isEnabled = true
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
