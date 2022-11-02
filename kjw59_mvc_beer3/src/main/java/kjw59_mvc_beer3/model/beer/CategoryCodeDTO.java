package kjw59_mvc_beer3.model.beer;

public class CategoryCodeDTO {
	private String b_category;
	private String category_code;
	
	public CategoryCodeDTO() {
		super();
	}

	public CategoryCodeDTO(String b_category, String category_code) {
		super();
		this.b_category = b_category;
		this.category_code = category_code;
	}

	public String getB_category() {
		return b_category;
	}

	public void setB_category(String b_category) {
		this.b_category = b_category;
	}

	public String getCategory_code() {
		return category_code;
	}

	public void setCategory_code(String category_code) {
		this.category_code = category_code;
	}
	
	
}

