const { usuarioConectado, usuarioDesconectado, grabarMensaje } = require('../controllers/socket');
const { comprobarJWT } = require('../helpers/jwt');
const { io } = require('../index');


// Mensajes de Sockets
io.on('connection', (client) => {
    console.log('Cliente conectado');

    //? client with jwt

    const token = client.handshake.headers['x-token'];

    const [valido, uid] = comprobarJWT(token);


    if (!valido) return client.disconnect();

    // console.log('cliente')
    //? client autenticado
    usuarioConectado(uid);

    // Ingrese al usuariosa una sala en particular
    // sala global, client.id 54564515616515
    client.join(uid);

    client.on('mensaje-personal', async (payload) => {
        // console.log(payload);
        await grabarMensaje(payload);

        io.to(payload.para).emit('mensaje-personal', payload);
    })

    client.on('disconnect', () => {
        usuarioDesconectado(uid);
    });



    // client.on('mensaje', ( payload ) => {
    //     console.log('Mensaje', payload);xs
    //     io.emit( 'mensaje', { admin: 'Nuevo mensaje' } );
    // });


});
