package kjw59_mvc_beer3.model.beer;

public class BeerImageDTO {
	private String i_file_name;
	private String i_original_name;
	private String i_thumbnail_name;
	private String i_file_type;
	private int b_id;
	
	public BeerImageDTO() {
		super();
	}

	public BeerImageDTO(String i_file_name, String i_original_name, String i_thumbnail_name, String i_file_type, int b_id) {
		super();
		this.i_file_name = i_file_name;
		this.i_original_name = i_original_name;
		this.i_thumbnail_name = i_thumbnail_name;
		this.i_file_type = i_file_type;
		this.b_id = b_id;
	}
	
	public String getI_file_name() {
		return i_file_name;
	}

	public void setI_file_name(String i_file_name) {
		this.i_file_name = i_file_name;
	}

	public String getI_original_name() {
		return i_original_name;
	}

	public void setI_original_name(String i_original_name) {
		this.i_original_name = i_original_name;
	}

	public String getI_thumbnail_name() {
		return i_thumbnail_name;
	}

	public void setI_thumbnail_name(String i_thumbnail_name) {
		this.i_thumbnail_name = i_thumbnail_name;
	}

	public String getI_file_type() {
		return i_file_type;
	}

	public void setI_file_type(String i_file_type) {
		this.i_file_type = i_file_type;
	}

	public int getB_id() {
		return b_id;
	}

	public void setB_id(int b_id) {
		this.b_id = b_id;
	}
}
