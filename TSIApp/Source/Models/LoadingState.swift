enum LoadingState<Value> {
	case notInitialized
	case loading
	case loaded(Value)
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
	
	var value: Value? {
		let value: Value?
		
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
	
	func map <T> (_ mapping: (Value) -> T) -> LoadingState<T> {
		let result: LoadingState<T>
		
		switch self {
		case .notInitialized:
			result = .notInitialized
		case .loading:
			result = .loading
		case .loaded(let value):
			result = .loaded(mapping(value))
		case .failed(let error):
			result = .failed(error)
		}
		
		return result
	}
}
