package ar.edu.unlp.info.oo2.repaso_ejercicio01;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import ar.edu.unlp.info.oo2.repaso_ejercicio01.Tweet;

class TweetTest {

	@Test
	void testCreateTweetEmptyText() {
		assertThrows(IllegalArgumentException.class, () -> {
			new Tweet("");
		});
	}
	
	@Test
	void testCreateTweetLongText() {
		String text281 = "a".repeat(281);
		assertThrows(IllegalArgumentException.class, () -> {
			new Tweet(text281);
		});
	}

}
