const fs = require('fs');

const getDocsDirs = () => {
  return fs.readdirSync('./docs', { withFileTypes: true })
    .flatMap(d => d.isFile() ? null: d.name)
    .filter(v => v !== null);
}

module.exports = {
  ...getDocsDirs().map(pj => ({
    [pj]: [{
      type: 'autogenerated',
      dirName: pj,
    }],
  })),
};
