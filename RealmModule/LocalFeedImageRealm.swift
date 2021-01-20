//
//  LocalFeedImageRealm.swift
//  FeedStoreChallenge
//
//  Created by Carlos Damiao on 16/01/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation
import RealmSwift

public class LocalFeedImageRealm: Object {
	@objc dynamic var id = ""
	@objc dynamic var _description = ""
	@objc dynamic var location = ""
	@objc dynamic var url = ""

	convenience init(id: UUID,
		 description: String?,
		 location: String?,
		 url: URL) {
		self.init()
		self.id = id.uuidString
		_description = description ?? ""
		self.location = location ?? ""
		self.url = url.absoluteString
	}

	public override class func primaryKey() -> String? {
		"id"
	}
}

public extension LocalFeedImageRealm {
	func asDomain() -> LocalFeedImage {
		guard let uuid = UUID(uuidString: id),
			  let url = URL(string: url) else {
			fatalError("Data issue when mapping from Realm object to Domain object (LocalFeedImage)")
		}
		return LocalFeedImage(id: uuid,
							  description: !_description.isEmpty ? _description : nil,
							  location: !location.isEmpty ? location : nil,
							  url: url)
	}
}

public extension LocalFeedImage {
	func asRealm() -> LocalFeedImageRealm {
		LocalFeedImageRealm(id: id,
							description: description,
							location: location,
							url: url)
	}
}
