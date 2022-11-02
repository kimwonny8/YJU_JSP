package kjw59_mvc_beer3.model.beer;

public class BeerDTO {
	// java bean, 생성자와 게터세터 갖고있어야 함 -> DTO는 테이블 갯수만큼 만들어야 함
	private int b_id;
	private String b_code;
	private String b_category;
	private String b_name;
	private String b_country;
	private int b_price;
	private String b_alcohol;
	private String b_content;
	private int b_like;
	private int b_dislike;
	private String b_image;
	
	public BeerDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public BeerDTO(int b_id, String b_code, String b_category, String b_name, String b_country, int b_price,
			String b_alcohol, String b_content, int b_like, int b_dislike, String b_image) {
		super();
		this.b_id = b_id;
		this.b_code = b_code;
		this.b_category = b_category;
		this.b_name = b_name;
		this.b_country = b_country;
		this.b_price = b_price;
		this.b_alcohol = b_alcohol;
		this.b_content = b_content;
		this.b_like = b_like;
		this.b_dislike = b_dislike;
		this.b_image = b_image;
	}

	public int getB_id() {
		return b_id;
	}

	public void setB_id(int b_id) {
		this.b_id = b_id;
	}

	public String getB_code() {
		return b_code;
	}

	public void setB_code(String b_code) {
		this.b_code = b_code;
	}

	public String getB_category() {
		return b_category;
	}

	public void setB_category(String b_category) {
		this.b_category = b_category;
	}

	public String getB_name() {
		return b_name;
	}

	public void setB_name(String b_name) {
		this.b_name = b_name;
	}

	public String getB_country() {
		return b_country;
	}

	public void setB_country(String b_country) {
		this.b_country = b_country;
	}

	public int getB_price() {
		return b_price;
	}

	public void setB_price(int b_price) {
		this.b_price = b_price;
	}

	public String getB_alcohol() {
		return b_alcohol;
	}

	public void setB_alcohol(String b_alcohol) {
		this.b_alcohol = b_alcohol;
	}

	public String getB_content() {
		return b_content;
	}

	public void setB_content(String b_content) {
		this.b_content = b_content;
	}

	public int getB_like() {
		return b_like;
	}

	public void setB_like(int b_like) {
		this.b_like = b_like;
	}

	public int getB_dislike() {
		return b_dislike;
	}

	public void setB_dislike(int b_dislike) {
		this.b_dislike = b_dislike;
	}

	public String getB_image() {
		return b_image;
	}

	public void setB_image(String b_image) {
		this.b_image = b_image;
	}

	
	
}
