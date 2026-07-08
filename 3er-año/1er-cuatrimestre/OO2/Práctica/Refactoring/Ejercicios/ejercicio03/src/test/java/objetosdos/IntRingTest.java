package objetosdos;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class IntRingTest {
    IntRing ir;

    @Test
    public void testNext() {
        ir = new IntRing(new int[] {1, 2, 3});
        assertEquals(1, ir.next());
        assertEquals(2, ir.next());
        assertEquals(3, ir.next());
        assertEquals(1, ir.next());
    }
}
