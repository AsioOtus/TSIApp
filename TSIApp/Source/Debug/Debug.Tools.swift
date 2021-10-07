import Foundation

extension Debug {
	struct Tools {
		static func measure <T> (_ label: String, action: () -> T) -> T {
			let startTime = DispatchTime.now()
			let value = action()
			let endTime = DispatchTime.now()
			
			let nanoTime = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
			let timeInterval = Double(nanoTime) / 1_000_000_000
			
			print(label, timeInterval)
			
			return value
		}
		
		static func measure (_ label: String, action: () -> ()){
			let startTime = DispatchTime.now()
			action()
			let endTime = DispatchTime.now()
			
			let nanoTime = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
			let timeInterval = Double(nanoTime) / 1_000_000_000
			
			print(label, timeInterval)
		}
	}
}
