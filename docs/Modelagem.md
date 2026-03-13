# Modelagem Técnica do Autômato (Mermaid)

O diagrama abaixo representa a estrutura de estados de Moore. Cada nó emite um símbolo decimal (String) e as "Pontes de Salto" garantem que o autômato transite corretamente entre diferentes ordens de grandeza (ex: de Milhar direto para Unidade).

```mermaid
stateDiagram-v2
    [*] --> q_milhar_0

    state "Bloco Milhares" as Milhares {
        q_milhar_0 : Saída ""
        q_milhar_1000 : Saída "1000"
        q_milhar_2000 : Saída "2000"
        q_milhar_3000 : Saída "3000"
        
        q_milhar_0 --> q_milhar_1000: M
        q_milhar_1000 --> q_milhar_2000: M
        q_milhar_2000 --> q_milhar_3000: M
    }

    state "Bloco Centenas" as Centenas {
        q_centena_100 : Saída "100"
        q_centena_200 : Saída "200"
        q_centena_300 : Saída "300"
        q_centena_400 : Saída "400"
        q_centena_500 : Saída "500"
        q_centena_600 : Saída "600"
        q_centena_700 : Saída "700"
        q_centena_800 : Saída "800"
        q_centena_900 : Saída "900"
    }

    state "Bloco Dezenas" as Dezenas {
        q_dezena_10 : Saída "10"
        q_dezena_20 : Saída "20"
        q_dezena_30 : Saída "30"
        q_dezena_40 : Saída "40"
        q_dezena_50 : Saída "50"
        q_dezena_60 : Saída "60"
        q_dezena_70 : Saída "70"
        q_dezena_80 : Saída "80"
        q_dezena_90 : Saída "90"
    }

    state "Bloco Unidades" as Unidades {
        q_unid_1 : Saída "1"
        q_unid_2 : Saída "2"
        q_unid_3 : Saída "3"
        q_unid_4 : Saída "4"
        q_unid_5 : Saída "5"
        q_unid_6 : Saída "6"
        q_unid_7 : Saída "7"
        q_unid_8 : Saída "8"
        q_unid_9 : Saída "9"
    }

    %% Pontes de Conectividade Total (Garantem saltos entre classes)
    q_milhar_0 --> Centenas : C, D
    q_milhar_0 --> Dezenas : X, L
    q_milhar_0 --> Unidades : I, V

    Milhares --> Centenas : C, D
    Milhares --> Dezenas : X, L
    Milhares --> Unidades : I, V

    Centenas --> Dezenas : X, L
    Centenas --> Unidades : I, V

    Dezenas --> Unidades : I, V

    %% Estados de Aceitação (Fim de fita)
    Milhares --> [*] : ""
    Centenas --> [*] : ""
    Dezenas --> [*] : ""
    Unidades --> [*] : ""