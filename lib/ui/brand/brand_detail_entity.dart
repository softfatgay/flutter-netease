class BrandDetailEntity {
	BrandDetailBrand brand;

	BrandDetailEntity({this.brand});

	BrandDetailEntity.fromJson(Map<String, dynamic> json) {
		brand = json['brand'] != null ? new BrandDetailBrand.fromJson(json['brand']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
		return data;
	}
}

class BrandDetailBrand {
	int isNew;
	String appListPicUrl;
	String name;
	String simpleDesc;
	int id;
	String listPicUrl;
	String picUrl;
	int sortOrder;
	var floorPrice;
	int newSortOrder;
	int isShow;
	String newPicUrl;

	BrandDetailBrand({this.isNew, this.appListPicUrl, this.name, this.simpleDesc, this.id, this.listPicUrl, this.picUrl, this.sortOrder, this.floorPrice, this.newSortOrder, this.isShow, this.newPicUrl});

	BrandDetailBrand.fromJson(Map<String, dynamic> json) {
		isNew = json['is_new'];
		appListPicUrl = json['app_list_pic_url'];
		name = json['name'];
		simpleDesc = json['simple_desc'];
		id = json['id'];
		listPicUrl = json['list_pic_url'];
		picUrl = json['pic_url'];
		sortOrder = json['sort_order'];
		floorPrice = json['floor_price'];
		newSortOrder = json['new_sort_order'];
		isShow = json['is_show'];
		newPicUrl = json['new_pic_url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['is_new'] = this.isNew;
		data['app_list_pic_url'] = this.appListPicUrl;
		data['name'] = this.name;
		data['simple_desc'] = this.simpleDesc;
		data['id'] = this.id;
		data['list_pic_url'] = this.listPicUrl;
		data['pic_url'] = this.picUrl;
		data['sort_order'] = this.sortOrder;
		data['floor_price'] = this.floorPrice;
		data['new_sort_order'] = this.newSortOrder;
		data['is_show'] = this.isShow;
		data['new_pic_url'] = this.newPicUrl;
		return data;
	}
}
