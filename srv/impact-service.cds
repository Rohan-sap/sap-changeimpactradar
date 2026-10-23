using { radar as db } from '../db/schema';
using from '../app/annotations';

@path: 'impact'
service ImpactService {

  @odata.draft.enabled
  entity ChangeRequests
    as projection on db.ChangeRequests
    actions {   

      action analyze()
        returns ChangeRequests;

      action approve()
        returns ChangeRequests;

      action reject(
        reason : String
      )
        returns ChangeRequests;
    };

  entity Impacts
    as projection on db.Impacts;

  entity Risks
    as projection on db.Risks;

  entity TestScenarios
    as projection on db.TestScenarios;

  entity OpenQuestions
    as projection on db.OpenQuestions;
}