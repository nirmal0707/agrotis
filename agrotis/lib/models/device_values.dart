class DeviceValues  {
	String humidity;
	String lat;
	String light;
	String lng;
	String moisture;
	String ph;
	String temperature;
	String token;

	DeviceValues({this.humidity, this.lat, this.light, this.lng, this.moisture, this.ph, this.temperature, this.token});

	factory DeviceValues.fromJson(Map<String, dynamic> json) {
		return DeviceValues(
			humidity: json['Humidity'],
			lat: json['Lat'],
			light: json['Light'],
			lng: json['Lng'],
			moisture: json['Moisture'],
			ph: json['Ph'],
			temperature: json['Temperature'],
			token: json['Token'],
		);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Humidity'] = this.humidity;
		data['Lat'] = this.lat;
		data['Light'] = this.light;
		data['Lng'] = this.lng;
		data['Moisture'] = this.moisture;
		data['Ph'] = this.ph;
		data['Temperature'] = this.temperature;
		data['Token'] = this.token;
		return data;
	}


}
