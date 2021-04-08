class OptimumValues  {
	String id;
	String cropName;
	int minTemp;
	int maxTemp;
	int advTemp;
	String sideEffect;
	int minPh;
	int maxPh;

	OptimumValues({this.id, this.cropName, this.minTemp, this.maxTemp, this.advTemp, this.sideEffect, this.minPh, this.maxPh});

	factory OptimumValues.fromJson(Map<String, dynamic> json) {
		return OptimumValues(
			id: json['_id'],
			cropName: json['cropName'],
			minTemp: json['minTemp'],
			maxTemp: json['maxTemp'],
			advTemp: json['advTemp'],
			sideEffect: json['sideEffect'],
			minPh: json['minPh'],
			maxPh: json['maxPh'],
		);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['_id'] = this.id;
		data['cropName'] = this.cropName;
		data['minTemp'] = this.minTemp;
		data['maxTemp'] = this.maxTemp;
		data['advTemp'] = this.advTemp;
		data['sideEffect'] = this.sideEffect;
		data['minPh'] = this.minPh;
		data['maxPh'] = this.maxPh;
		return data;
	}


}
