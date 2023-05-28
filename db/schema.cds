namespace productsrv;

entity Products {
    key ID               : Integer;
        name             : String;
        description      : String;
        ImageURL         : String;
        ReleaseDate      : DateTime;
        DiscontinuedDate : DateTime;
        Price            : Decimal(16, 2);
        Height           : Decimal(16, 2);
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);

}

entity Supplier {
    key ID         : UUID;
        Name       : String;
        Street     : String;
        City       : String;
        State      : String(2);
        PostalCode : String(5);
        Country    : String(3);
        Email      : String;
        Phone      : String;
        Fax        : String;
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