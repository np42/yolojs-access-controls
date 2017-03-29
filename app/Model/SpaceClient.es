export default function (node, logger) {

  node.kind('Record');

  node.inherit('Record.MySQL');
  node.set('mysql.table', 'spaces.clients');

  node.inherit('Model.HTTP');

  node.field('name', 'Primitive.String');

};
