//
//  NewsDetailViewController.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 27/1/23.
//

import SDWebImage
import UIKit
class NewsDetailViewController: UIViewController {
    @IBOutlet var img: UIImageView!
    @IBOutlet var detailLabel: UILabel!
    var viewModel: NewsDetailViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configueView()
        // Do any additional setup after loading the view.
    }

    init(viewModel: NewsDetailViewModel) {
        super.init(nibName: "NewsDetailViewController", bundle: nil)
        self.viewModel = viewModel
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configueView() {
        title = "News Detail"
        let placeholderImage = UIImage(named: "default")
        img.image = placeholderImage
        if let imageURLString = viewModel.imageURL {
            let imageURL = URL(string: imageURLString)
            img.sd_setImage(with: imageURL, placeholderImage: placeholderImage)
        }
        detailLabel.text = viewModel.title
    }
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
