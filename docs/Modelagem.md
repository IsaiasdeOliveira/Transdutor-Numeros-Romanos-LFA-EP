# Modelagem Tecnica do Automato (Mermaid)

Este documento apresenta a representacao visual completa do Transdutor de Moore. O diagrama abaixo reflete todas as transicoes de estado implementadas no codigo-fonte para garantir o determinismo e a correta conversao de numerais romanos ate 3999.

```mermaid
stateDiagram-v2
    [*] --> q_milhar_0

    state "Bloco Milhares" as Milhares {
        q_milhar_0 --> q_milhar_1000: M
        q_milhar_1000 --> q_milhar_2000: M
        q_milhar_2000 --> q_milhar_3000: M
    }

    state "Bloco Centenas" as Centenas {
        q_centena_0 --> q_centena_100: C
        q_centena_100 --> q_centena_200: C
        q_centena_200 --> q_centena_300: C
        q_centena_100 --> q_centena_400: D
        q_centena_0 --> q_centena_500: D
        q_centena_500 --> q_centena_600: C
        q_centena_600 --> q_centena_700: C
        q_centena_700 --> q_centena_800: C
        q_centena_100 --> q_centena_900: M
    }

    state "Bloco Dezenas" as Dezenas {
        q_dezena_0 --> q_dezena_10: X
        q_dezena_10 --> q_dezena_20: X
        q_dezena_20 --> q_dezena_30: X
        q_dezena_10 --> q_dezena_40: L
        q_dezena_0 --> q_dezena_50: L
        q_dezena_50 --> q_dezena_60: X
        q_dezena_60 --> q_dezena_70: X
        q_dezena_70 --> q_dezena_80: X
        q_dezena_10 --> q_dezena_90: C
    }

    state "Bloco Unidades" as Unidades {
        q_unid_0 --> q_unid_1: I
        q_unid_1 --> q_unid_2: I
        q_unid_2 --> q_unid_3: I
        q_unid_1 --> q_unid_4: V
        q_unid_0 --> q_unid_5: V
        q_unid_5 --> q_unid_6: I
        q_unid_6 --> q_unid_7: I
        q_unid_7 --> q_unid_8: I
        q_unid_1 --> q_unid_9: X
    }

    %% Conexoes de Salto (Pontes de Hierarquia)
    q_milhar_1000 --> Centenas: C, D
    q_milhar_2000 --> Centenas: C, D
    q_milhar_3000 --> Centenas: C, D
    
    Milhares --> Dezenas: X, L
    Centenas --> Dezenas: X, L
    
    Dezenas --> Unidades: I, V
    Centenas --> Unidades: I, V
    Milhares --> Unidades: I, V

    %% Estados de Aceitacao
    Milhares --> [*]: ""
    Centenas --> [*]: ""
    Dezenas --> [*]: ""
    Unidades --> [*]: ""