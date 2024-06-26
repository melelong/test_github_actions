const path = require('path');
const fs = require('fs');

const PACKAGE_JSON_PATH = path.join(path.resolve(process.cwd(), 'package.json'))
const PACKAGE_JSON_CONTENT = JSON.parse(fs.readFileSync(PACKAGE_JSON_PATH, 'utf-8'))
console.log(PACKAGE_JSON_CONTENT.name)
