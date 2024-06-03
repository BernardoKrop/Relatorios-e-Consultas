-----------------------------------------------------------------------------
--27/10/2023			VIEW ORDEM DE SERVIÇO DA OFICINA
-----------------------------------------------------------------------------
/* ORDEM DE SERVICO DA OFICINA vw_fOS_Oficina */
BEGIN TRANSACTION ;

SET SCHEMA SBO_MULTIFAZENDAS;
	--DROP VIEW "SBO_MULTIFAZENDAS"."vw_fOS_Oficina"
	CREATE VIEW "SBO_MULTIFAZENDAS"."vw_fOS_Oficina"
		(
		nk_OrdemServicoCod ,
		FazendaCod ,
		TalhaoCod ,
		OrdemServico_Interna ,
		Origem ,
		FrotaCod ,
		ManutencaoCod ,
		Manutencao_TipoCod ,
		Data_OSIni ,
		Data_MecanicaFim ,
		Data_OsFim ,
		OperadorCod ,
		Hori_Inicio ,
		Hori_Fim ,
		Horimetro_Total ,
		Hora_OSInicio ,
		Hora_OSFim
			) AS 
				SELECT
				"DocEntry" AS nk_OrdemServicoCod ,
				"U_CodFazenda" AS FazendaCod ,
				(
					SELECT
						COALESCE ( dTalhao."Code" , 'ND' ) 
						FROM
							"@AGRI_UNPF" AS dFazenda -- Dimensão Fazenda @AGRI
							LEFT JOIN "@AGRI_UNPT" AS dTalhao -- Dimensão Talhão @AGRI
								ON dFazenda."Code" = dTalhao."U_CodUnPrFaz"
						WHERE
							dFazenda."Code" = fOSOficina."U_CodFazenda"
							AND fOSOficina."Canceled" = 'N'
				 ) AS TalhaoCod , --Deve ser limitado a data previa da inserção de novos talhões.								
				COALESCE ( "U_Numero" , 'ND' ) AS OrdemServico_Interna ,
				CASE
					WHEN "U_Origem" = 'I' 
					THEN 'Interno'
					WHEN "U_Origem" = 'T'
					THEN 'Terceiro'
					WHEN "U_Origem" = 'C'
					THEN 'Campo'
					WHEN "U_Origem" = 'P'
					THEN 'Planejamento'
					ELSE 'ND'
				END AS Origem , -- I = Interno , T = Terceiro , C = Campo , P = Planejada
				COALESCE ( "U_CodEquipam" , -1 ) AS FrotaCod ,
				COALESCE ( "U_CodMotivo" , -1 ) AS ManutencaoCod ,
				COALESCE ( "U_CodClassMa" , -1 ) AS Manutencao_TipoCod ,
				CAST ( "U_DtEntrada" AS DATE ) AS Data_OSIni,-- Também é a entrada na mecanica
				CAST ( "U_DtSaida" AS DATE ) AS Data_MecanicaFim_, -- A dif entre dt encerrada e saida vai expor o tempo parado pos reparo
				CAST (  "U_DtEncerram" AS DATE ) AS Data_OsFim, -- vai ditar se esta disponivel ou não
				COALESCE ( "U_CodOperador" , -1 ) AS OperadorCod ,
				"U_HoriHodoEnt" AS Hori_Inicio ,
				"U_HorimOdome" AS Hori_Fim ,
				( "U_HorimOdome" -
					CASE
						WHEN "U_HorimOdome" - "U_HoriHodoEnt" < 0
						THEN "U_HorimOdome" 
						ELSE "U_HoriHodoEnt"
					END ) AS Horimetro_Total ,
				"U_HoraEntrada" AS Hora_OSInicio ,
				( SELECT
					MAX ( fLogOSOficina."U_Hora" )
					FROM
						"@AGRI_OSOF3" AS fLogOSOficina -- Log de Alterações da OSOF
					WHERE
						fLogOSOficina."U_Avanco" = 'F'
						AND fOSOficina."DocEntry" = fLogOSOficina."DocEntry"
						AND fOSOficina."Canceled" = 'N' ) AS Hora_OSFim -- D = Diagnostico , P = Aguard. Peça , S = Aguard. Serviço , E = Executanto , F = Finalizado , N = Aguardando NF.
					FROM
						"@AGRI_OSOF" AS fOSOficina -- Fato da Ordem de Serviço Oficina
					WHERE
						"Canceled" = 'N' ;
					
COMMIT ;
--ROLLBACK ;

SELECT * FROM "SBO_MULTIFAZENDAS"."vw_fOS_Oficina"
			