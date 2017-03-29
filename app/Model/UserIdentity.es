export default function (node, logger) {

  node.kind('Record');

  node.inherit('Record.MySQL');
  node.set('mysql.table', 'users.identities');

  node.inherit('Model.HTTP');

  node.field('this', 'Model.User', true);
  node.field('identity', 'Primitive.String', true);
  node.field('secret', 'Primitive.String', true);

};
