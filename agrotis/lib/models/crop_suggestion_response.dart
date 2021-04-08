import "device_values.dart";
import "optimum_values.dart";

class CropSuggestionResponse  {
	int status;
	String message;
	DeviceValues deviceValues;
	OptimumValues optimumValues;
	List<String> suggestions;

	CropSuggestionResponse({this.status, this.message, this.deviceValues, this.optimumValues, this.suggestions});

	factory CropSuggestionResponse.fromJson(Map<String, dynamic> json) {
		return CropSuggestionResponse(
			status: json['status'],
			message: json['message'],
			deviceValues: json['deviceValues'] != null ? new DeviceValues.fromJson(json['deviceValues']) : null,
			optimumValues: json['optimumValues'] != null ? new OptimumValues.fromJson(json['optimumValues']) : null,
			suggestions: json['suggestions'].cast<String>(),
		);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = this.status;
		data['message'] = this.message;
		if (this.deviceValues != null) {
      data['deviceValues'] = this.deviceValues.toJson();
    }
		if (this.optimumValues != null) {
      data['optimumValues'] = this.optimumValues.toJson();
    }
		data['suggestions'] = this.suggestions;
		return data;
	}


}
