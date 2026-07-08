package objetosdos;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class CharRingTest {
    CharRing cr;

    @Test
    public void testNext() {
        cr = new CharRing("ring");
        assertEquals('r', cr.next());
        assertEquals('i', cr.next());
        assertEquals('n', cr.next());
        assertEquals('g', cr.next());
        assertEquals('r', cr.next());
    }
}
