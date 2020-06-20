public class GoogleAPI {
    
    @AuraEnabled
    public static void getImageDetail(Id recordId) {    
        System.debug(recordId);
        List<String> imgTypeLst = new List<String>{'JPG','PNG','JPEG'};
        ContentDocumentLink conDocLink =[select id, LinkedEntityId,ContentDocumentId,
                                              ContentDocument.FileType,ContentDocument.Title
                                              From ContentDocumentLink 
                                              where LinkedEntityId=:recordId AND 
                                              ContentDocument.FileType IN :imgTypeLst limit 1];
        ContentVersion contentVersion = [SELECT id, ContentDocumentId, title,VersionData//,File_Detail__c
                                    FROM ContentVersion
                                    WHERE ContentDocumentId=:conDocLink.ContentDocumentId];
        
		//if(contentVersion.File_Detail__c==null)
        //{
        //    contentVersion.File_Detail__c = GoggleAPI.callImageApi(contentVersion.VersionData);
        //    if(contentVersion.File_Detail__c!=null)
        //    	update contentVersion;
        //}
    }//
    public static String callImageApi(Blob data) {   
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://vision.googleapis.com/v1/images:annotate?fields=responses&key=AIzaSyCSNbFOzBxYqiN4qlIVuzUmwYNiRWf7Rak');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;');
		String body = ''+
            '{\n'+
            	'"requests":[  '+
            		'{'+
            			/*'"image":{'+
            				'"source":{'+
            					'"imageUri":"'+EncodingUtil.base64Encode(conVerLst.VersionData)+'"'+
            				'},'+
            			'},'+*/
            			'"image":{'+
            				'"content":"'+EncodingUtil.base64Encode(data)+'"'+
            			'},'+
            			'"features":['+
            				'{"type":"FACE_DETECTION","maxResults":1},'+
            				'{"type":"LANDMARK_DETECTION","maxResults":1},'+
            				'{"type":"LOGO_DETECTION","maxResults":1},'+
            				'{"type":"LABEL_DETECTION","maxResults":1},'+
            				'{"type":"TEXT_DETECTION","maxResults":1},'+
            				'{"type":"DOCUMENT_TEXT_DETECTION","maxResults":1},'+
            				'{"type":"SAFE_SEARCH_DETECTION","maxResults":1},'+
            				'{"type":"IMAGE_PROPERTIES","maxResults":1},'+
            				'{"type":"CROP_HINTS","maxResults":1},'+
            				'{"type":"WEB_DETECTION","maxResults":1},'+
						']'+
            		'}'+
            	']'+
            '}';
        request.setBody(body);
        HttpResponse response = http.send(request);
        System.debug(response);
        system.debug('getStatusCode Code is : '+ response.getStatusCode());
        system.debug('getBody Code is : '+ response.getBody());
        system.debug('getHeaderKeys Code is : '+ response.getHeaderKeys());
        if (response.getStatusCode() == 200)
        {
            System.debug('response');
            System.debug(response.getBody());
            return response.getBody();
        }   
        else{
            System.debug('Error in Checksum WebService : ERROR'+response.getStatus()+' :: '+response.getStatusCode());
        	return null;
        }

	
    }
}