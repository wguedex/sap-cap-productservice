namespace com.productsrv;

define type name       : String(50);
define type Dec        : Decimal(16, 2);

using {
    cuid,
    managed
} from '@sap/cds/common';

entity car : cuid {
    // key ID                 : UUID;
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

entity Orders : cuid {
    Date     : Date;
    Customer : String;
    Item     : Composition of many OrderItems
                   on Item.Order = $self;
}

entity OrderItems {
    key ID       : UUID;
        Order    : Association to Orders;
        Product  : Association to Products;
        Quantity : Integer;
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

entity Products : cuid, managed {
    name             : localized String default 'NoName' not null;
    description      : localized String;
    ImageURL         : String;
    ReleaseDate      : DateTime default $now;
    DiscontinuedDate : DateTime;
    Price            : Dec;
    Height           : type of Price;
    Width            : Decimal(16, 2);
    Depth            : Decimal(16, 2);
    Quantity         : Decimal(16, 2);
    Supplier         : Association to one Suppliers;
    UnitOfMeasures   : Association to UnitOfMeasures;
    currency         : Association to Currencies;
    DimensionUnits   : Association to DimensionUnits;
    Category         : Association to Categories;
    toSalesData      : Association to many SalesData
                           on toSalesData.Product = $self;
    Reviews          : Association to many ProductReview
                           on Reviews.Product = $self;

}

entity Suppliers : cuid {
    Name       : type of Products : name;
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
    Email      : String;
    Phone      : String;
    Fax        : String;
    Product    : Association to many Products
                     on Product.Supplier = $self;
}

entity Suppliers_01 : cuid {
    Name    : String;
    Address : Address;
    Email   : String;
    Phone   : String;
    Fax     : String;
}


entity Suppliers_02 : cuid {
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

entity Categories {
    key ID   : String(1);
        Name : localized String
}

entity stockAvailability {
    key ID          : Integer;
        Description : localized String;
        Product     : Association to Products;
}

entity Currencies {
    key ID          : String(3);
        Description : localized String;
}

entity UnitOfMeasures {
    key ID          : String(2);
        Description : localized String;
}

entity DimensionUnits {
    key ID          : String(2);
        Description : localized String;
}

entity Months {
    key ID               : String(2);
        Description      : localized String;
        ShortDescription : localized String(3);
}

entity ProductReview : cuid, managed {
    Name    : String;
    Rating  : Integer;
    Comment : String;
    Product : Association to Products;
}

entity SalesData : cuid, managed {
    DeliveryDate  : DateTime;
    Revenue       : Decimal(16, 2);
    Product       : Association to Products;
    Currency      : Association to Currencies;
    DeliveryMonth : Association to Months;
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


entity Course : cuid {
    Student : Association to many StudentCourse
                  on Student.Course = $self;
}

entity Student : cuid {
    Course : Association to many StudentCourse
                 on Course.Student = $self;
}

entity StudentCourse : cuid {
    Student : Association to Student;
    Course  : Association to Course;
}
