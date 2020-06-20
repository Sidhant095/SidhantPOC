public class JsonGenerator {
    public static void generateJSONContent() {
        
        
        /*
{ 
"ZTABLE" : "002" ,
"KAPPL" : "V",
"VKORG" : "0275",
"VTWEG" : "01",
"WERKS" : "6506",
"VRKME" : "EA",
"ARTICLE" : [ 
    { "ARTICLE" : "600333964001 "},
    { "ARTICLE" : "600323472 "},
	{ "ARTICLE" : "600390568001 "}
],
"COND_TYPE" : [ 
	{ "KSCHL" : "ZKP0" },
	{ "KSCHL" : "ZMRP" }
]
}
*/
        // Create a JSONGenerator object.
        // Pass true to the constructor for pretty print formatting.
        System.JSONGenerator  gen = JSON.createGenerator(false);
        List<String> stringList = new List<String>();
        stringList.add('600333964001');
        stringList.add('600323472');
        stringList.add('600390568001');        
        // Write data to the JSON string.
        gen.writeStartObject();
        gen.writeStringField('ZTABLE', '002');
        gen.writeStringField('KAPPL', 'V');
        gen.writeStringField('VKORG', '0275');
        gen.writeStringField('VTWEG', '01');
        gen.writeStringField('WERKS', '6506');
        gen.writeStringField('VRKME', 'EA');
        gen.writeFieldName('ARTICLE');
        gen.writeStartArray();
        for(String str: stringList){
            gen.writeStartObject();
        		gen.writeStringField('ARTICLE', str);
        	gen.writeEndObject();
        }
        gen.writeEndArray();
        
        stringList = new List<String>();
        stringList.add('ZKP0');
        stringList.add('ZMRP');
        gen.writeFieldName('COND_TYPE');
        gen.writeStartArray();
        for(String str: stringList){
            gen.writeStartObject();
        		gen.writeStringField('KSCHL', str);
        	gen.writeEndObject();
        }
        gen.writeEndArray();
                //gen.writeObject();
        
        gen.writeEndObject();
        
        // Get the JSON string.
        String pretty = gen.getAsString();
        System.debug('pretty: '+pretty);
    }
}