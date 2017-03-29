export default function (node, logger) {

  node.kind('Record');

  node.inherit('Record.MySQL');
  node.set('mysql.table', 'roles');

  node.inherit('Model.HTTP');

  node.field('organization', 'Model.Organization', true);
  node.field('space', 'Model.Space');
  node.field('client', 'Model.SpaceClient');
  node.field('name', 'Primitive.String');

};
