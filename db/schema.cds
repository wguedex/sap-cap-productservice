namespace com.productsrv;

define type name       : String(50);
define type Dec        : Decimal(16, 2);

entity car {
    key ID                 : UUID;
        name               : String;
        virtual discount_1 : Decimal;

        //Allow the client to send data
        @Core.Computed: false
        virtual discount_2 : Decimal;
}

type Gender            : String enum {
    male;
    female;
};

entity Order {
    clientGender : Gender;
    status       : Integer enum {
        submitted = 1;
        fulfiller = 2;
        shipped   = 3;
        cancel    = -1;

    };
    priority     : String @assert.range enum {
        high;
        medium;
        low;
    };
}

type Address {
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
}

type EmailAddresses_01 : array of {
    kind  : String;
    email : String;
}

type EmailAddresses_02 {
    kind  : String;
    email : String;
}

entity Emails {
    email_01 :      EmailAddresses_01;
    email_02 : many EmailAddresses_02;
    email_03 : many {
        kind  : String;
        email : String;
    }
}

entity Products {
    key ID               : UUID;
        name             : String default 'NoName' not null;
        description      : String;
        ImageURL         : String;
        ReleaseDate      : DateTime default $now;
        DiscontinuedDate : DateTime;
        Price            : Dec;
        Height           : type of Price; //Decimal(16, 2);
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);

}

entity Suppliers {
    key ID         : UUID;
        Name       : type of Products : name; //String;
        Street     : String;
        City       : String;
        State      : String(2);
        PostalCode : String(5);
        Country    : String(3);
        Email      : String;
        Phone      : String;
        Fax        : String;
}

entity Suppliers_01 {
    key ID      : UUID;
        Name    : String;
        Address : Address;
        Email   : String;
        Phone   : String;
        Fax     : String;
}


entity Suppliers_02 {
    key ID      : UUID;
        Name    : String;
        Address : {
            Street     : String;
            City       : String;
            State      : String(2);
            PostalCode : String(5);
            Country    : String(3);
        };
        Email   : String;
        Phone   : String;
        Fax     : String;
}

entity Category {
    key ID   : String(1);
        Name : String
}

entity stockAvailability {
    key ID          : Integer;
        Description : String;
}

entity currencies {
    key ID          : String(3);
        Description : String;
}

entity unitOfMeasures {
    key ID          : String(2);
        Description : String;
}

entity DimensionUnits {
    key ID          : String(2);
        Description : String;
}

entity months {
    key ID               : String(2);
        Description      : String;
        ShortDescription : String(3);
}

entity ProductReview {
    key Name    : String;
        Rating  : Integer;
        Comment : String;
}

entity salesData {
    key ID           : UUID;
        DeliveryDate : DateTime;
        Revenue      : Decimal(16, 2);
}


entity SelProducts   as select from Products;

entity SelProducts1  as
    select from Products {
        *
    };

entity SelProducts2  as
    select from Products {
        name,
        Price,
        Quantity
    };


entity SelProducts3  as
    select from Products
    left join ProductReview
        on Products.name = ProductReview.Name
    {
        Rating,
        Products.name,
        sum(Price) as TotalPrice
    }
    group by
        Rating,
        Products.name
    order by
        Rating;

entity ProjProducts  as projection on Products;

entity ProjProducts2 as projection on Products {
    *
};

entity ProjProducts3 as projection on Products {
    ReleaseDate,
    name
};

/*SAP CAP entities, compatible with HANA, not SQLite.
// entity paramProducts(pName : String)     as
//     select from Products {
//         name,
//         Price,
//         Quantity

//     }
//     where
//         name = :pName;

// entity projParamProducts(pName : String) as projection on Products where name = :pName;
*/

extend Products with {

    priceCondition     : String(2);
    priceDetermination : String(3);

}
