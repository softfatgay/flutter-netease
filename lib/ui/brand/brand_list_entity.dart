class BrandListEntity {
	List<BrandListData> data;
	int count;
	int totalPages;
	List<BrandListFiltercategory> filterCategory;
	List<BrandListGoodslist> goodsList;
	int pageSize;
	int currentPage;

	BrandListEntity({this.data, this.count, this.totalPages, this.filterCategory, this.goodsList, this.pageSize, this.currentPage});

	BrandListEntity.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			data = new List<BrandListData>();(json['data'] as List).forEach((v) { data.add(new BrandListData.fromJson(v)); });
		}
		count = json['count'];
		totalPages = json['totalPages'];
		if (json['filterCategory'] != null) {
			filterCategory = new List<BrandListFiltercategory>();(json['filterCategory'] as List).forEach((v) { filterCategory.add(new BrandListFiltercategory.fromJson(v)); });
		}
		if (json['goodsList'] != null) {
			goodsList = new List<BrandListGoodslist>();(json['goodsList'] as List).forEach((v) { goodsList.add(new BrandListGoodslist.fromJson(v)); });
		}
		pageSize = json['pageSize'];
		currentPage = json['currentPage'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['count'] = this.count;
		data['totalPages'] = this.totalPages;
		if (this.filterCategory != null) {
      data['filterCategory'] =  this.filterCategory.map((v) => v.toJson()).toList();
    }
		if (this.goodsList != null) {
      data['goodsList'] =  this.goodsList.map((v) => v.toJson()).toList();
    }
		data['pageSize'] = this.pageSize;
		data['currentPage'] = this.currentPage;
		return data;
	}
}

class BrandListData {
	String name;
	int id;
	String listPicUrl;
	int retailPrice;

	BrandListData({this.name, this.id, this.listPicUrl, this.retailPrice});

	BrandListData.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		id = json['id'];
		listPicUrl = json['list_pic_url'];
		retailPrice = json['retail_price'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['id'] = this.id;
		data['list_pic_url'] = this.listPicUrl;
		data['retail_price'] = this.retailPrice;
		return data;
	}
}

class BrandListFiltercategory {
	String name;
	bool checked;
	int id;

	BrandListFiltercategory({this.name, this.checked, this.id});

	BrandListFiltercategory.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		checked = json['checked'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['checked'] = this.checked;
		data['id'] = this.id;
		return data;
	}
}

class BrandListGoodslist {
	String name;
	int id;
	String listPicUrl;
	int retailPrice;

	BrandListGoodslist({this.name, this.id, this.listPicUrl, this.retailPrice});

	BrandListGoodslist.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		id = json['id'];
		listPicUrl = json['list_pic_url'];
		retailPrice = json['retail_price'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['id'] = this.id;
		data['list_pic_url'] = this.listPicUrl;
		data['retail_price'] = this.retailPrice;
		return data;
	}
}
