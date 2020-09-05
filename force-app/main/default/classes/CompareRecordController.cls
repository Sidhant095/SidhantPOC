public with sharing class CompareRecordController {
    static Map<String,List<String>> obj_FieldsList_Map = new Map<String,List<String>>();
    private class WrapperClass{
        List<String> objectFieldsList;
        SObject sObjectRecord;
        String objectName;
    }
    @AuraEnabled
    public static String getObjectDetail(String objIdString){
        Id objId = (Id)objIdString;
        String objectName = objId.getSObjectType().getDescribe().getName();
        if(!obj_FieldsList_Map.containsKey(objectName)){
            obj_FieldsList_Map.put(objectName,getObjectFields(objectName));
        }
        WrapperClass response = new WrapperClass();
        response.sObjectRecord = recordDetail(objectName,objId);
        response.objectName = objectName;
        response.objectFieldsList = obj_FieldsList_Map.get(objectName);
        return JSON.serialize(response);
    }
    private static sObject recordDetail(String objectName, Id objId){
        List<String> fieldList = obj_FieldsList_Map.get(objectName);
        String toQuery = 'SELECT ';
        for (String fieldName : fieldList) {
            toQuery+=fieldName+',';
        }
        toQuery = toQuery.removeEnd(',')+' FROM '+objectName+' WHERE Id = :objId';
        List<sObject> recordList = Database.query(toQuery);
        if(!recordList.isEmpty()){
            return recordList[0];
        }
        return null;
    }
    private static List<String> getObjectFields(String objectName){
        List<String> fieldList = new List<String>();
        for(Schema.SObjectField sfield: Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap().values()){
            fieldList.add(sfield.getDescribe().getname());
        }
        System.debug(fieldList);
        return fieldList;
    }
}