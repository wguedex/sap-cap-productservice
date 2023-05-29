using com.productsrv as productsrv from '../db/schema';

service CatalogService {
    entity Products       as projection on productsrv.Products;
    entity Suppliers      as projection on productsrv.Suppliers;
    entity Currency       as projection on productsrv.Currencies;
    entity DimensionUnit  as projection on productsrv.DimensionUnits;
    entity Category       as projection on productsrv.Categories;
    entity SalesData      as projection on productsrv.SalesData;
    entity Review         as projection on productsrv.ProductReview;
    entity UnitOfMeasures as projection on productsrv.UnitOfMeasures;
}
 