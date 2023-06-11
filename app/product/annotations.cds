using CatalogService as service from '../../srv/catalogService';

annotate service.Products with @(

    Capabilities : {
        DeleteRestrictions: {
            $Type    : 'Capabilities.DeleteRestrictionsType',
            Deletable: false
        }
    },

    UI.HeaderInfo     : {
        TypeName      : 'Product',
        TypeNamePlural: 'Products',
        ImageUrl      : ImageURL,
        Title         : {Value: ProductName},
        Description   : {Value: description}
    },

    Capabilities : {
        DeleteRestrictions : {
            $Type : 'Capabilities.DeleteRestrictionsType',
            Deletable: false
        },
    }, 

    UI.SelectionFields: [
        toCategory_ID,
        toCurrency_ID,
        StockAvailability
    ],

    UI.LineItem       : [
        {
            $Type: 'UI.DataField',
            Label: 'ProductName',
            Value: ProductName,
        },
        {
            $Type: 'UI.DataField',
            Label: 'description',
            Value: description,
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Label : 'Supplier',
            Target: 'Supplier/@Communication.Contact'
        },
        {
            $Type: 'UI.DataField',
            Label: 'ImageURL',
            Value: ImageURL,
        },
        {
            $Type: 'UI.DataField',
            Label: 'ReleaseDate',
            Value: ReleaseDate,
        },
        {
            $Type: 'UI.DataField',
            Label: 'DiscontinuedDate',
            Value: DiscontinuedDate,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Price',
            Value: Price
        },
        {
            $Type      : 'UI.DataField',
            Label      : 'Stock Availability',
            Value      : StockAvailability,
            Criticality: StockAvailability
        },
        {
            Label : 'Rating',
            $Type : 'UI.DataFieldForAnnotation',
            Target: '@UI.DataPoint#AverageRating'
        },
    ]
);

annotate service.Products with @(
    UI.FieldGroup #GeneratedGroup1: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'ProductName',
                Value: ProductName,
            },
            {
                $Type: 'UI.DataField',
                Label: 'description',
                Value: description,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ImageURL',
                Value: ImageURL,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ReleaseDate',
                Value: ReleaseDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'DiscontinuedDate',
                Value: DiscontinuedDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Price',
                Value: Price,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Height',
                Value: Height,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Width',
                Value: Width,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Depth',
                Value: Depth,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Quantity',
                Value: Quantity,
            },
            {
                $Type: 'UI.DataField',
                Label: 'toUnitOfMeasures_ID',
                Value: toUnitOfMeasures_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'toCurrency_ID',
                Value: toCurrency_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'toCategory_ID',
                Value: toCategory_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Category',
                Value: Category,
            },
            {
                $Type: 'UI.DataField',
                Label: 'toDimensionUnit_ID',
                Value: toDimensionUnit_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Stock Availability',
                Value: StockAvailability
            },
        // {
        //     Label : 'Rating',
        //     $Type : 'UI.DataFieldForAnnotation',
        //     Target: '@UI.DataPoint#AverageRating'
        // }
        ],
    },
    UI.Facets                     : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet2',
            Label : 'General Information Copia',
            Target: '@UI.FieldGroup#GeneratedGroup1',
        }
    ],

    UI.HeaderFacets               : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.DataPoint#AverageRating'
    }]

);

/**
 * Anotations for SH
 */
annotate service.Products with {
    //Category
    toCategory        @(Common: {
        Text     : {
            $value                : Category,
            ![@UI.TextArrangement]: #TextOnly,
        },
        ValueList: {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Categories',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: toCategory_ID,
                    ValueListProperty: 'Code'
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: toCategory_ID,
                    ValueListProperty: 'Text'
                }
            ]
        },
    });

    //Currency
    toCurrency        @(Common: {
        ValueListWithFixedValues: false,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Currencies',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: toCategory_ID,
                    ValueListProperty: 'Code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Text'
                }
            ]
        },
    });

    StockAvailability @(Common: {
        ValueListWithFixedValues: true,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'stockAvailability',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: StockAvailability,
                ValueListProperty: 'ID'
            }]
        },

    });

};

annotate service.Products {
    ImageURL @(UI.IsImageURL: true);
};

/**
 * Anotations for VH_Categories Entity
 */
annotate service.VH_Categories with {
    //Code
    Code @(
        UI    : {Hidden: true},
        Common: {Text: {
            $value                : Text,
            ![@UI.TextArrangement]: #TextFirst,
        }, }
    );
    Text @(UI: {HiddenFilter: true},

    );

};

annotate service.VH_Currencies {
    Code @(UI: {HiddenFilter: true});
    Text @(UI: {HiddenFilter: true});
};

annotate service.stockAvailability {
    ID @(Common: {Text: {
        $value                : Description,
        ![@UI.TextArrangement]: #TextOnly,
    }});
};

/**
 * Annotations for supplier entity
 */
annotate service.Supplier with @(Communication: {Contact: {
    $Type: 'Communication.ContactType',
    fn   : Name,
    role : 'Supplier - Role',
    photo: 'sap-icon://supplier',
    email: [{
        type   : #work,
        address: Email
    }],
    tel  : [
        {
            type: #work,
            uri : Phone
        },
        {
            type: #fax,
            uri : Fax
        }
    ]

}, });


annotate service.Products with @(UI.DataPoint #AverageRating: {
    Value        : Rating,
    Title        : 'Rating',
    TargetValue  : 5,
    Visualization: #Rating
});
