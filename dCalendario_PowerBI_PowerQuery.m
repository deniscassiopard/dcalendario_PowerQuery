// ==========================================
// Autor: Denis Cassio Pardinho
// Data: 12/11/2023 23:43:12
// Descrição: Gera uma tabela de calendário dinâmica para Power BI
// Versão: 1.0
// Repositório: https://github.com/deniscassiopard/dcalendario-PowerQuery
// Licença: MIT
// ==========================================

let
    // Definição de datas inicial e final
    StartDate = #date(2020, 1, 1), // Você pode alterar para uma variavel.
    EndDate = Date.From(DateTimeZone.LocalNow()), //Data final do calendário (data atual do sistema)

    // Cria uma lista com todas as datas entre StartDate e EndDate
    ListaDatas = List.Dates(
        StartDate,
        Duration.Days(EndDate - StartDate) + 1,
        #duration(1, 0, 0, 0)
    ),

    // Transformamos cada data em um "record" com todas as colunas do calendário.
    dCalendario = Table.FromRecords(
        List.Transform(
            ListaDatas,
            each [
                Data = _,
                Ano = Date.Year(_),
                #"Mês (número)" = Date.Month(_),
                #"Mês (nome)" = Date.ToText(_, "MMM", "pt-BR"),
                #"Dia (número)" = Date.Day(_),
                #"DiaSemana (número)" = Date.DayOfWeek(_, Day.Monday) + 1,
                #"Dia Útil" = 
                    if (Date.DayOfWeek(_, Day.Monday) + 1) <= 5 
                    then "Sim" 
                    else "Não",
				#"MêsAno" = Date.ToText(_, "MMM-yy", "pt-BR"),
				#"Dia e DiaSemana (nome)" = Date.ToText(_, "dd-ddd", "pt-BR"),
                #"DiaSemana (nome)" = Date.ToText(_, "dddd", "pt-BR"),
                Trimestre = "T" & Number.ToText(Date.QuarterOfYear(_)),
                #"Ano-Mês" = Date.ToText(_, "yyyy-MM"),
                AnoTrimestre = Text.From(Date.Year(_)) & "T" & Text.From(Date.QuarterOfYear(_))
            ]
        )
    ),
    // Tipo Alterado: converte as colunas para os tipos adequados (date, number, text, entre outros)
    #"Tipo Alterado" = Table.TransformColumnTypes(
        dCalendario,
        {
            {"Data", type date},               // Data vira tipo date
            {"Ano", Int64.Type},               // Ano vira número inteiro
            {"Mês (número)", Int64.Type},      // Mês (número) vira número inteiro
            {"Mês (nome)", type text},         // Mês (nome) vira texto
            {"Dia (número)", Int64.Type},      // Dia (número) vira número inteiro
            {"DiaSemana (número)", Int64.Type},// DiaSemana (número) vira número inteiro
            {"Dia Útil", type text},           // Dia Útil (Sim/Não) vira texto
            {"MêsAno", type text},             // MêsAno (ex: "jan-25") vira texto
            {"Dia e DiaSemana (nome)", type text}, // "dd-ddd" vira texto
            {"DiaSemana (nome)", type text},   // Nome do dia da semana vira texto
            {"Trimestre", type text},          // T1, T2, vira texto
            {"Ano-Mês", type text},            // "2025-01" vira texto
            {"AnoTrimestre", type text}        // "2025T1" vira texto
        }
    )
in
    // Retorna a tabela final, com o nome "Tipo Alterado"
    #"Tipo Alterado"