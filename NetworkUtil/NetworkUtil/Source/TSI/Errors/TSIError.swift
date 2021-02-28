import BaseNetworkUtil

enum TSIError: BaseNetworkUtilError {
	case urlRequestCreationFailed(String)
}
