import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_NUMBER from '@salesforce/schema/Account.AccountNumber';
import ACCOUNT_TYPE from '@salesforce/schema/Account.Type';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class RecordEditFormExample extends LightningElement {
    @api recordId;
    accountId;
    accountName = ACCOUNT_NAME;
    accountNumber = ACCOUNT_NUMBER;
    accountType = ACCOUNT_TYPE;

    @wire(getRecord, { recordId: '$recordId', fields: ['Contact.AccountId'] })
    wiredContact({ error, data }) {
        if (data) {
            this.accountId = data.fields.AccountId.value;
        } else if (error) {
            console.error(error);
        }
    }

    onSubmit() {
        this.dispatchEvent(new ShowToastEvent({
            title: 'Sucesso!',
            message:
                'Os dados da conta deste contato foram atualizados.',
            variant:'success'
        }));

    }
}