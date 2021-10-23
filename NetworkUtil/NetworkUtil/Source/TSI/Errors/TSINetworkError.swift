import BaseNetworkUtil

enum TSINetworkError: BaseNetworkUtilError {
	case urlRequestCreationFailed(String)
	case responseDataAsStringInterpretationFailed(Data)
	case responseFixingFailed(error: String, dataString: String)
}
