import SwiftDate



extension Debug {
	struct TestData { }
}



extension Debug.TestData {
	static let groupShortName1 = SelectionModel("1", "4501BD")
	static let groupShortName2 = SelectionModel("2", "4502BD")
	static let groupShortName3 = SelectionModel("3", "4503BD")
	
	static let groupLongName1 = SelectionModel("4", "4501BD – Cho-to tam")
	static let groupLongName2 = SelectionModel("5", "1503-2MDA")
}



extension Debug.TestData {
	static let roomVeryShortName1 = SelectionModel("1", "I")
	static let roomVeryShortName2 = SelectionModel("2", "II")
	
	static let roomNormalName1 = SelectionModel("3", "228")
	
	static let roomLongName1 = SelectionModel("4", "1234567890")
}



extension Debug.TestData {
	static let lecturerNormalName1 = SelectionModel("1", "Irina Pticina")
	static let lecturerNormalName2 = SelectionModel("2", "Irina Jackiva")
	static let lecturerNormalName3 = SelectionModel("3", "Vladimir Labeev")
}



extension Debug.TestData {
	static let lectureNormalName1 = "Programming"
	static let lectureNormalName2 = "Operational systems"
	static let lectureNormalName3 = "Networks"
	
	static let lectureLongName1 = "Methods of Computer Processing of Statistical Data"
	static let lectureLongName2 = "Lecture with very very very very very very very very very very very very very very very very very very long name"
}



//extension Debug.TestData {
//	static let event = Schedule.Event.Display(
//		raw: .init(
//			date: DateInRegion(year: 0, month: 0, day: 0, hour: 13, minute: 45),
//			groups: [],
//			lecturer: "",
//			rooms: [],
//			name: lectureLongName1,
//			comment: "",
//			class: nil
//		),
//		groups:	.loaded([.value(groupShortName1)]),
//		lecturer: .loaded(.value(lecturerNormalName3)),
//		rooms: .loaded([.value(roomNormalName1)])
//	)
//}
//
//
//
//extension Debug.TestData {
//	static let day = Schedule.Table.Day(
//		DateInRegion(),
//		[
//			.init(
//				date: DateInRegion(year: 0, month: 0, day: 0, hour: 8, minute: 45),
//				groups: .loaded(
//					[
//						.value(groupShortName1),
//						.value(groupLongName2)
//					]
//				),
//				lecturer: .loaded(.value(lecturerNormalName1)),
//				rooms: .loaded([.value(.init("123", "II"))]),
//				name: lectureNormalName1,
//				comment: "Nothing",
//				class: nil
//			),
//			.init(
//				date: DateInRegion(year: 0, month: 0, day: 0, hour: 10, minute: 30),
//				groups: .loaded(
//					[
//						.value(groupShortName1),
//						.value(groupShortName2),
//						.value(groupLongName1)
//					]
//				),
//				lecturer: .loaded(.value(lecturerNormalName2)),
//				rooms: .loaded([.value(roomNormalName1)]),
//				name: lectureNormalName2,
//				comment: "",
//				class: nil
//			),
//			.init(
//				date: DateInRegion(year: 0, month: 0, day: 0, hour: 12, minute: 15),
//				groups: .loaded(
//					[
//						.value(groupShortName1),
//						.value(groupShortName2)
//					]
//				),
//				lecturer: .loaded(.value(lecturerNormalName3)),
//				rooms: .loaded(
//					[
//						.value(.init("123", "I")),
//						.value(.init("123", "II"))
//					]
//				),
//				name: lectureLongName1,
//				comment: "Some comment",
//				class: nil
//			)
//		]
//	)
//	
//	static let regularDay = Schedule.Table.Day(
//		DateInRegion(),
//		[
//			.init(
//				date: DateInRegion(year: 0, month: 0, day: 0, hour: 8, minute: 45),
//				groups: .loaded(
//					[
//						.value(groupShortName1),
//						.value(groupShortName2)
//					]
//				),
//				lecturer: .loaded(.value(lecturerNormalName1)),
//				rooms: .loaded(
//					[
//						.value(.init("123", "I"))
//					]
//				),
//				name: lectureNormalName1,
//				comment: "",
//				class: nil
//			),
//			.init(
//				date: DateInRegion(year: 0, month: 0, day: 0, hour: 10, minute: 30),
//				groups: .loaded(
//					[
//						.value(groupShortName1),
//						.value(groupShortName2),
//						.value(groupLongName1)
//					]
//				),
//				lecturer: .loaded(.value(lecturerNormalName2)),
//				rooms: .loaded(
//					[
//						.value(.init("123", "I"))
//					]
//				),
//				name: lectureNormalName2,
//				comment: "",
//				class: nil
//			),
//			.init(
//				date: DateInRegion(year: 0, month: 0, day: 0, hour: 12, minute: 15),
//				groups: .loaded(
//					[
//						.value(groupShortName1),
//						.value(groupShortName2)
//					]
//				),
//				lecturer: .loaded(.value(lecturerNormalName3)),
//				rooms: .loaded(
//					[
//						.value(.init("123", "I")),
//						.value(.init("123", "II"))
//					]
//				),
//				name: lectureLongName1,
//				comment: "Online",
//				class: nil
//			)
//		]
//	)
//}
