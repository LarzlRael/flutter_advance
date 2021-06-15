const { io } = require('../index');
const Band = require('../models/band');
const Bands = require('../models/bands');

const bands = new Bands();
bands.addBand(new Band('quuen'));
bands.addBand(new Band('boom jovi'));
bands.addBand(new Band('Metalica'));
bands.addBand(new Band('bloundie'));


// Mensajes de Sockets
io.on('connection', client => {

    client.emit('active-bands', bands.getBands());

    client.on('disconnect', () => {
        console.log('Cliente desconectado');
    });

    client.on('mensaje', (payload) => {
        console.log('Mensaje', payload);

        io.emit('mensaje', { admin: 'Nuevo mensaje' });

    });
    client.on('nuevo-mensaje', (payload) => {
        console.log('nuevo-mensaje', payload);

        client.broadcast.emit('nuevo-mensaje', payload);

    });
    client.on('emitir-mensaje', (payload) => {

        client.broadcast.emit('nuevo-mensaje', payload);

    });

    client.on('vote-band', (payload) => {

        bands.voteBand(payload.id);
        io.emit('active-bands', bands.getBands());

    });
    client.on('add-band', (payload) => {

        const newBand = new Band(payload.name);
        console.log(newBand);
        bands.addBand(newBand);
        io.emit('active-bands', bands.getBands());

    });

    client.on('delete-band', (payload) => {

        console.log(`Band deleted ${payload.id}`);
        bands.deleteBand(payload.id);
        io.emit('active-bands', bands.getBands());


    });


});
