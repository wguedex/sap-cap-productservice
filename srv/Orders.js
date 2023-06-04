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

  srv.before("CREATE", "CreateOrder", (req) => {
    req.data.CreatedOn = new Date().toISOString().slice(0, 10);
    return req;
  });

  /**
   * UPDATE
   */
  srv.on("UPDATE", "UpdateOrder", async (req) => {
    let returnData = await cds
      .transaction(req)
      .run([
        UPDATE(Orders2, req.data.ClientEmail).set({
          FirstName: req.data.FirstName,
          LastName: req.data.LastName,
        }),
      ])
      .then((resolve, reject) => {
        console.log("resolve");
        console.log("reject");

        if (resolve[0] == 0) {
          req.error(409, "Record Not Found");
        }
      })
      .catch((err) => {
        console.log(err);
        req.error(err.code, err.message);
      });
    console.log("Before End", returnData);
  });

  /**
   * DELETE
   */
  srv.on("DELETE", "DeleteOrder", async (req) => {
    let returnData = await cds
      .transaction(req)
      .run(
        DELETE.from(Orders2).where({
          ClientEmail: req.data.ClientEmail,
        })
      )
      .then((res, rej) => {
        console.log("Resolve", res);
        console.log("Reject", rej);
        if (res !== 1) {
          req.err(409, "Record Not Found");
        }
      })
      .catch((err) => {
        console.log(err);
        req.error(err.code, err.message);
      });
    console.log("Before End", returnData);
    return returnData;
  });

  /**
   * Functions
   */
  srv.on("getClientTaxRate", async (req) => {
    //No server side-effect
    const { ClientEmail } = req.data;
    const db = srv.transaction(req);
    const results = await db
      // .read(Orders2, ["Country_Code as Country"])
      .read(Orders2, ["Country_Code"])
      .where({ ClientEmail: ClientEmail });

    switch (results[0].Country_code) {
      case "ES":
        return 21.5;
        break;
      case "UK":
        return 24.6;
        break;
    }
    console.log(results[0]);
  });
  /**
   * ACTIONS
   */
  srv.on("CancelOrder", async (req) => {
    const { ClientEmail } = req.data;
    const db = srv.transaction(req);

    const resultRead = await db
      .read(Orders2, ["FirstName", "LastName", "Approved"])
      .where({ ClientEmail: ClientEmail });

    let returnOrder = {
      status: "",
      message: "",
    };

    console.log(ClientEmail);
    console.log(resultRead);

    if (resultRead[0].Approved == false) {
      const resultUpdate = await db.update(Orders2)
        .set({ Status: "C"})
        .where({ ClientEmail: ClientEmail });
      returnOrder.status = "Succeeded";
      returnOrder.message = `The order placed by ${resultRead[0].FirstName} ${resultRead[0].LastName} was cancel`;
    } else {
      returnOrder.status = "Failed";
      returnOrder.message = `The order placed by ${resultRead[0].FirstName} ${resultRead[0].LastName} was NOT canceled because was already approved`;
    }
    console.log("Action cancelOrder executed");
    return returnOrder;
  });
};
