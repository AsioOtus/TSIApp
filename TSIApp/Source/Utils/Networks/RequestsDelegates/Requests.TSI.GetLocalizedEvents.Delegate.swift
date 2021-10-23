import NetworkUtil
import SwiftDate
import BaseNetworkUtil
import Multitool

extension TSI.Requests.GetLocalizedEvents {
	struct Delegate: TSIRequestDelegate {
		var name: String { "GetLocalizedEvents" }
		
		let fromDate: DateInRegion
		let toDate: DateInRegion
		
		init (fromDate: DateInRegion, toDate: DateInRegion) {
			self.fromDate = fromDate
			self.toDate = toDate
		}
		
		func request (_ requestInfo: RequestInfo) throws -> GetLocalizedEvents {
			let model = GetLocalizedEvents.Model.init(
				from: Int(fromDate.timeIntervalSince1970),
				to: Int(toDate.timeIntervalSince1970),
				groups: [App.State.current.group.key],
				lecturers: [App.State.current.lecturer.key],
				rooms: [App.State.current.room.key],
				language: App.State.current.language.appLanguageOrDefault.backendLanguage.code
			)
			
			let request = try GetLocalizedEvents(model)
			
			return request
		}
		
		func content (_ response: GetLocalizedEvents.Response, _ requestInfo: RequestInfo) -> [Schedule.Event.Info] {
			let events = response.model.events.map {
				Schedule.Event.Info(
					date: DateInRegion(seconds: TimeInterval($0.time)),
					groups: $0.groups,
					lecturer: $0.lecturer,
					rooms: $0.rooms,
					name: $0.name,
					comment: $0.comment,
					class: .init($0.class)
				)
			}
			.sorted(by: { $0.date < $1.date })
			
			return events
		}
	}
	
	struct CustomDelegate: TSIRequestDelegate {
		var name: String { "GetLocalizedEvents.CustomDelegate" }
		
		let fromDate: DateInRegion
		let toDate: DateInRegion
		
		init (fromDate: DateInRegion, toDate: DateInRegion) {
			self.fromDate = fromDate
			self.toDate = toDate
		}
		
		func request (_ requestInfo: RequestInfo) throws -> GetLocalizedEvents {
			let model = GetLocalizedEvents.Model.init(
				from: Int(fromDate.timeIntervalSince1970),
				to: Int(toDate.timeIntervalSince1970),
				groups: [],
				lecturers: [],
				rooms: [],
				language: App.State.current.language.appLanguageOrDefault.backendLanguage.code
			)
			
			let request = try GetLocalizedEvents(model)
			
			return request
		}
		
		func content (_ response: GetLocalizedEvents.Response, _ requestInfo: RequestInfo) -> [Schedule.Event.Info] {
			let events = response.model.events.map {
				Schedule.Event.Info(
					date: DateInRegion(seconds: TimeInterval($0.time)),
					groups: $0.groups,
					lecturer: $0.lecturer,
					rooms: $0.rooms,
					name: $0.name,
					comment: $0.comment,
					class: .init($0.class)
				)
			}
			.sorted(by: { $0.date < $1.date })
			
			return events
		}
	}
}
