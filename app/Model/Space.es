export default function (node, logger) {

  node.kind('Record');

  node.inherit('Record.MySQL');
  node.set('mysql.table', 'spaces');

  node.field('organization', 'Model.Organization', true);
  node.field('name', 'Primitive.String');

  node.on('http-read')
    .then(':fetch-all', { '*': null })
    .as({ type: 'json', data: '$:@' })
    .end();

  node.on('http-create')
    .then(':set', { data: '$:body' })
    .as({ type: 'json', data: { id: '$:id', name: '$:name' } })
    .end();

  node.on('http-update')
    .then(':set', { data: '$:body', identity: { id: '$:params.id' } })
    .as({ type: 'json', data: '$:@' })
    .end()

};
