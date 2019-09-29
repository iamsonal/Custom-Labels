public with sharing class ResponseWrapper {
    public Boolean done {get; set;}
    public String nextRecordsUrl {get; set;}
    public List<Record> records {get; set;}

    public class Record {
        public String Id {get; set;}
        public String Name {get; set;}
        public String Value {get; set;}
    }
}
