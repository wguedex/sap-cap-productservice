
using com.productsrv as productsrv from '../db/schema';

service  CatalogService {
    entity Products as projection on productsrv.Products;
    entity Suppliers as projection on productsrv.Suppliers;
    entity Suppliers_01 as projection on productsrv.Suppliers_01;
}