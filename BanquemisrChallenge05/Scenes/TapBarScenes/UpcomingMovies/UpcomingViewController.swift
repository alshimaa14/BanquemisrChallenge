//
//  UpcomingViewController.swift
//  BanquemisrChallenge
//
//  Created by Alshimaa on 01/03/2024.
//

import UIKit
import Combine

class UpcomingViewController: BaseViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel: VideosViewModel
    private var cancellable = Set<AnyCancellable>()
    
    init(viewModel: VideosViewModel) {
        self.viewModel = viewModel
        super.init(nibName: UpcomingViewController.className, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.baseViewModel = viewModel
        super.viewDidLoad()
        title = "Upcoming Movies"
        setupList()
        viewModel.getVideos()
        setupViewModelBinding()
    }
}

extension UpcomingViewController {
    private func setupViewModelBinding() {
        viewModel.videosPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isEmpty  in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
            .store(in: &cancellable)
    }
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupList() {
        tableView.register(VideoTableViewCell.nib, forCellReuseIdentifier: VideoTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = VideoTableViewCell.instance(tableView)
        cell.videoModel = viewModel.getVideoItem(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfVideosRows
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.navigateToVideoDetails(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfVideosRows - 1 {
            viewModel.loadNextPage()
        }
    }

}

