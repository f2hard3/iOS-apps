//
//  NewsArticleListViewModel.swift
//  NewsApp
//
//  Created by Mohammad Azam on 6/30/21.
//

import Foundation

@MainActor
class NewsArticleListViewModel: ObservableObject {
    
    @Published var newsArticles = [NewsArticleViewModel]()
    
    func getNewsBy(sourceId: String) async {
        do {
            let newses = try await Webservice().fetchNews(url: Constants.Urls.topHeadlines(by: sourceId))
            newsArticles = newses.map(NewsArticleViewModel.init)
        } catch {
            print(error)
        }
    }
    
}

struct NewsArticleViewModel {
    
    let id = UUID()
    fileprivate let newsArticle: NewsArticle
    
    var title: String {
        newsArticle.title
    }
    
    var description: String {
        newsArticle.description ?? ""
    }
    
    var author: String {
        newsArticle.author ?? ""
    }
    
    var urlToImage: URL? {
        URL(string: newsArticle.urlToImage ?? "")
    }
    
}
