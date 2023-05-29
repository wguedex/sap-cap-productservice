using com.productsrv as productsrv from '../db/schema';
using com.training as training from '../db/training';

service CatalogService {
    entity Products       as projection on productsrv.Materials.Products;
    entity Suppliers      as projection on productsrv.Sales.Suppliers;
    entity Currency       as projection on productsrv.Materials.Currencies;
    entity DimensionUnit  as projection on productsrv.Materials.DimensionUnits;
    entity Category       as projection on productsrv.Materials.Categories;
    entity SalesData      as projection on productsrv.Sales.SalesData;
    entity Review         as projection on productsrv.Materials.ProductReview;
    entity UnitOfMeasures as projection on productsrv.Materials.UnitOfMeasures;
    entity Months         as projection on productsrv.Sales.Months;
    entity Order          as projection on productsrv.Sales.Orders;
    entity OrderItem      as projection on productsrv.Sales.OrderItems;
}
