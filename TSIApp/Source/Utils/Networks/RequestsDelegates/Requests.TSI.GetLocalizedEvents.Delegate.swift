import Networks
import SwiftDate



extension Requests.TSI.GetLocalizedEvents {
	struct Delegate: TSIRequestDelegate {
		let fromDate: DateInRegion
		let toDate: DateInRegion
		
		init (fromDate: DateInRegion, toDate: DateInRegion) {
			self.fromDate = fromDate
			self.toDate = toDate
		}
		
		func build () -> GetLocalizedEvents {
			let model = GetLocalizedEvents.Model.init(
				from: Int(fromDate.timeIntervalSince1970),
				to: Int(toDate.timeIntervalSince1970),
				groups: [App.State.current.group.key],
				lecturers: [App.State.current.lecturer.key],
				rooms: [App.State.current.room.key],
				language: App.State.current.language.backendLanguage.code
			)
			
			let request = GetLocalizedEvents(model: model)
			
			return request
		}
		
		func convert (_ response: GetLocalizedEvents.Response) -> [Schedule.Event.Raw] {
			let events = response.model.events.map {
				Schedule.Event.Raw(
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
	
	struct MonthDelegate: TSIRequestDelegate {
		let date: DateInRegion
		
		init (date: DateInRegion) {
			self.date = date
		}
		
		func build () -> GetLocalizedEvents {
			let (startDate, endDate) = Schedule.IntervalType.day.boundDates(for: date)
			
			let model = GetLocalizedEvents.Model.init(
				from: Int(startDate.timeIntervalSince1970),
				to: Int(endDate.timeIntervalSince1970),
				groups: [App.State.current.group.key],
				lecturers: [App.State.current.lecturer.key],
				rooms: [App.State.current.room.key],
				language: App.State.current.language.backendLanguage.code
			)
			
			let request = GetLocalizedEvents(model: model)
			
			return request
		}
		
		func convert (_ response: GetLocalizedEvents.Response) -> [Schedule.Event.Raw] {
			let events = response.model.events.map {
				Schedule.Event.Raw(
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
