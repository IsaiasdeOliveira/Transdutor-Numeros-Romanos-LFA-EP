### Diagrama de Estados (Mermaid)

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
        q_centena_100 --> q_centena_400: D
        q_centena_0 --> q_centena_500: D
        q_centena_100 --> q_centena_900: M
    }

    state "Bloco Dezenas" as Dezenas {
        q_dezena_0 --> q_dezena_10: X
        q_dezena_10 --> q_dezena_20: X
        q_dezena_10 --> q_dezena_40: L
        q_dezena_0 --> q_dezena_50: L
        q_dezena_10 --> q_dezena_90: C
    }

    state "Bloco Unidades" as Unidades {
        q_unid_0 --> q_unid_1: I
        q_unid_1 --> q_unid_2: I
        q_unid_1 --> q_unid_4: V
        q_unid_0 --> q_unid_5: V
        q_unid_1 --> q_unid_9: X
    }

    %% Conexões de Hierarquia (Saltos de Classe)
    q_milhar_1000 --> q_centena_100: C
    q_milhar_1000 --> q_centena_500: D
    q_milhar_1000 --> q_dezena_10: X
    
    q_centena_100 --> q_dezena_10: X
    q_centena_100 --> q_dezena_50: L
    q_centena_100 --> q_unid_1: I

    q_dezena_10 --> q_unid_1: I
    q_dezena_10 --> q_unid_5: V

    %% Aceitação Final (Fim da Cadeia)
    Unidades --> [*]: ""
    Dezenas --> [*]: ""
    Centenas --> [*]: ""
    Milhares --> [*]: ""
```

## Nota:
 Para fins de clareza visual, o diagrama apresenta as transições principais. As repetições subsequentes (como 300, 700, 800, e os outros) seguem a mesma lógica determinística apresentada nas transições base.