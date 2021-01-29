import Networks

extension Requests.TSI.GetItems {
	struct Delegate: TSIRequestDelegate {
		func build () -> Requests.TSI.GetItems { Requests.TSI.GetItems() }
		
		func convert (_ response: Requests.TSI.GetItems.Response) -> Schedule.FilterValuesSets {
			let groups    = response.model.groups.map{ KeyValuePair($0, $1) }.sorted { $0.value < $1.value }
			let lecturers = response.model.lecturers.map{ KeyValuePair($0, $1) }.sorted { $0.value < $1.value }
			let rooms     = response.model.rooms.map{ KeyValuePair($0, $1) }.sorted { $0.value < $1.value }
			
			let scheduleFilterValuesSets = Schedule.FilterValuesSets(groups: groups, lecturers: lecturers, rooms: rooms)
			
			return scheduleFilterValuesSets
		}
	}
}
