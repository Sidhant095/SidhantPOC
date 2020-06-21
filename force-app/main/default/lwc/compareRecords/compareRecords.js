import { LightningElement, track } from 'lwc';
import getObjectDetail from '@salesforce/apex/CompareRecordController.getObjectDetail';


export default class CompareRecords extends LightningElement {
    object_keyValues;
    @track object_keyValues_Flat;
    sObjectId;
    handleKeyChange(event) {
        console.log('handleKeyChange')
        this.sObjectId = event.target.value;
    }
    handleSubmit() {
        console.log('handleSubmit')
        if (!this.sObjectId) {
            console.log('Do Not Call Apex');
        }
        getObjectDetail({ objIdString: this.sObjectId })
            .then((result) => {
                var obj = JSON.parse(result)
                console.log('obj: ', obj);
                if (this.object_keyValues) {
                    let index = this.object_keyValues.findIndex((objectRecord) => {
                        return objectRecord.objectName === obj.objectName;
                    })
                    console.log('index: ', index)
                    if (index > -1) {
                        console.log('this.object_keyValues[index]: ', this.object_keyValues[index])
                        console.log('this.object_keyValues[index].data: ', this.object_keyValues[index].data)
                        // eslint-disable-next-line guard-for-in
                        for (let fieldName in this.object_keyValues[index].data) {
                            this.object_keyValues[index].data[fieldName].push(obj.sObjectRecord[fieldName]);
                        }
                        this.object_keyValues[index].header = this.object_keyValues[index].data.Name;
                    } else {
                        let newObjMap = {};
                        newObjMap.objectName = obj.objectName;
                        let data = {};
                        obj.objectFieldsList.forEach(fieldName => {
                            data[fieldName] = [];
                            data[fieldName].push(obj.sObjectRecord[fieldName]);
                        });
                        newObjMap.data = data;
                        newObjMap.header = data.Name;
                        this.object_keyValues.push(newObjMap);
                    }
                } else {
                    let newObjMap = {};
                    newObjMap.objectName = obj.objectName;
                    let data = {};
                    obj.objectFieldsList.forEach(fieldName => {
                        data[fieldName] = [];
                        data[fieldName].push(obj.sObjectRecord[fieldName]);
                    });
                    newObjMap.data = data;
                    newObjMap.header = data.Name;
                    this.object_keyValues = [newObjMap];
                }
                this.object_keyValues_Flat = [];
                let rowCounter=0;
                let columnCounter=0;
                this.object_keyValues.forEach((objectWrapper) => {
                    let flatWrapper = {};
                    flatWrapper.data = []
                    // eslint-disable-next-line guard-for-in
                    for (let fieldName in objectWrapper.data) {
                        //console.log(fieldName);
                        let tempObj = {}
                        tempObj.key = fieldName;
                        tempObj.rowCounter = ++rowCounter;
                        tempObj.values = [];
                        // eslint-disable-next-line no-loop-func
                        objectWrapper.data[fieldName].forEach((data)=>{
                            let tempColumnObj = {}
                            tempColumnObj.value = data;
                            tempColumnObj.columnCounter = ++columnCounter;
                            tempObj.values.push(tempColumnObj) 
                        })
                        //tempObj.value = objectWrapper.data[fieldName];
                        flatWrapper.data.push(tempObj)
                    }
                    flatWrapper.header = objectWrapper.header;
                    flatWrapper.objectName = objectWrapper.objectName;
                    this.object_keyValues_Flat.push(flatWrapper);
                })
                console.log('this.object_keyValues: ', JSON.parse(JSON.stringify(this.object_keyValues)));
                console.log('this.object_keyValues_Flat: ', JSON.parse(JSON.stringify(this.object_keyValues_Flat)));
            })
            .catch((error) => {
                console.log('error: ', error);
            })
    }

}