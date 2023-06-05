using { sapbackend as external } from './external/sapbackend';

service SAPBackendExit {

    @cds.persistence.skip
    entity BusinessPartner as select from external.BusinessPartnerSet{
        BusinessPartnerID, 
        CompanyName, 
        EmailAddress 
    };
    // entity Products as select from external.ProductSet;
    // entity SalesOrder as select from external.SalesOrderSet;
    // entity SalesOrder as select from external.SalesOrderSet;

}