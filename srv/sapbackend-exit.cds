using {sapbackend as external} from './external/sapbackend';
using {incidents as external2} from './external/incidents';

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

    // entity Incidents as select from external2.IncidentsSet;
    entity Incidents as projection on external2.IncidentsSet;

// entity BusinessPartner as projection on external.BusinessPartnerSet;
}

@protocol: 'rest'
define service RestService {

    entity BusinessPartner as projection on SAPBackendExit.BusinessPartner;

}
