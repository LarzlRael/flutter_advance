
const { Schema, model } = require('mongoose');

const MensajesSchema = Schema({

    de: {
        type: Schema.Types.ObjectId,
        ref: 'Usuario',
        required: true
    },
    para: {
        type: Schema.Types.ObjectId,
        ref: 'Usuario',
        required: true
    },
    mensaje: {
        type: String,
        required: true,
    }

}, {
    timestamps: true,
});

MensajesSchema.method('toJSON', function () {
    const { __v, _id, ...object } = this.toObject();
    return object;
})



module.exports = model('Mensaje', MensajesSchema);