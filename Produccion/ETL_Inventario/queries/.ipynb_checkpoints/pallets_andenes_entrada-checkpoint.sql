select 

    f078.cempresa id_empresa,  
    f078.calmacen id_almacen, 
    0 id_zona, 
    0 id_pasillo, 
    f078.czonpule id_ubicacion,
    f079.creferen id_producto, 
    f079.cvarlogi variable_logistica,
    f078.cnupalet id_pallet, 
    case
        when f079.cvarlogi between 'A' and 'Z' then
            sum(f079.qenpalet * f054.qcantdep)
        when f079.cvarlogi between '1' and '9' then
            sum(f079.qenpalet)
    end bultos,
    sum(f079.qpesobru) kilos,
    sum(f079.qenpalet * f209.qcoeconv) unidades, 
    NULL fecha_vencimiento, 
    NULL id_dia_ingreso_pallet, 
    f002.cconsign id_consignatario

from f078cpen f078, f079lpen f079, f002arti f002, f054vlog f054, f209conv f209

where f078.cempresa = f079.cempresa
and f078.calmacen = f079.calmacen
and f078.cnupalet = f079.cnupalet
and f079.cempresa = f002.cempresa
and f079.creferen = f002.creferen
and f079.cempresa = f054.cempresa
and f079.creferen = f054.creferen
and f079.cvarlogi = f054.cvarlogi
and f079.cempresa = f209.cempresa
and f079.creferen = f209.creferen
and f079.cvarlogi = f209.cvarlogi
and f209.cvarlodp = '0'
and f079.csitlpal in ('PL','PG') 

group by f078.cempresa,f078.cnupalet, f079.creferen, f079.cvarlogi, f002.cinducon, f078.calmacen, f078.czonpule,
f002.cconsign