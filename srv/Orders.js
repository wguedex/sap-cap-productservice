const cds = require("@sap/cds");
const { Orders2 } = cds.entities("com.training");

module.exports = (srv) => {
    /**
     * READ 
     */
    srv.on("READ", "GetOrders", async (req) => {

        if (req.data.ClientEmail !== undefined){
            return await SELECT.from`com.training.Orders2`.where`clientEmail = ${req.data.ClientEmail}`;
        }

        return await SELECT.from(Orders2);
    });

    srv.after("READ","GetOrders", (data) => {
      return  data.map((order2) => {
            order2.Reviewed = true
        });
    });
};