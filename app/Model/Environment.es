export default function (node, logger) {

  node.kind('Record');

  node.inherit('Record.MySQL');
  node.set('mysql.table', 'environments');

  node.inherit('Model.HTTP');

  node.field('organization', 'Model.Organization', true);
  node.field('name', 'Primitive.String');

};
