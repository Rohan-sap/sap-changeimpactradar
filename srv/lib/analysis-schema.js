const analysisSchema = {
  type: "object",

  additionalProperties: false,

  required: [
    "summary",
    "overallSeverity",
    "impacts",
    "risks",
    "testScenarios",
    "openQuestions"
  ],

  properties: {
    summary: {
      type: "string",
      minLength: 1,
      maxLength: 1200
    },

    overallSeverity: {
      type: "string",
      enum: [
        "Low",
        "Medium",
        "High",
        "Critical"
      ]
    },

    impacts: {
      type: "array",
      maxItems: 15,

      items: {
        type: "object",

        additionalProperties: false,

        required: [
          "area",
          "objectType",
          "objectName",
          "explanation",
          "confidence"
        ],

        properties: {
          area: {
            type: "string",
            maxLength: 100
          },

          objectType: {
            type: "string",
            maxLength: 60
          },

          objectName: {
            type: "string",
            maxLength: 120
          },

          explanation: {
            type: "string",
            maxLength: 1000
          },

          confidence: {
            type: "number",
            minimum: 0,
            maximum: 1
          }
        }
      }
    },

    risks: {
      type: "array",
      maxItems: 12,

      items: {
        type: "object",

        additionalProperties: false,

        required: [
          "title",
          "severity",
          "explanation",
          "mitigation"
        ],

        properties: {
          title: {
            type: "string",
            maxLength: 150
          },

          severity: {
            type: "string",
            enum: [
              "Low",
              "Medium",
              "High",
              "Critical"
            ]
          },

          explanation: {
            type: "string",
            maxLength: 1000
          },

          mitigation: {
            type: "string",
            maxLength: 1000
          }
        }
      }
    },

    testScenarios: {
      type: "array",
      maxItems: 15,

      items: {
        type: "object",

        additionalProperties: false,

        required: [
          "title",
          "givenCondition",
          "action",
          "expectedResult",
          "priority"
        ],

        properties: {
          title: {
            type: "string",
            maxLength: 150
          },

          givenCondition: {
            type: "string",
            maxLength: 800
          },

          action: {
            type: "string",
            maxLength: 800
          },

          expectedResult: {
            type: "string",
            maxLength: 800
          },

          priority: {
            type: "string",
            enum: [
              "Low",
              "Medium",
              "High",
              "Critical"
            ]
          }
        }
      }
    },

    openQuestions: {
      type: "array",
      maxItems: 10,

      items: {
        type: "object",

        additionalProperties: false,

        required: [
          "question",
          "reason"
        ],

        properties: {
          question: {
            type: "string",
            maxLength: 600
          },

          reason: {
            type: "string",
            maxLength: 600
          }
        }
      }
    }
  }
};

export default analysisSchema;