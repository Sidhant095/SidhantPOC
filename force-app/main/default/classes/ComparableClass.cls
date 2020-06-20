public class ComparableClass {
	public static void compareFunction(){
        List<ComparableWrapperClass> cWCList = new List<ComparableWrapperClass>();
        ComparableWrapperClass cWC;
        for(Integer i = 10; i > 0;--i){
            cWC = new ComparableWrapperClass('a'+i,String.valueof(i)+'a',1+i,'a'+i,'a'+i);
            cWCList.add(cWC);
        }
        ComparableWrapperClass.fieldName1 = 'firstname';
        
        System.debug('****Before Sort****');
        for(ComparableWrapperClass temp: cWCList){
            System.debug(JSON.serialize(temp));
        }
        System.debug('****Sorting****');
        cWCList.sort();
        System.debug('****After Sort****');
        for(ComparableWrapperClass temp: cWCList){
            System.debug(JSON.serialize(temp));
        }
        
        
        
        ComparableWrapperClass.fieldName1 = 'lastname';
        
        System.debug('****Before Sort****');
        for(ComparableWrapperClass temp: cWCList){
            System.debug(JSON.serialize(temp));
        }
        System.debug('****Sorting****');
        cWCList.sort();
        System.debug('****After Sort****');
        for(ComparableWrapperClass temp: cWCList){
            System.debug(JSON.serialize(temp));
        }
    }
}