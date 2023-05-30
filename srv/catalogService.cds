using com.productsrv as productsrv from '../db/schema';
using com.training as training from '../db/training';

// service CatalogService {
//     entity Products       as projection on productsrv.Materials.Products;
//     entity Suppliers      as projection on productsrv.Sales.Suppliers;
//     entity Currency       as projection on productsrv.Materials.Currencies;
//     entity DimensionUnit  as projection on productsrv.Materials.DimensionUnits;
//     entity Category       as projection on productsrv.Materials.Categories;
//     entity SalesData      as projection on productsrv.Sales.SalesData;
//     entity Review         as projection on productsrv.Materials.ProductReview;
//     entity UnitOfMeasures as projection on productsrv.Materials.UnitOfMeasures;
//     entity Months         as projection on productsrv.Sales.Months;
//     entity Order          as projection on productsrv.Sales.Orders;
//     entity OrderItem      as projection on productsrv.Sales.OrderItems;
// }


define service CatalogService {

    entity Products          as
        select from productsrv.Materials.Products {
            ID,
            name           as ProductName      @mandatory,
            description                        @mandatory,
            ImageURL,
            ReleaseDate,
            DiscontinuedDate,
            Price                              @mandatory,
            Height,
            Width,
            Depth,
            Quantity,
            UnitOfMeasures as toUnitOfMeasures @mandatory,
            currency       as toCurrency       @mandatory,
            Category       as toCategory       @mandatory,
            Category.Name  as Category         @readonly,
            DimensionUnits as toDimensionUnit,
            toSalesData,
            Supplier,
            Reviews
        };

    @readonly
    entity Supplier          as
        select from productsrv.Sales.Suppliers {
            ID,
            Name,
            Email,
            Phone,
            Fax,
            Product as toProduct
        };

    entity Reviews           as
        select from productsrv.Materials.ProductReview {
            ID,
            Name,
            Rating,
            Comment,
            createdAt,
            Product as toProduct
        };

    @readonly
    entity SalesData         as
        select from productsrv.Sales.SalesData {
            ID,
            DeliveryDate,
            Revenue,
            Currency.ID   as CurrencyKey,
            DeliveryMonth as DeliveryMonth,
            Product       as toProduct
        };

    @readonly
    entity stockAvailability as
        select from productsrv.Materials.stockAvailability {
            ID,
            Description,
            Product as toProduct
        };

    @readonly
    entity VH_Categories     as
        select from productsrv.Materials.Categories {
            ID   as Code,
            Name as Text
        };

    @readonly
    entity VH_Currencies     as
        select from productsrv.Materials.Currencies {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_UnitOfMeasure  as
        select from productsrv.Materials.UnitOfMeasures {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_DimensionUnit  as
        select from productsrv.Materials.DimensionUnits {
            ID          as Code,
            Description as Text
        };

}
