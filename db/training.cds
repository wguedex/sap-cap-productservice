namespace com.training;


using {
    cuid,
    managed, 
    Country
} from '@sap/cds/common';

define type name       : String(50);

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

type Address {
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
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

entity Orders2 {
    key ClientEmail : String;
        FirstName   : String(30);
        LastName    : String(30);
        CreatedOn   : Date;
        Reviewed    : Boolean;
        Approved    : Boolean;
        Country : Country
}
