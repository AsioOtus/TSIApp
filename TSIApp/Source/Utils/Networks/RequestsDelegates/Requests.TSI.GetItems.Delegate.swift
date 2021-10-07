import NetworkUtil
import BaseNetworkUtil

extension TSI.Requests.GetItems {
	struct Delegate: TSIRequestDelegate {
		func request (_ requestInfo: NetworkController.RequestInfo) -> TSI.Requests.GetItems {
			TSI.Requests.GetItems()
		}
		
		func content (_ response: TSI.Requests.GetItems.Response, _ requestInfo: NetworkController.RequestInfo) throws -> Schedule.FilterValuesSets {
			let groups    = response.model.groups.map{ KeyValuePair($0, $1) }.sorted { $0.value < $1.value }
			let lecturers = response.model.lecturers.map{ KeyValuePair($0, $1) }.sorted { $0.value < $1.value }
			let rooms     = response.model.rooms.map{ KeyValuePair($0, $1) }.sorted { $0.value < $1.value }
			
			let scheduleFilterValuesSets = Schedule.FilterValuesSets(groups: groups, lecturers: lecturers, rooms: rooms)
			
			return scheduleFilterValuesSets
		}
	}
}
