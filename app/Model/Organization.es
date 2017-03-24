export default function (node, logger) {

  node.kind('Record');

  node.inherit('Record.MySQL');
  node.set('mysql.table', 'organizations');

  node.identity('key', ['key']);

  node.field('key', 'Model.Key', true);
  node.field('alert.email', 'Model.Email');

  node.on('http-read')
    .then(':fetch-all', { key: null })
    .as({ type: 'json', data: '$:@' })
    .end();

  node.on('http-create')
    .trap( 'jp:error.code == `ER_DUP_ENTRY`'
         , { type: 'json', data: { message: 'Organization already exists' }, code: 400 }
         )
    .then(':set', { data: '$:body' })
    .as({ type: 'json', data: { id: '$:id', key: '$:key' } })
    .end();

  node.on('http-update')
    .then(':set', { data: '$:body', identity: { id: '$:params.id' } })
    .as({ type: 'json', data: '$:@' })
    .end()

};
