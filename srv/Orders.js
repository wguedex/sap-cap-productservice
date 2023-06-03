const cds = require("@sap/cds");
const { Orders2 } = cds.entities("com.training");

module.exports = (srv) => {
  /**
   * READ
   */
  srv.on("READ", "GetOrders", async (req) => {
    if (req.data.ClientEmail !== undefined) {
      return await SELECT.from`com.training.Orders2`
        .where`clientEmail = ${req.data.ClientEmail}`;
    }

    return await SELECT.from(Orders2);
  });

  srv.after("READ", "GetOrders", (data) => {
    return data.map((order2) => {
      order2.Reviewed = true;
    });
  });

  /**
   * CREATE
   */
  srv.on("CREATE", "CreateOrder", async (req) => {
    let returnData = await cds
      .transaction(req)
      .run(
        INSERT.into(Orders2).entries({
          ClientEmail: req.data.ClientEmail,
          FirstName: req.data.FirstName,
          LastName: req.data.LastName,
          CreatedOn: req.data.CreatedOn,
          Reviewed: req.data.Reviewed,
          Approved: req.data.Approved,
        })
      )
      .then((resolve, reject) => {
        console.log("resolve", resolve);
        console.log("reject", reject);

        if (typeof resolve !== "undefined") {
          return req.data;
        } else {
          req.error(409, "Record Not Inserted");
        }
      })
      .catch((err) => {
        console.log(err);
        console.log(err.code, err.message);
      });
    return returnData;
  });
};
