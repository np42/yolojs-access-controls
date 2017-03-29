export default function (node, logger) {

  node.kind('Record');

  node.inherit('Record.MySQL');
  node.set('mysql.table', 'users');

  node.inherit('Model.HTTP');

  node.field('organization', 'Model.Organization', true);
  node.field('space', 'Model.Space', true);
  node.field('identifier', 'Primitive.String', true);

};
