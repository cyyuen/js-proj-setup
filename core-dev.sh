#!/bin/sh

# 
# Setup flow
#
# install flow
echo installing flow-bin
npm install --save-dev flow-bin

# init flow config
touch .flowconfig

# install flow plugin for eslint
echo installing flow for eslint
npm install --save-dev eslint-plugin-flowtype

# install flow plugin for babel
echo installing flow for babel
npm install --save-dev babel-plugin-transform-flow-strip-types

# added flow cmd to package.json 
json -I -f package.json -e 'this.scripts.flow="flow; test $? -eq 0 -o $? -eq 2"'

# 
# Setup babel
#

# install es2015 & stage-0
echo "installing babel preset es2015 & stage-0"
npm install --save-dev babel-preset-es2015
npm install --save-dev babel-preset-stage-0

# init babel config
cat > .babelrc << EOF
{
    "presets": ["es2015", "stage-0"],
    "plugins": ["transform-flow-strip-types"]
}
EOF

# 
# Setup eslint
#
# install eslint
echo installing eslint
npm install --save-dev eslint

# add babel support for eslint
echo installing babel for eslint
npm install --save-dev babel-eslint

# init eslint config
cat > .eslintrc << EOF 
{
    "parser": "babel-eslint",
    "plugins": [
        "flowtype"
    ],
    "rules": {
        "flowtype/define-flow-type": 1,
        "flowtype/require-parameter-type": 1,
        "flowtype/require-return-type": [
            1,
            "always",
            {
                "annotateUndefined": "never"
            }
        ],
        "flowtype/space-after-type-colon": [
            1,
            "always"
        ],
        "flowtype/space-before-type-colon": [
            1,
            "never"
        ],
        "flowtype/type-id-match": [
            1,
            "^([A-Z][a-z0-9]+)+Type$"
        ],
        "flowtype/use-flow-type": 1,
        "flowtype/valid-syntax": 1
    },
    "settings": {
        "flowtype": {
            "onlyFilesWithFlowAnnotation": false
        }
    }
}
EOF

#
# setup test
#

echo installing testing package tape
npm install --save-dev tape
echo installing babel for tape
npm install babel-register

# setup pretty print & notification for tape
echo installing tape notify and pretty print
npm install --save-dev tap-notify
npm install --save-dev tap-diff

# add tape cmd to package.json
json -I -f package.json -e 'this.scripts.test="FORCE_COLOR=t tape -r babel-register src/**/*_test.js | tap-notify | tap-diff"'

#
# setup pre-commit
#
# add flow and test to pre-commit

echo "installing & setting up git precommit hook"
npm install --save-dev pre-commit
json -I -f package.json -e 'this["pre-commit"]=["flow", "test"]'
