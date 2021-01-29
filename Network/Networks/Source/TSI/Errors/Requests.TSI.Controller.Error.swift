import Alamofire

extension Requests.TSI {
	public enum Error: NetworksError {
		case sending(Swift.Error)
		case receiving(Swift.Error)
		
		case urlRequestCreationFailed(String)
		
		case response(Swift.Error)
		case valueIsMissing(AFDataResponse<String>)
		case responseValueFixFailed(String)
		case responseConversionToDataFailed(String)
	}
}
