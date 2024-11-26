Map<String, dynamic> localData = {
  "type": "SCAFFOLD",
  "id":"d542524e-1db8-4222-b0b8-0d23bebce1a0",
  "setting": {
    "padding": {},
    "margin": {},
    "radius": {}
  },
  "child": {
    "id": "76eb8b2c-1df8-468d-84cb-f2942a001b08",
    "type": "LISTVIEW",
    "parentId": "d542524e-1db8-4222-b0b8-0d23bebce1a0",
    "setting": {
      "scrollDirection": "vertical",
      "padding": {},
      "margin": {},
      "radius": {}
    },
    "children": [
      {
        "id": "eba79316-7948-417c-b4a8-79f7abb37267",
        "type": "IMAGE",
        "parentId": "76eb8b2c-1df8-468d-84cb-f2942a001b08",
        "setting": {
          "padding": {},
          "margin": { "bottom": 15 },
          "radius": {},
          "fullWidth": false
        },
        "src": "https://picsum.photos/400/300?random=527"
      },
      {
        "id": "ceac1d0c-4223-46ac-af44-6b32cf6e71e4",
        "type": "CONTAINER",
        "parentId": "76eb8b2c-1df8-468d-84cb-f2942a001b08",
        "setting": {
          "padding": { "top": 15, "bottom": 15, "left": 15, "right": 15 },
          "margin": {},
          "radius": {}
        },
        "child": {
          "id": "8a3a4d62-3c39-4a7b-a9ad-9eba05f90ece",
          "type": "COLUMN",
          "parentId": "ceac1d0c-4223-46ac-af44-6b32cf6e71e4",
          "setting": {
            "mainAxisAlignment": "start",
            "crossAxisAlignment": "start",
            "mainAxisSize": "max",
            "padding": {},
            "margin": {},
            "radius": {}
          },
          "children": [
            {
              "id": "e8e92cec-5113-41a9-976e-59d6c82ca6b7",
              "type": "INPUT",
              "parentId": "8a3a4d62-3c39-4a7b-a9ad-9eba05f90ece",
              "setting": {
                "label": "Email",
                "hint": "Entrer votre email",
                "isPassword": false,
                "isUnderlinedBorder": false,
                "padding": {},
                "margin": {},
                "radius": {
                  "topRight": 30,
                  "topLeft": 30,
                  "bottomRight": 30,
                  "bottomLeft": 30
                }
              }
            },
            {
              "id": "52cd5239-888b-49cc-92a3-419a95434088",
              "type": "INPUT",
              "parentId": "8a3a4d62-3c39-4a7b-a9ad-9eba05f90ece",
              "setting": {
                "label": "Mot de passe",
                "hint": "Entrer votre mot de passe",
                "isPassword": true,
                "isUnderlinedBorder": false,
                "padding": {},
                "margin": { "top": 10 },
                "radius": {
                  "topRight": 30,
                  "topLeft": 30,
                  "bottomRight": 30,
                  "bottomLeft": 30
                }
              }
            },
            {
              "id": "37be2617-ff3a-48a6-bd72-ab17f677116f",
              "type": "BUTTON",
              "parentId": "8a3a4d62-3c39-4a7b-a9ad-9eba05f90ece",
              "setting": {
                "padding": { "left": 15, "right": 15 },
                "margin": { "top": 20 },
                "radius": {
                  "topRight": 30,
                  "topLeft": 30,
                  "bottomRight": 30,
                  "bottomLeft": 30
                },
                "height": 50,
                "width": 200,
                "fullWidth": true
              },
              "text": "Se connecter"
            },
            {
              "id": "0227ff48-3195-4057-9f86-d7bd0c13f157",
              "type": "ALIGN",
              "parentId": "8a3a4d62-3c39-4a7b-a9ad-9eba05f90ece",
              "setting": {
                "padding": {},
                "margin": {},
                "radius": {}
              },
              "child": {
                "id": "e1b39475-4fbc-4544-b981-0cd70f3271d0",
                "type": "RICH_TEXT",
                "parentId": "0227ff48-3195-4057-9f86-d7bd0c13f157",
                "setting": {
                  "padding": {},
                  "margin": { "top": 20 },
                  "radius": {},
                  "textAlign": "start",
                  "fontWeight": "w400"
                },
                "text": [
                  {
                    "text": "Vous n'avez pas de compte?",
                    "index": 0,
                    "setting": {
                      "padding": {},
                      "margin": {},
                      "radius": {},
                      "textAlign": "start",
                      "fontWeight": "w400"
                    }
                  },
                  {
                    "text": "Inscrivez-vous",
                    "index": 1,
                    "setting": {
                      "padding": {},
                      "margin": {},
                      "radius": {},
                      "textAlign": "start",
                      "color": 4280391411,
                      "fontWeight": "w700"
                    }
                  }
                ]
              }
            }
          ]
        }
      }
    ]
  }
};