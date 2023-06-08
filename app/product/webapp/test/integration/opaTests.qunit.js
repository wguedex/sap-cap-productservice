sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'productsrv/product/test/integration/FirstJourney',
		'productsrv/product/test/integration/pages/ProductsList',
		'productsrv/product/test/integration/pages/ProductsObjectPage',
		'productsrv/product/test/integration/pages/ReviewsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProductsList, ProductsObjectPage, ReviewsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('productsrv/product') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheProductsList: ProductsList,
					onTheProductsObjectPage: ProductsObjectPage,
					onTheReviewsObjectPage: ReviewsObjectPage
                }
            },
            opaJourney.run
        );
    }
);