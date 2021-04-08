class CropRequest  {
	String id;
	String crop;

	CropRequest({this.id, this.crop});

	factory CropRequest.fromJson(Map<String, dynamic> json) {
		return CropRequest(
			id: json['id'],
			crop: json['crop'],
		);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['crop'] = this.crop;
		return data;
	}


}
