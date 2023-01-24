import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import org.junit.Test;

import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.assertEquals;

class ParallelRunner {

    @Karate.Test
    void testParallel(){
        Results results = Runner.path("classpath:biller").tags("~@positive").parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
