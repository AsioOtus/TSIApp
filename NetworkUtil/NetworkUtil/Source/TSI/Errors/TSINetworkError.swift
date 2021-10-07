import BaseNetworkUtil

enum TSINetworkError: BaseNetworkUtil.Error {
	case urlRequestCreationFailed(String)
	case responseDataAsStringInterpretationFailed(Data)
	case responseFixingFailed(error: String, dataString: String)
}
