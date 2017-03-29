export default function (node, logger) {

  node.kind('Record');

  node.inherit('Record.MySQL');
  node.set('mysql.table', 'organizations');

  node.inherit('Model.HTTP');

  node.identity('key', ['key']);

  node.field('key', 'Model.Key', true);
  node.field('alert.email', 'Model.Email');

};
