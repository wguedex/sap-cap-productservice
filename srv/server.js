const cds = require("@sap/cds");
const cov2ap = require("@sap/cds-odata-v2-adapter-proxy");
const cors = require("cors");

cds.on("bootstrap", (app)=> {
    app.use(cov2ap())
    app.use(cors())

    app.get("/alive", (_,res) => {
        res.status(200).send("Server is Alive");
    });
});

if (process.env.NODE_ENV !== 'production') {

    const swagger = require("cds-swagger-ui-express");

    cds.on("bootstrap", (app) => {
        app.use(swagger())
    });

    require("dotenv").config();
}

module.exports = cds.server;