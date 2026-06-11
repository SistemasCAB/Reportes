-- Orden
SELECT * FROM OrdenTurno where mediCodigo = 151	and paciCodigo = 385073 -- dni= 4380212M

-- Procedimientos de la orden
select 
	p.procDescripcion
	,* 
from OrdenTurnoProcedimiento otp
	left join Procedimiento p on otp.procCodigo = p.procCodigo
where ortuCodigo = 244711


-- Turno
select * from Turno where turnCodigo = 1023016098

-- relación turno con la atención y la orden
SELECT * FROM PacienteNomenclador where paciCodigo = 385073 and turnCodigo = 1023016098


-----
select
	otp.orprCodigo, 
	pn.panoFecha as fechaRealizado,
	p.procDescripcion
	,* 
from OrdenTurnoProcedimiento otp
	left join Procedimiento p on otp.procCodigo = p.procCodigo
	left join PacienteNomenclador pn on otp.orprCodigo = pn.orprCodigo
where ortuCodigo = 244711