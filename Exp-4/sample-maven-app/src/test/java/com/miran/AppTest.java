package com.miran;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class AppTest {

    @Test
    void testAdd() {
        assertEquals(5, App.add(2, 3), "2 + 3 should equal 5");
        assertEquals(0, App.add(0, 0), "0 + 0 should equal 0");
        assertEquals(-2, App.add(-1, -1), "-1 + -1 should equal -2");
    }
}
