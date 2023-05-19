public with sharing class Utils {
    public static boolean validaCPF(String CPF) {

        if(CPF == null || CPF.length() != 11 || !CPF.containsOnly('1234567890')) {
            return false;
        }

        Integer sum = 0, peso = 10, digitTen, digitEleven, r, num;

        List<String> cpfString = CPF.split('');
        
        for (Integer i=0; i<9; i++) {
            num = Integer.valueOf(cpfString[i]); 
            sum = sum + (num * peso);
            peso = peso - 1;
        }

        r = 11 - (math.mod(sum,11));
        if ((r == 10) || (r == 11)) {
            digitTen = 0;
        }
        else {
            digitTen = r;
        } 

        sum = 0;
        peso = 11;
        for(Integer i=0; i<10; i++) {
            num = Integer.valueOf(cpfString[i]);
            sum = sum + (num * peso);
            peso = peso - 1;
        }

        r = 11 - (math.mod(sum,11));
        if ((r == 10) || (r == 11)) {
            digitEleven = 0;
        }
        else {
            digitEleven = r;
        }

        return (digitTen == Integer.valueOf(cpfString[9]) && digitEleven == Integer.ValueOf(cpfString[10]));
    }

    public static boolean validaCNPJ(String CNPJ) {

        if(CNPJ == null || CNPJ.length() != 14 || !CNPJ.containsOnly('1234567890')) {
            return false;
        }

        Integer sum = 0, peso = 2, r, num, digitThirteen, digitFourteen;
        List<String> cnpjString = CNPJ.split('');

        for (Integer i=11; i>=0; i--) {
            num = Integer.valueOf(cnpjString[i]);
            sum = sum + (num * peso);
            peso = peso + 1;
            if (peso == 10)
            peso = 2;
        }

        r = math.mod(sum, 11);
        if ((r == 0) || (r == 1)) {
            digitThirteen = 0;
        }
        else {
            digitThirteen = Integer.valueOf(11-r);
        } 

        sum = 0;
        peso = 2;
        for (Integer i=12; i>=0; i--) {
            num = Integer.valueOf(cnpjString[i]);
            sum = sum + (num * peso);
            peso = peso + 1;
            if (peso == 10)
            peso = 2;
        }

        r = math.mod(sum, 11);
        if ((r == 0) || (r == 1)) {
            digitFourteen = 0;
        }
        else {
            digitFourteen = Integer.valueOf(11-r);
        }

        return (digitThirteen == Integer.valueOf(cnpjString[12]) && digitFourteen == Integer.valueOf(cnpjString[13]));
    }
}