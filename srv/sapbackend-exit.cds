using {sapbackend as external} from './external/sapbackend';

define service SAPBackendExit {

    @cds.persistence: {
        table,
        skip: false
    }

    @cds.autoexpose
    entity BusinessPartner as
        select from external.BusinessPartnerSet {
            BusinessPartnerID,
            CompanyName,
            EmailAddress
        };

// entity BusinessPartner as projection on external.BusinessPartnerSet;
}

@protocol: 'rest'
define service RestService {

    entity BusinessPartner as projection on SAPBackendExit.BusinessPartner;

}
