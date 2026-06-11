select 
	mo.*,
	ca.camaDescripcion,
	ca.camaTipo
from InternacionMovimiento mo
	left join Cama ca on mo.camaCodigo = ca.camaCodigo
where 
	inteCodigo = 37649
order by
	inmoFechaDesde asc

-- select * from persona where persCodigo = 506046