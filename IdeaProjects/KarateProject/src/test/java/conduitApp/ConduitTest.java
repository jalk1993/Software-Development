package conduitApp;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.KarateOptions;

@KarateOptions( tags = {"@debug", "@regression"})
class ConduitTest {
    
    // this will run all *.feature files that exist in sub-directories
    // see https://github.com/intuit/karate#naming-conventions   
    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }
    
}
