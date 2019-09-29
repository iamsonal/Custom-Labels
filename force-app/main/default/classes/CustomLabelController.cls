public with sharing class CustomLabelController {

    public static String sessionId;
    public static List<ResponseWrapper.Record> records;

    @AuraEnabled(cacheable=true)
    public static String retrieveCustomLabels(String resourcePath) {

        if (resourcePath == null) {
            resourcePath = '/services/data/v46.0/tooling/query/?q=Select+id,Name,Value+from+CustomLabel';
        }
        ResponseWrapper wrapper = callAPI(resourcePath);
        if (records == null) {
            records = wrapper.records;
        } else {
            records.addAll(wrapper.records);
        }
        if (!wrapper.done) {
            retrieveCustomLabels(wrapper.nextRecordsUrl);
        }
        return JSON.serialize(records);
    }

    public static ResponseWrapper callAPI(String resourcePath) {
        if (sessionId == null) {
            sessionId = getSessionIdFromVFPage();
        }
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + sessionId);
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + resourcePath);
        req.setMethod('GET');

        Http h = new Http();
        HttpResponse res = h.send(req);
        ResponseWrapper wrapper = (ResponseWrapper)System.JSON.deserialize(res.getBody(), ResponseWrapper.class);
        return wrapper;
    }

    public static String getSessionIdFromVFPage() {
        if(Test.isRunningTest()) {
            return 'SESSION_ID';
        } else {
            String SESSION_ID_START = 'SESSION_ID_START';
            String SESSION_ID_END = 'SESSION_ID_END';
            String pageContent = Page.SessionId.getContent().toString();
            Integer startIndex = pageContent.indexOf(SESSION_ID_START) + SESSION_ID_START.length();
            Integer endIndex = pageContent.indexOf(SESSION_ID_END);
            return pageContent.substring(startIndex, endIndex);
        }
    }
}
