using ImpactService as service from '../../srv/impact-service';


/*
 * ============================================================
 * CHANGE REQUESTS
 * List Report and Object Page
 * ============================================================
 */

annotate service.ChangeRequests with @(
    UI.HeaderInfo : {
        TypeName       : 'Change Request',
        TypeNamePlural : 'Change Requests',

        Title : {
            $Type : 'UI.DataField',
            Value : title
        },

        Description : {
            $Type : 'UI.DataField',
            Value : status
        }
    },


    /*
     * Fields displayed in the List Report filter bar.
     */
    UI.SelectionFields : [
        status,
        businessProcess,
        sourceSystem,
        targetRelease
    ],


    /*
     * Columns and actions displayed on the List Report.
     */
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : 'Change Request'
        },
        {
            $Type : 'UI.DataField',
            Value : businessProcess,
            Label : 'Business Process'
        },
        {
            $Type : 'UI.DataField',
            Value : sourceSystem,
            Label : 'Source System'
        },
        {
            $Type : 'UI.DataField',
            Value : targetRelease,
            Label : 'Target Release'
        },
        {
            $Type : 'UI.DataField',
            Value : status,
            Label : 'Status',
        },
        {
            $Type : 'UI.DataField',
            Value : modelName,
            Label : 'AI Model'
        },
        {
            $Type  : 'UI.DataFieldForAction',
            Action : 'ImpactService.analyze',
            Label  : 'Analyze Change'
        }
    ],


    /*
     * Sections displayed on the Object Page.
     */
    UI.Facets : [
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'ChangeDetailsFacet',
            Label  : 'Change Details',
            Target : '@UI.FieldGroup#ChangeDetails'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'AnalysisInformationFacet',
            Label  : 'Analysis Information',
            Target : '@UI.FieldGroup#AnalysisInformation'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'ImpactsFacet',
            Label  : 'Impacted Areas',
            Target : 'impacts/@UI.LineItem'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'RisksFacet',
            Label  : 'Risks and Mitigations',
            Target : 'risks/@UI.LineItem'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'TestScenariosFacet',
            Label  : 'Recommended Test Scenarios',
            Target : 'testScenarios/@UI.LineItem'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'OpenQuestionsFacet',
            Label  : 'Open Questions',
            Target : 'openQuestions/@UI.LineItem'
        }
    ],


    /*
     * Main change request fields.
     */
    UI.FieldGroup #ChangeDetails : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : title,
                Label : 'Title'
            },
            {
                $Type : 'UI.DataField',
                Value : description,
                Label : 'Change Description'
            },
            {
                $Type : 'UI.DataField',
                Value : businessProcess,
                Label : 'Business Process'
            },
            {
                $Type : 'UI.DataField',
                Value : sourceSystem,
                Label : 'Source System'
            },
            {
                $Type : 'UI.DataField',
                Value : targetRelease,
                Label : 'Target Release'
            },
            {
                $Type : 'UI.DataField',
                Value : status,
                Label : 'Status'
            },
            {
                $Type  : 'UI.DataFieldForAction',
                Action : 'ImpactService.analyze',
                Label  : 'Analyze Change'
            },
            {
                $Type  : 'UI.DataFieldForAction',
                Action : 'ImpactService.approve',
                Label  : 'Approve Assessment'
            },
            {
                $Type  : 'UI.DataFieldForAction',
                Action : 'ImpactService.reject',
                Label  : 'Reject Assessment'
            }
        ]
    },


    /*
     * Information recorded about the most recent AI analysis.
     */
    UI.FieldGroup #AnalysisInformation : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : modelName,
                Label : 'AI Model'
            },
            {
                $Type : 'UI.DataField',
                Value : analysisVersion,
                Label : 'Analysis Version'
            },
            {
                $Type : 'UI.DataField',
                Value : analyzedAt,
                Label : 'Analyzed At'
            },
            {
                $Type : 'UI.DataField',
                Value : processingMs,
                Label : 'Processing Time in Milliseconds'
            },
            {
                $Type : 'UI.DataField',
                Value : approvedBy,
                Label : 'Approved By'
            },
            {
                $Type : 'UI.DataField',
                Value : approvedAt,
                Label : 'Approved At'
            }
        ]
    }
);


/*
 * ============================================================
 * IMPACTS
 * Child table on the Change Request Object Page
 * ============================================================
 */

annotate service.Impacts with @(
    UI.HeaderInfo : {
        TypeName       : 'Impact',
        TypeNamePlural : 'Impacts',

        Title : {
            $Type : 'UI.DataField',
            Value : area
        },

        Description : {
            $Type : 'UI.DataField',
            Value : objectName
        }
    },

    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : area,
            Label : 'Impacted Area'
        },
        {
            $Type : 'UI.DataField',
            Value : objectType,
            Label : 'Object Type'
        },
        {
            $Type : 'UI.DataField',
            Value : objectName,
            Label : 'Object Name'
        },
        {
            $Type : 'UI.DataField',
            Value : confidence,
            Label : 'AI Confidence'
        },
        {
            $Type : 'UI.DataField',
            Value : explanation,
            Label : 'Impact Explanation'
        }
    ]
);


/*
 * ============================================================
 * RISKS
 * Child table on the Change Request Object Page
 * ============================================================
 */

annotate service.Risks with @(
    UI.HeaderInfo : {
        TypeName       : 'Risk',
        TypeNamePlural : 'Risks',

        Title : {
            $Type : 'UI.DataField',
            Value : title
        },

        Description : {
            $Type : 'UI.DataField',
            Value : severity
        }
    },

    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : severity,
            Label : 'Severity'
        },
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : 'Risk'
        },
        {
            $Type : 'UI.DataField',
            Value : explanation,
            Label : 'Risk Explanation'
        },
        {
            $Type : 'UI.DataField',
            Value : mitigation,
            Label : 'Recommended Mitigation'
        }
    ]
);


/*
 * ============================================================
 * TEST SCENARIOS
 * Child table displayed as Given / When / Then
 * ============================================================
 */

annotate service.TestScenarios with @(
    UI.HeaderInfo : {
        TypeName       : 'Test Scenario',
        TypeNamePlural : 'Test Scenarios',

        Title : {
            $Type : 'UI.DataField',
            Value : title
        },

        Description : {
            $Type : 'UI.DataField',
            Value : priority
        }
    },

    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : priority,
            Label : 'Priority'
        },
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : 'Test Scenario'
        },
        {
            $Type : 'UI.DataField',
            Value : givenCondition,
            Label : 'Given'
        },
        {
            $Type : 'UI.DataField',
            Value : action,
            Label : 'When'
        },
        {
            $Type : 'UI.DataField',
            Value : expectedResult,
            Label : 'Then'
        }
    ]
);


/*
 * ============================================================
 * OPEN QUESTIONS
 * Questions that must be reviewed by a human
 * ============================================================
 */

annotate service.OpenQuestions with @(
    UI.HeaderInfo : {
        TypeName       : 'Open Question',
        TypeNamePlural : 'Open Questions',

        Title : {
            $Type : 'UI.DataField',
            Value : question
        },

        Description : {
            $Type : 'UI.DataField',
            Value : resolved
        }
    },

    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : resolved,
            Label : 'Resolved'
        },
        {
            $Type : 'UI.DataField',
            Value : question,
            Label : 'Question'
        },
        {
            $Type : 'UI.DataField',
            Value : reason,
            Label : 'Reason'
        }
    ]
);