using ImpactService as service from '../../srv/impact-service';

annotate service.ChangeRequests with @(
    UI.HeaderInfo         : {
        TypeName      : 'Change Request',
        TypeNamePlural: 'Change Requests',
        Title         : {
            $Type: 'UI.DataField',
            Value: title
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: status
        }
    },

    UI.SelectionFields    : [
        status,
        businessProcess,
        sourceSystem
    ],

    UI.LineItem           : [
        {
            $Type: 'UI.DataField',
            Value: title,
            Label: 'Change'
        },
        {
            $Type: 'UI.DataField',
            Value: businessProcess,
            Label: 'Business Process'
        },
        {
            $Type: 'UI.DataField',
            Value: status,
            Label: 'Status'
        },
        {
            $Type: 'UI.DataField',
            Value: modelName,
            Label: 'Model'
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'ImpactService.analyze',
            Label : 'Analyze Change'
        }
    ],

    UI.Facets             : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Change Details',
            Target: '@UI.FieldGroup#Details'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Impacted Areas',
            Target: 'impacts/@UI.LineItem'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Risks',
            Target: 'risks/@UI.LineItem'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Test Scenarios',
            Target: 'testScenarios/@UI.LineItem'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Open Questions',
            Target: 'openQuestions/@UI.LineItem'
        }
    ],

    UI.FieldGroup #Details: {Data: [
        {
            $Type: 'UI.DataField',
            Value: title
        },
        {
            $Type: 'UI.DataField',
            Value: description
        },
        {
            $Type: 'UI.DataField',
            Value: businessProcess
        },
        {
            $Type: 'UI.DataField',
            Value: sourceSystem
        },
        {
            $Type: 'UI.DataField',
            Value: targetRelease
        },
        {
            $Type: 'UI.DataField',
            Value: status
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'ImpactService.analyze',
            Label : 'Analyze Change'
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'ImpactService.approve',
            Label : 'Approve Assessment'
        }
    ]}
);

annotate service.Impacts with @UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: area
    },
    {
        $Type: 'UI.DataField',
        Value: objectType
    },
    {
        $Type: 'UI.DataField',
        Value: objectName
    },
    {
        $Type: 'UI.DataField',
        Value: confidence
    },
    {
        $Type: 'UI.DataField',
        Value: explanation
    }
];

annotate service.Risks with @UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: severity
    },
    {
        $Type: 'UI.DataField',
        Value: title
    },
    {
        $Type: 'UI.DataField',
        Value: explanation
    },
    {
        $Type: 'UI.DataField',
        Value: mitigation
    }
];

annotate service.TestScenarios with @UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: priority
    },
    {
        $Type: 'UI.DataField',
        Value: title
    },
    {
        $Type: 'UI.DataField',
        Value: givenCondition
    },
    {
        $Type: 'UI.DataField',
        Value: action
    },
    {
        $Type: 'UI.DataField',
        Value: expectedResult
    }
];

annotate service.OpenQuestions with @UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: resolved
    },
    {
        $Type: 'UI.DataField',
        Value: question
    },
    {
        $Type: 'UI.DataField',
        Value: reason
    }
];
