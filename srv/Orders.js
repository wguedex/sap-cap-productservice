const cds = require("@sap/cds");
const { Orders2 } = cds.entities("com.training");

module.exports = (srv) => {
    /**
     * READ 
     */
    srv.on("READ", "GetOrders", async (req) => {
        return await SELECT.from(Orders2);
    });
};