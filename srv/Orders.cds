using com.training as training from '../db/training';

service ManageOrders {

    type CancelOrderReturn {
        Status  : String enum {
            Succeeded;
            Failed
        };
        Message : String;
    }

    entity GetOrders   as projection on training.Orders2;
    entity CreateOrder as projection on training.Orders2;
    entity UpdateOrder as projection on training.Orders2;
    entity DeleteOrder as projection on training.Orders2;
    function getClientTaxRate(ClientEmail : String(65)) returns Decimal(4, 2);
    action   CancelOrder(ClientEmail : String(65))      returns CancelOrderReturn;
}
