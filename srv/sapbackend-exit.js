const cds = require("@sap/cds");

// module.exports = cds.service.impl(async function(srv){

//     const { BusinessPartner } = srv.entities;

//     const sapbackend = await cds.connect.to("sapbackend");

//     srv.on("READ", BusinessPartner, async (req) => {
//         return await sapbackend.tx(req).send({
//             query : req.query,
//             headers : {
//                 Authorization : `${process.env.SAP_GATEWAY_AUTH}`
//             }
//         });
//     } );

// });

module.exports = async (srv) => {
  const sapbackend = await cds.connect.to("sapbackend");
  const { BusinessPartner } = srv.entities;

  srv.on(["READ"], BusinessPartner, async (req) => {
    let BusinessQuery = SELECT.from(req.query.SELECT.from).limit(
      req.query.SELECT.limit
    );

    if (req.query.SELECT.where) {
      BusinessQuery.where(req.query.SELECT.where);
    }

    if (req.query.SELECT.orderBy) {
      BusinessQuery.orderBy(req.query.SELECT.orderBy);
    }

    let dataQuery = await sapbackend.tx(req).send({
      query: BusinessQuery,
      headers: {
        Authorization: `${process.env.SAP_GATEWAY_AUTH}`,
      },
    });

    let dataQueryArray = [];
    if (Array.isArray(dataQuery)) {
      dataQueryArray = dataQuery;
    } else {
      dataQueryArray[0] = dataQuery;
    }

    return dataQueryArray;
  });

  const incidents = await cds.connect.to("incidents");
  const { Incidents } = srv.entities;

  srv.on(["READ"], Incidents, async (req) => {
    let IncidentQuery = SELECT.from(req.query.SELECT.from).limit(
      req.query.SELECT.limit
    );

    if (req.query.SELECT.where) {
      IncidentQuery.where(req.query.SELECT.where);
    }

    if (req.query.SELECT.orderBy) {
      IncidentQuery.orderBy(req.query.SELECT.orderBy);
    }

    let dataQuery = await incidents.tx(req).send({
      query: IncidentQuery,
      headers: {
        Authorization: `${process.env.SAP_GATEWAY_AUTH2}`,
      },
    });

    let dataQueryArray = [];
    if (Array.isArray(dataQuery)) {
      dataQueryArray = dataQuery;
    } else {
      dataQueryArray[0] = dataQuery;
    }

    return dataQueryArray;
  });
};
