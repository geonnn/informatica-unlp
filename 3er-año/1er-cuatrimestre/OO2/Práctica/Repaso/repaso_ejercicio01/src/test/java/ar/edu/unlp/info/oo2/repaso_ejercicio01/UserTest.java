package ar.edu.unlp.info.oo2.repaso_ejercicio01;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import ar.edu.unlp.info.oo2.repaso_ejercicio01.Retweet;
import ar.edu.unlp.info.oo2.repaso_ejercicio01.Tweet;
import ar.edu.unlp.info.oo2.repaso_ejercicio01.User;

class UserTest {
	
	private User u;

	@BeforeEach
	void setUp() {
		this.u = new User("juan");
	}
	
	@Test
	void testPost() {
		Tweet tw1 = new Tweet("hola soy juan");
		Tweet tw2 = new Tweet(":)");
		Retweet rt = new Retweet(tw2);
		u.post(tw1);
		u.post(rt);
		assertEquals(u.getPosts().size(), 2);
	}
	
	@Test
	void testDeletePosts() {
		Tweet tw1 = new Tweet("hola soy juan");
		u.post(tw1);
		assertEquals(u.getPosts().size(), 1);
		u.deletePosts();
		assertEquals(u.getPosts().size(), 0);
	}

}
