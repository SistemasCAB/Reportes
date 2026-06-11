use ClinicaAdventista

DECLARE @desde DATETIME = '2025-01-01 00:00:00';
DECLARE @hasta DATETIME = '2025-01-31 23:59:59';

SELECT
    i.inteCodigo,
    i.paciCodigo,
    p.persNroDocumento,
    p.persApellido,
    p.persNombre,
    CONVERT(date, p.persFechaNacimiento) AS fechaNacimiento,
    EdadIngreso = DATEDIFF(YEAR, p.persFechaNacimiento, i.inteFechaIngreso)
           - CASE 
                WHEN DATEADD(YEAR, DATEDIFF(YEAR, p.persFechaNacimiento, i.inteFechaIngreso), p.persFechaNacimiento) > i.inteFechaIngreso
                THEN 1 
                ELSE 0 
             END,
    ingreso = i.inteFechaIngreso,
    egreso = i.inteFechaEgreso,
    tipoInternacion = ti.tiinDescripcion,
    tipoAlta = ta.taltDescripcion,
    mediCodigoIngreso = i.mediCodigo,
    medicoIngreso = me.persApellido + ' ' + me.persNombre,
    fechaEpicrisis = epi.entrFechaAtencion,
    medicoEpicrisis = epme.persApellido + ' ' + epme.persNombre
FROM Internacion i
    LEFT JOIN TipoInternacion ti ON i.tiinCodigo = ti.tiinCodigo
    LEFT JOIN TipoAlta ta ON i.taltCodigo = ta.taltCodigo
    LEFT JOIN Persona p ON i.paciCodigo = p.persCodigo
    LEFT JOIN Persona me ON i.mediCodigo = me.persCodigo

    OUTER APPLY (
        SELECT TOP (1) e.*
        FROM Entrada e
        WHERE e.inteCodigo = i.inteCodigo
          AND e.grtiCodigo = 10015
        ORDER BY e.entrFechaAtencion ASC
    ) epi

    LEFT JOIN Persona epme ON epi.mediCodigo = epme.persCodigo
WHERE
    i.inteFechaIngreso <= @hasta
    AND i.inteFechaEgreso >= @hasta
    AND i.paciCodigo NOT IN (403371, 477619)
ORDER BY ingreso