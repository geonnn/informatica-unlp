package ar.edu.unlp.info.oo2.repaso_ejercicio01;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class User {
	
	private String screenName;
	private List<Post> posts;

	public User(String screenName) {
		this.screenName = screenName;
		this.posts = new ArrayList<>();
	}
	
	public String getScreenName() {
		return this.screenName;
	}
	
	public void post(Post post) {
		this.posts.add(post);
	}
	
	public List<Post> getPosts() {
		return Collections.unmodifiableList(this.posts);
	}
	
	public void deletePosts() {
		posts.clear();
	}
}
