package modicorp.biller;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;

import com.intuit.karate.junit5.Karate;

import static org.junit.Assert.assertTrue;


public class TestRunner
{

    @Karate.Test
    Karate testUsers() {return Karate.run("biller").relativeTo(getClass());}

}
