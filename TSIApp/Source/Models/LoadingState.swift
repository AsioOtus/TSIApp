import Combine

enum LoadingState<LoadingValue, LoadedValue> {
	case notInitialized
	case loading(LoadingValue)
	case loaded(LoadedValue)
	case failed(Error)
	
	var isNotInitialized: Bool {
		let isNotInitialized: Bool
		
		if case .notInitialized = self {
			isNotInitialized = true
		} else {
			isNotInitialized = false
		}
		
		return isNotInitialized
	}
	
	var isLoading: Bool {
		let isLoading: Bool
		
		if case .loading = self {
			isLoading = true
		} else {
			isLoading = false
		}
		
		return isLoading
	}
	
	var value: LoadedValue? {
		let value: LoadedValue?
		
		if case .loaded(let loadedValue) = self {
			value = loadedValue
		} else {
			value = nil
		}
		
		return value
	}
	
	var error: Error? {
		let error: Error?
		
		if case .failed(let loadingError) = self {
			error = loadingError
		} else {
			error = nil
		}
		
		return error
	}
	
	var stateName: String {
		switch self {
		case .notInitialized:
			return "not initialized"
		case .loading:
			return "loading"
		case .loaded:
			return "loaded"
		case .failed:
			return "failed"
		}
	}
	
	func map <T> (_ mapping: (LoadedValue) -> T) -> LoadingState<LoadingValue, T> {
		let result: LoadingState<LoadingValue, T>
		
		switch self {
		case .notInitialized:
			result = .notInitialized
		case .loading(let loadingValue):
			result = .loading(loadingValue)
		case .loaded(let loadedValue):
			result = .loaded(mapping(loadedValue))
		case .failed(let error):
			result = .failed(error)
		}
		
		return result
	}
}
