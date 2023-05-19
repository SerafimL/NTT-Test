@isTest
public class UtilsTest {
    @isTest
    static void validaCPFTest() {
        System.assertEquals(true, Utils.validaCPF('81408761009'));
        System.assertEquals(true, Utils.validaCPF('17432361070'));
        System.assertEquals(true, Utils.validaCPF('88605293012'));  
        System.assertEquals(false, Utils.validaCPF('886052930121'));  
        System.assertEquals(false, Utils.validaCPF('886052931'));  
        System.assertEquals(false, Utils.validaCPF('886052931a'));  
        System.assertEquals(false, Utils.validaCPF('11111222333'));  
    }

    @isTest
    static void validaCNPJTest() {
        System.assertEquals(true, Utils.validaCNPJ('31059993000109'));
        System.assertEquals(true, Utils.validaCNPJ('56613118000140'));
        System.assertEquals(true, Utils.validaCNPJ('21134810000100'));
        System.assertEquals(true, Utils.validaCNPJ('54562808000191'));
        System.assertEquals(false, Utils.validaCNPJ('545628080001911'));
        System.assertEquals(false, Utils.validaCNPJ('5456280800019'));
        System.assertEquals(false, Utils.validaCNPJ('5456280800019a'));
        System.assertEquals(false, Utils.validaCNPJ('54562808000190'));
    }
}