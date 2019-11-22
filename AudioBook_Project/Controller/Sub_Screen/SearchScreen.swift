//
//  SearchScreen.swift
//  AudioBook_Project
//
//  Created by Cuong  Pham on 11/5/19.
//  Copyright © 2019 Cuong  Pham. All rights reserved.
//

import UIKit
import Stevia
import Alamofire
import SwiftyJSON
import SDWebImage
import SVProgressHUD

class SearchScreen: UIViewController {
    
    private lazy var resultTableView : UITableView = UITableView()
    
    private lazy var dataArray : Array<Book> = []
    
    //vì dữ liệu lấy về từ server ở dạng object nên ta có mảng nameArray chỉ lưu tên của các Object đó
    private lazy var nameArray : Array<String> = []
    
    private let bookService = BookService()

//NOTE: các biến phục vụ cho việc search
    //biến lưu các kết quả search được
    private var result : Array<String> = []
    //biến bool để xác định khi nào search, false là mặc định, true là đang tiến hành search
    private lazy var searching : Bool = false
//---------------------------------------------------------------------------------------------------------
    private lazy var searchBar : UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Nhập tên truyện cần tìm"
        search.barTintColor = .white
        search.showsCancelButton = true
        return search
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.bookService.delegate = self
        self.bookService.loadBook()
        
        self.setUpNavigation()
        self.setUpLayout()
        self.setUpTableView()
    
        //gán delegate cho search bar
        self.searchBar.delegate = self
    }
    
    fileprivate func setUpLayout(){
        view.sv(searchBar, resultTableView)
        searchBar.centerHorizontally().width(100%).height(40).Top == view.safeAreaLayoutGuide.Top
        resultTableView.centerHorizontally().width(100%).Top == searchBar.Bottom
        resultTableView.Bottom == view.safeAreaLayoutGuide.Bottom
    }
    
    fileprivate func setUpTableView(){
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.register(BookResultCell.self, forCellReuseIdentifier: "book")
        resultTableView.backgroundColor = .white
        resultTableView.bounces = false
    }
    
    deinit {
        print("search screen deinit")
    }
    
    fileprivate func setUpNavigation(){
        self.navigationItem.title = "Tìm kiếm"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-2"), style: .done, target: self, action: #selector(onTapBack))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc func onTapBack(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchScreen : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching == false{
            return 0
        }else{
            return self.result.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.resultTableView.dequeueReusableCell(withIdentifier: "book", for: indexPath) as? BookResultCell else { fatalError() }
        if searching == false{
            return cell
        }else{
            cell.bookName.text = self.result[indexPath.row]
            for i in dataArray {
                if i.name == result[indexPath.row] {
                    cell.bookImage.sd_setImage(with: URL(string: i.image), completed: nil)
                }
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching == false {
            return
        }else{
            print(self.result[indexPath.row])
            let nextScreen = BookDetailScreen()
            for i in dataArray {
                if i.name == result[indexPath.row] {
                    nextScreen.id_book = i.id
                }
            }
            self.navigationController?.pushViewController(nextScreen, animated: true)
        }
    }
}

extension SearchScreen : BookServiceDelegate {
    func getBookSuccess(data: [Book]) {
        self.dataArray = data
        self.nameArray = self.dataArray.map({$0.name})
        DispatchQueue.main.async {
            self.resultTableView.reloadData()
        }
    }
    
    func getBookFail(error: Error) {
        print(error)
    }
}

extension SearchScreen : UISearchBarDelegate {
//NOTE: hàm này bắt các hành động khi người dùng nhập text vào SearchBar, kết quả sẽ được hiển thị ngay. Nếu dùng cách này thì ko cần bắt sự kiện của nút search nữa. Chỉ chọn 1 trong 2 cách
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.count == 0 {
//            self.searching = false
//        }else{
//            self.result = self.nameArray.filter({$0.lowercased().contains(find: searchText.lowercased())})
//            self.searching = true
//            self.resultTableView.reloadData()
//        }
//    }
//------------------------------------------------------------------------------------------------------------------
//NOTE: hàm bắt sự kiện khi ấn nút cancel
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searching = false
        searchBar.text = ""
        self.resultTableView.reloadData()
        searchBar.resignFirstResponder()
    }
//------------------------------------------------------------------------------------------------------------------
//NOTE: hàm bắt sự kiện khi ấn nút search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        if searchText.count == 0 {
            self.searching = false
            self.resultTableView.reloadData()
            searchBar.resignFirstResponder()
        }else if searchText.count < 3 {
            print("Bạn phải nhập 3 ký tự trở lên")
        }else{
            self.result = self.nameArray.filter({$0.lowercased().contains(find: searchText.lowercased())})
            self.searching = true
            self.resultTableView.reloadData()
            searchBar.resignFirstResponder()
        }
    }
}
//------------------------------------------------------------------------------------------------------------------
//NOTE: Extension kiểm tra xem 1 chuỗi có chứa 1 chuỗi con ko
extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
}
//--------------------------------------------------------
