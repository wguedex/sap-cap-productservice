using CatalogService as service from '../../srv/catalogService';

annotate service.Products with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'ProductName',
            Value : ProductName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'description',
            Value : description,
        },
        {
            $Type : 'UI.DataField',
            Label : 'ImageURL',
            Value : ImageURL,
        },
        {
            $Type : 'UI.DataField',
            Label : 'ReleaseDate',
            Value : ReleaseDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'DiscontinuedDate',
            Value : DiscontinuedDate,
        },
    ]
);
annotate service.Products with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'ProductName',
                Value : ProductName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'description',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ImageURL',
                Value : ImageURL,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ReleaseDate',
                Value : ReleaseDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DiscontinuedDate',
                Value : DiscontinuedDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Price',
                Value : Price,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Height',
                Value : Height,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Width',
                Value : Width,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Depth',
                Value : Depth,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Quantity',
                Value : Quantity,
            },
            {
                $Type : 'UI.DataField',
                Label : 'toUnitOfMeasures_ID',
                Value : toUnitOfMeasures_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'toCurrency_ID',
                Value : toCurrency_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'toCategory_ID',
                Value : toCategory_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Category',
                Value : Category,
            },
            {
                $Type : 'UI.DataField',
                Label : 'toDimensionUnit_ID',
                Value : toDimensionUnit_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'StockAvailability',
                Value : StockAvailability,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
    ]
);
