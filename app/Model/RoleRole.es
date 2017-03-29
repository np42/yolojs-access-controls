export default function (node, logger) {

  node.kind('Record');

  node.inherit('Collection.MySQLListItem');
  node.set('mysql.table', 'roles.roles');

  node.inherit('Model.HTTP');

  node.field('this', 'Model.Organization', true);
  node.field('role', 'Model.Role', true);

};
