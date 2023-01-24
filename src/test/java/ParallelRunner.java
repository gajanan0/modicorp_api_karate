import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import org.junit.Test;

import static org.junit.Assert.assertTrue;

class ParallelRunner {

    @Karate.Test
    void testParallel(){
        Results results = Runner.path("classpath:biller").parallel(5);
        assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
    }
}
