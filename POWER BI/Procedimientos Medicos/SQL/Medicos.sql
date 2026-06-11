select
	m.mediCodigo,
	p.persApellido +' , ' + p.persNombre as medico
from Medico m
	left join Persona p on m.mediCodigo = p.persCodigo
where
	m.mediActivo = 1
order by p.persApellido, p.persNombre