SELECT  

    p505.cempresa id_empresa, 
    p505.calmacen id_almacen, 
    p505.czonalma id_zona, 
    p505.cpasillo id_pasillo, 
    p505.chuecopa id_ubicacion,
    p505.creferen id_producto, 
    p505.cvarlogi variable_logistica, 
    p505.cnupalet id_pallet, 
    CASE
        WHEN p505.cvarlogi between 'A' and 'Z' then sum(p505.qstkfisi * f054.qcantdep)
        WHEN p505.cvarlogi between '1' and '9' then sum(p505.qstkfisi)
    END bultos,
        
    SUM(p505.qtotpeso) kilos,
    SUM(p505.qstkfisi * f209.qcoeconv) unidades,
    fcaducid fecha_vencimiento, 
    fubicaci id_dia_ingreso_pallet

FROM 

p505stpa p505, f002arti f002, f054vlog f054, F209CONV f209

WHERE 

    p505.cempresa = f002.cempresa
    AND p505.creferen = f002.creferen
    AND p505.cempresa = f054.cempresa
    AND p505.creferen = f054.creferen
    AND p505.cvarlogi = f054.cvarlogi
    AND p505.cempresa = f209.cempresa
    AND p505.creferen = f209.creferen
    AND p505.cvarlogi = f209.cvarlogi
    AND f209.cvarlodp = '0'

group by 

    p505.cempresa, 
    p505.calmacen, 
    p505.czonalma, 
    p505.cpasillo, 
    p505.chuecopa,
    p505.creferen, 
    p505.cvarlogi, 
    p505.cnupalet, 
    f002.cinducon, 
    fcaducid, 
    fubicaci