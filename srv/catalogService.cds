
using com.productsrv as productsrv from '../db/schema';

service  CatalogService {
    entity Products as projection on productsrv.Products;
}