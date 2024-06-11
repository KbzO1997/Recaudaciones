// Validaciones de pantalla

var ValidacionesUI = {
    validarMonto: function(evento) {
        var valor = (evento.charCode) ? evento.charCode : ((evento.which) ? evento.which : evento.keyCode);
        return /^\$?\d+(,\d{3})*(\.\d*)?$/.test(String.fromCharCode(valor));
    },
    validarLetras: function(evento) {
        var valor = (evento.charCode) ? evento.charCode : ((evento.which) ? evento.which : evento.keyCode);
        return /^[a-zA-Z\b ]+$/i.test(String.fromCharCode(valor));
    },
    validarNumero: function(evento) {
        var valor = (evento.charCode) ? evento.charCode : ((evento.which) ? evento.which : evento.keyCode);
        return /^[0-9\b]*$/.test(String.fromCharCode(valor));
    },
    validarMoneda: function(evento,componente) {
        var valor = (evento.charCode) ? evento.charCode : ((evento.which) ? evento.which : evento.keyCode);
        var puntos = componente.value.split(".");
        
        return !(!(puntos.length == 1 && valor == 46) && valor > 31 && (valor < 48 || valor > 57));
    }
};
