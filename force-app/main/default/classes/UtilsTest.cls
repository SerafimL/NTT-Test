@isTest
public class UtilsTest {
    @isTest
    static void validaCPFTest() {
        System.assertEquals(true, Utils.validaCPF('81408761009'));
        System.assertEquals(true, Utils.validaCPF('17432361070'));
        System.assertEquals(true, Utils.validaCPF('88605293012'));   
    }

    @isTest
    static void validaCNPJTest() {
        System.assertEquals(true, Utils.validaCNPJ('31059993000109'));
        System.assertEquals(true, Utils.validaCNPJ('56613118000140'));
        System.assertEquals(true, Utils.validaCNPJ('21134810000100'));
        System.assertEquals(true, Utils.validaCNPJ('54562808000191'));
    }
}