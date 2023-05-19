public with sharing class Utils {
    public static boolean validaCPF(String CPF) {

        Integer sum = 0, peso = 10, digitTen, digitEleven, r, num;

        List<String> cpfString = cpf.split('');
        
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

        Integer sum = 0, peso = 2, r, num, digtThirteen, digtFourteen;
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
            digtThirteen = 0;
        }
        else {
            digtThirteen = Integer.valueOf(11-r);
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
            digtFourteen = 0;
        }
        else {
            digtFourteen = Integer.valueOf(11-r);
        }

        return (digtThirteen == Integer.valueOf(cnpjString[12]) && digtFourteen == Integer.valueOf(cnpjString[13]));
    }
}