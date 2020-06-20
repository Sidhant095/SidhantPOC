global class ComparableWrapperClass implements Comparable {
    String firstname;
    String lastname;
    Integer uniqueNo;
    String address;
    String fullName;
    public Static String fieldName1;
    public String fieldName;
    public ComparableWrapperClass(String fieldName){
        this.fieldName = fieldName;
    }
    public Static Integer count = 0;
    public ComparableWrapperClass(String firstname,String lastname,Integer uniqueNo,String address,String fullName){
        this.firstname = firstname;
        this.lastname = lastname;
        this.uniqueNo = uniqueNo;
        this.address = address;
        this.fullName = fullName;
    }
    global Object getX(String param_name){
        String json_instance = Json.serialize(this);
        Map<String, Object> untyped_instance;
        untyped_instance= (Map<String, Object>)JSON.deserializeUntyped(json_instance);
        return untyped_instance.get(param_name);
    }
    
    global Integer compareTo(Object obj){
        System.debug(count++ + ', '+JSON.serialize(obj));
        ComparableWrapperClass cWC = (ComparableWrapperClass)obj;
        if((String)this.getX(fieldName) == (String)cWC.getX(fieldName))
            return 0;
        else if((String)this.getX(fieldName) > (String)cWC.getX(fieldName))
            return 1;
        return -1;
    }
}