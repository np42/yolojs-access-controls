export default function (node, logger) {

  node.on('http-read')
    .then(':fetch-all', { '*': true })
    .as({ type: 'json', data: '$:@' })
    .end();

  node.on('http-create')
    .trap( 'jp:error.code == `ER_DUP_ENTRY`'
         , { type: 'json', data: { message: '%:%{name} already exists' }, code: 400 }
         )
    .then(':set', { data: '$:body' })
    .as({ type: 'json', data: '$:@' })
    .end();

  node.on('http-update')
    .trap( 'jp:error.code == `ER_DUP_ENTRY`'
         , { type: 'json', data: { message: '$:error.message' }, code: 400 }
         )
    .then(':set', { data: '$:body', identity: { id: '$:params.id' } })
    .as({ type: 'json', data: '$:@' })
    .end()

  node.on('http-delete')
    .end();

};
