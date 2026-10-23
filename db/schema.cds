namespace radar;

using {
  cuid,
  managed
} from '@sap/cds/common';


type ChangeStatus : String enum {
  New;
  Analyzing;
  Analyzed;
  ReviewRequired;
  Approved;
  Rejected;
  Failed;
}


type Severity : String enum {
  Low;
  Medium;
  High;
  Critical;
}


entity ChangeRequests : cuid, managed {

  title :
    String(150)
    @mandatory;

  description :
    LargeString
    @mandatory;

  businessProcess :
    String(100);

  sourceSystem :
    String(80);

  targetRelease :
    String(40);

  status :
    ChangeStatus
    default 'New';

  modelName :
    String(100);

  analyzedAt :
    Timestamp;

  approvedAt :
    Timestamp;

  approvedBy :
    String(255);

  processingMs :
    Integer;

  analysisVersion :
    Integer
    default 0;


  impacts :
    Composition of many Impacts
    on impacts.change = $self;

  risks :
    Composition of many Risks
    on risks.change = $self;

  testScenarios :
    Composition of many TestScenarios
    on testScenarios.change = $self;

  openQuestions :
    Composition of many OpenQuestions
    on openQuestions.change = $self;
}


entity Impacts : cuid, managed {

  change :
    Association to ChangeRequests;

  area :
    String(100);

  objectType :
    String(60);

  objectName :
    String(120);

  explanation :
    LargeString;

  confidence :
    Decimal(3,2);
}


entity Risks : cuid, managed {

  change :
    Association to ChangeRequests;

  title :
    String(150);

  severity :
    Severity;

  explanation :
    LargeString;

  mitigation :
    LargeString;
}


entity TestScenarios : cuid, managed {

  change :
    Association to ChangeRequests;

  title :
    String(150);

  givenCondition :
    LargeString;

  action :
    LargeString;

  expectedResult :
    LargeString;

  priority :
    Severity;
}


entity OpenQuestions : cuid, managed {

  change :
    Association to ChangeRequests;

  question :
    LargeString;

  reason :
    LargeString;

  resolved :
    Boolean
    default false;
}