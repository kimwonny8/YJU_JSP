package kjw59_mvc_beer4.controller.beer;

public class ActionForward {
	
	private boolean isRedirect = false; // false => 처리하고 보내겠다, true => 바로 보내겠다
	private String path = null;
	
	public boolean isRedirect() {
		return this.isRedirect;
	}
	
	public String getPath() {
		return this.path;
	}

	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}

	public void setPath(String path) {
		this.path = path;
	}
	
	
}
