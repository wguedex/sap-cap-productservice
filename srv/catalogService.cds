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
        select from productsrv.Reports.Products {
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
            Quantity                           @(
                mandatory,
                assert.range: [
                    0.00,
                    20.00
                ]
            ),
            UnitOfMeasures as toUnitOfMeasures @mandatory,
            currency       as toCurrency       @mandatory,
            Category       as toCategory       @mandatory,
            Category.Name  as Category         @readonly,
            DimensionUnits as toDimensionUnit,
            toSalesData,
            Supplier,
            Reviews,
            StockAvailability,
            ToStockAvailibity
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

    //Postfix projections
    @readonly
    entity VH_DimensionUnit  as
        select
            ID          as Code,
            Description as Text
        from productsrv.Materials.DimensionUnits;

}


define service MyService {

    entity SupplierProducts  as
        select from productsrv.Materials.Products[name = 'Bread']{
            *,
            name,
            description,
            Supplier.Address
        }
        where
            Supplier.Address.PostalCode = '98074';

    entity SupplierToSales   as
        select
            Supplier.Email,
            Category.Name,
            toSalesData.Currency.ID,
            toSalesData.Currency.Description
        from productsrv.Materials.Products;

    entity EntityInfix       as
        select Supplier[Name = 'Exotic Liquids'].Phone from productsrv.Materials.Products
        where
            Products.name = 'Bread';

    entity EntityJoin        as
        select Phone from productsrv.Materials.Products
        left join productsrv.Sales.Suppliers as supp
            on(
                supp.ID = Products.Supplier.ID
            )
            and supp.Name = 'Exotic Liquids'
        where
            Products.name = 'Bread';
}

define service Reports {
    entity AverageRating     as projection on productsrv.Reports.AverageRating;
}
