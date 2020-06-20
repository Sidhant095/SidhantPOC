public class RandomStringGenerator {
    public void getRandomString(Integer upperLimit,Integer size){
        if(upperLimit==null)
            upperLimit = 26;
        if(size==null)
            size = 150;
        Integer rand;
        List<Integer> intToCharCap = new List<Integer>();
        List<Integer> intToCharSmall = new List<Integer>();
        for(Integer i = 0 ; i < size ; i++){
            rand = Math.round(Math.random()*1000);
            intToCharSmall.add(Math.mod(rand, upperLimit)+97);
            intToCharCap.add(Math.mod(rand, upperLimit)+65);
        }
        System.debug(intToCharCap);
        System.debug(String.fromCharArray(intToCharCap));
        System.debug(intToCharSmall);
        System.debug(String.fromCharArray(intToCharSmall));
    }
}