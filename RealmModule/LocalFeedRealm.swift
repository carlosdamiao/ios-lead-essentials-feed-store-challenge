//
//  LocalFeedRealm.swift
//  FeedStoreChallenge
//
//  Created by Carlos Damiao on 17/01/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation
import RealmSwift

public class LocalFeedRealm: Object {
	@objc dynamic public var timestamp = Date()
	public let feedImages = List<LocalFeedImageRealm>()

	public convenience init(feedImages: [LocalFeedImageRealm],
							timestamp: Date) {
		self.init()
		self.feedImages.append(objectsIn: feedImages)
		self.timestamp = timestamp
	}
}
