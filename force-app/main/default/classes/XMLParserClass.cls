public class XMLParserClass {
    private Boolean isParsed = false;
    public Object parsedXML;
    private object parseXML(Dom.XMLNode xmlNode){
        Map<Object,Object> toTest = new Map<Object,Object>();
        if(xmlNode.getChildElements().size()>0){
            for(Dom.XMLNode child : xmlNode.getChildElements()){
                if(toTest.containsKey(child.getName())){
                    Object tempObj = toTest.get(child.getName());
                    List<Object> tempObjList;
                    if(isList(tempObj)){
                        tempObjList = (List<Object>)tempObj;
                    }else{
                        tempObjList = new List<Object>();
                    }
                    tempObjList.add(parseXML(child));
                    toTest.put(child.getName(),tempObjList);
                }else{
                    toTest.put(child.getName(),parseXML(child));
                }
                
                //System.debug('**iteration: '+i+' : '+child.getName());
            }
        }
        else{
            //toTest.put(xmlNode.getName(),xmlNode.getText());
            //System.debug('iteration: '+i+' : '+xmlNode.getName());
            //return toTest;
            return xmlNode.getText();
            
        }
        //System.debug('iteration: '+i+' : '+toTest);
        return toTest;
        
    }
    private object parseXML(String toParse){
        //System.debug(toParse.length());
        // Create Doc Document
        DOM.Document doc = new DOM.Document();
        doc.load(toParse);
        //System.debug('doc: '+doc);
        Dom.XMLNode address = doc.getRootElement();
        Map<Object,Object> toTest = new Map<Object,Object>();
        for(Dom.XMLNode child : address.getChildElements()){
            toTest.put(child.getName(),parseXML(child));
        }
        //System.debug('Final iteration: '+toTest);
        return toTest;
      
        
    }
    public List<Map<String,Object>> parse(String toParse,List<String> pathList,List<String> fieldsToReturn){
        System.debug('isParsed: '+isParsed);
        if(!isParsed){
            parsedXML = parseXML(toParse);
            isParsed = true;
        }
        Object tempParsedXML = (Map<Object,Object>)parsedXML;
        System.debug('parsedXML: '+parsedXML);
        for(String path:pathList){
            System.debug('path '+path);
            //tempParsedXML = tempParsedXML!=null?tempParsedXML:(Map<Object,Object>)parsedXML;
            //System.debug('tempParsedXML '+tempParsedXML);
            Map<Object,Object> objMap;
            if(tempParsedXML!=null && isList(tempParsedXML)){
                tempParsedXML = tempParsedXML;
                System.debug('**Array tempParsedXML '+tempParsedXML);
            }else if(tempParsedXML!=null && isMap(tempParsedXML)){
                objMap = (Map<Object,Object>)tempParsedXML;
                tempParsedXML = objMap.containsKey(path)?objMap.get(path):null;
                System.debug('**Map tempParsedXML '+tempParsedXML);
            }else{
                System.debug('Some error in path');
            }
            
        }
        List<Map<String,Object>> toReturnMapList = new List<Map<String,Object>>();
        Map<String,Object> toReturnMap;
        List<Object> objListToParse;
        if(tempParsedXML!=null && isList(tempParsedXML)){
            objListToParse = (List<Object>)tempParsedXML;
        }else{
            objListToParse = new List<Object>{tempParsedXML};
                }
        for(Object tempObj : objListToParse){
            //System.debug('tempObj '+tempObj);
            if(tempObj!=null && isMap(tempObj)){
                Map<Object,Object> objMap = (Map<Object,Object>) tempObj;
                toReturnMap = new Map<String,Object>();
                for(String field:fieldsToReturn){
                    //System.debug('field '+field);
                    if(objMap.containsKey(field)){
                        //System.debug('objMap.get(field) '+objMap.get(field));
                        toReturnMap.put(field, objMap.get(field));
                    }
                }
                toReturnMapList.add(toReturnMap);
            }
        }
        return toReturnMapList;
    }
    public Boolean isList(Object input)
    {
        Object test;
        try{
            test = (List<Object>)input;
            return true;
        }
        catch(System.TypeException ex){}
        return false;
    }
    public static Boolean isMap(Object input)
    {
        Object test;
        try{
            test = (Map<Object,Object>)input;
            return true;
        }
        catch(System.TypeException ex){}
        return false;
    }
    
}
/*
//XMLParserClass.tempRunning();


Map<Object,Object> abc = new Map<Object,Object>{1=>1,2=>2,3=>3};
Map<Object,Object> abc1 = new Map<Object,Object>();
List<Object> x = new List<Object>{'a',1};
System.debug(x);
abc1.put('a',abc);
abc1.put('arr',x);
System.debug(abc1);
System.debug('IsList: '+XMLParserClass.isList(abc));
System.debug('IsMap: '+XMLParserClass.isMap(abc));
Object toCheck = x;
if(XMLParserClass.isList(toCheck)){
List<Object> q = (List<Object>)toCheck;
System.debug('isList '+q);
}else if(XMLParserClass.isMap(abc)){
Map<Object,Object> q = (Map<Object,Object>)toCheck;
System.debug('isMap'+q);
}else{
Object q = toCheck;
System.debug('isObj '+q);
}
*/
        /*
System.debug('address: '+address);
System.debug('getAttributeCount: '+address.getAttributeCount());
System.debug('getName: '+address.getName());
System.debug('getText: '+address.getText());

System.debug('getNodeType: '+address.getNodeType());
System.debug('getChildren: '+address.getChildren());
System.debug('getChildElements: '+address.getChildElements());
System.debug('getChildElement('+address.getName()+',null): '+address.getChildElement(address.getName(),null));
for(Dom.XMLNode child : address.getChildElements()){
System.debug('*: '+child);
System.debug('*getAttributeCount: '+child.getAttributeCount());
System.debug('*getName: '+child.getName());
System.debug('*getText: '+child.getText());
System.debug('*getNodeType: '+child.getNodeType());
System.debug('*getChildren: '+child.getChildren());
System.debug('*getChildElements: '+child.getChildElements());
System.debug('*getChildElement('+child.getName()+',null): '+child.getChildElement(child.getName(),null));
for(Dom.XMLNode innerchild : child.getChildElements()){
System.debug('**: '+innerchild);
System.debug('**getAttributeCount: '+innerchild.getAttributeCount());
System.debug('**getName: '+innerchild.getName());
System.debug('**getText: '+innerchild.getText());
System.debug('**getNodeType: '+innerchild.getNodeType());
System.debug('**getChildren: '+innerchild.getChildren());
System.debug('**getChildElements: '+innerchild.getChildElements());
System.debug('**getChildElement('+innerchild.getName()+',null): '+innerchild.getChildElement(innerchild.getName(),null));
for(Dom.XMLNode innerinnerchild : innerchild.getChildElements()){
System.debug('***: '+innerinnerchild);
System.debug('***getAttributeCount: '+innerinnerchild.getAttributeCount());
System.debug('***getName: '+innerinnerchild.getName());
System.debug('***getText: '+innerinnerchild.getText());
System.debug('***getNodeType: '+innerinnerchild.getNodeType());
System.debug('***getChildren: '+innerinnerchild.getChildren());
System.debug('***getChildElements: '+innerinnerchild.getChildElements());
System.debug('***getChildElements.size(): '+innerinnerchild.getChildElements().size());
System.debug('***getChildElement('+innerinnerchild.getName()+',null): '+innerinnerchild.getChildElement(innerinnerchild.getName(),null));
for(Dom.XMLNode iiichild : innerinnerchild.getChildElements()){
System.debug('****: '+iiichild);
System.debug('****getAttributeCount: '+iiichild.getAttributeCount());
System.debug('****getName: '+iiichild.getName());
System.debug('****getText: '+iiichild.getText());
System.debug('****getNodeType: '+iiichild.getNodeType());
System.debug('****getChildren: '+iiichild.getChildren());
System.debug('****getChildElements.size(): '+iiichild.getChildElements().size());
System.debug('****getChildElements: '+iiichild.getChildElements());
System.debug('****getChildElement('+iiichild.getName()+',null): '+iiichild.getChildElement(iiichild.getName(),null));
for(Dom.XMLNode iiiichild : iiichild.getChildElements()){
System.debug('*****: '+iiiichild);
System.debug('*****getAttributeCount: '+iiiichild.getAttributeCount());
System.debug('*****getName: '+iiiichild.getName());
System.debug('*****getText: '+iiiichild.getText());
System.debug('*****getNodeType: '+iiiichild.getNodeType());
System.debug('*****getChildren: '+iiiichild.getChildren());
System.debug('*****getChildElements.size(): '+iiiichild.getChildElements().size());
System.debug('*****getChildElements: '+iiiichild.getChildElements());
System.debug('*****getChildElement('+iiiichild.getName()+',null): '+iiiichild.getChildElement(iiiichild.getName(),null));
}
}
}
}
}

*/