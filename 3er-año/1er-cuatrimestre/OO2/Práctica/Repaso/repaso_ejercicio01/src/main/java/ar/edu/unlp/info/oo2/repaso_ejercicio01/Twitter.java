package ar.edu.unlp.info.oo2.repaso_ejercicio01;

import java.util.ArrayList;
import java.util.List;

public class Twitter {
	
	private List<User> users;
	
	public Twitter() {
		this.users = new ArrayList<>();
	}

	public boolean registerUser(User user) {
		if (this.screenNameExists(user.getScreenName())) {
			System.out.print("El screenName del usuario ya está registrado.");
			return false;
		}
		this.users.add(user);
		return true;
	}
	
	public boolean deleteUser(String screenName) {
		User u = this.findUserByScreenName(screenName);
		if (u != null) {
			u.deletePosts();
			users.remove(u);
			return true;
		}
		System.out.print("El usuario con el screenName ingresado no existe.");
		return false;
	}
	
	private boolean screenNameExists(String screenName) {
		return users.stream()
				.anyMatch(u -> u.getScreenName().equals(screenName));
	}
	
	private User findUserByScreenName(String screenName) {
		return users.stream()
				.filter(u -> u.getScreenName().equals(screenName))
				.findFirst()
				.orElse(null);
	}
}
