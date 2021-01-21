//
//  RealmFeedStore.swift
//  FeedStoreChallenge
//
//  Created by Carlos Damiao on 21/01/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation
import RealmSwift

public class RealmFeedStore: FeedStore {

	private let realm: Realm

	public init(config: Realm.Configuration) {
		realm = try! Realm(configuration: config)
	}

	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		do {
			try realm.write {
				realm.deleteAll()
			}
			completion(.none)
		} catch {
			completion(error)
		}
	}

	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		let feed = LocalFeedRealm(feedImages: feed.map { $0.asRealm() },
								  timestamp: timestamp)
		do {
			try realm.write {
				realm.deleteAll()
				realm.add(feed)
			}
			completion(.none)
		} catch {
			completion(error)
		}
	}

	public func retrieve(completion: @escaping RetrievalCompletion) {
		guard let feed = realm.objects(LocalFeedRealm.self).first else {
			completion(.empty)
			return
		}

		switch feed.feedImages.isEmpty {
		case true:
			completion(.empty)
		case false:
			completion(.found(feed: feed.feedImages.map { $0.asDomain() },
							  timestamp: feed.timestamp))
		}
	}
}
