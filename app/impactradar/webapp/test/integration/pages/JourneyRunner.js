sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/example/impactradar/impactradar/test/integration/pages/ChangeRequestsList.gen",
	"com/example/impactradar/impactradar/test/integration/pages/ChangeRequestsObjectPage.gen"
], function (JourneyRunner, ChangeRequestsListGenerated, ChangeRequestsObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/example/impactradar/impactradar') + '/test/flp.html#app-preview',
        pages: {
			onTheChangeRequestsListGenerated: ChangeRequestsListGenerated,
			onTheChangeRequestsObjectPageGenerated: ChangeRequestsObjectPageGenerated
        },
        async: true
    });

    return runner;
});

