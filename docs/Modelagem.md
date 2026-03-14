# Modelagem do Autômato

Este documento apresenta a **modelagem do Autômato Finito Determinístico (AFD)** utilizado no projeto de conversão de números romanos para decimais.

A máquina foi implementada como um **Transdutor de Moore**, no qual a saída depende exclusivamente do **estado atual**.

---

# Organização do Autômato

O autômato foi organizado em quatro blocos principais:

1. Milhares
2. Centenas
3. Dezenas
4. Unidades

Cada bloco representa uma **magnitude decimal**, e os estados indicam o valor acumulado daquela magnitude.

---

# Diagrama do Autômato

```mermaid
stateDiagram-v2

[*] --> q_milhar_0

q_milhar_0 --> q_milhar_1000 : M
q_milhar_1000 --> q_milhar_2000 : M
q_milhar_2000 --> q_milhar_3000 : M

q_milhar_0 --> q_centena_100 : C
q_milhar_1000 --> q_centena_100 : C
q_milhar_2000 --> q_centena_100 : C
q_milhar_3000 --> q_centena_100 : C

q_centena_100 --> q_centena_200 : C
q_centena_200 --> q_centena_300 : C

q_centena_100 --> q_centena_400 : D

q_milhar_0 --> q_centena_500 : D
q_milhar_1000 --> q_centena_500 : D
q_milhar_2000 --> q_centena_500 : D
q_milhar_3000 --> q_centena_500 : D

q_centena_500 --> q_centena_600 : C
q_centena_600 --> q_centena_700 : C
q_centena_700 --> q_centena_800 : C

q_centena_100 --> q_centena_900 : M

q_centena_100 --> q_dezena_10 : X
q_centena_200 --> q_dezena_10 : X
q_centena_300 --> q_dezena_10 : X
q_centena_500 --> q_dezena_10 : X
q_centena_600 --> q_dezena_10 : X
q_centena_700 --> q_dezena_10 : X
q_centena_800 --> q_dezena_10 : X
q_centena_900 --> q_dezena_10 : X

q_dezena_10 --> q_dezena_20 : X
q_dezena_20 --> q_dezena_30 : X

q_dezena_10 --> q_dezena_40 : L

q_dezena_10 --> q_dezena_50 : L
q_dezena_50 --> q_dezena_60 : X
q_dezena_60 --> q_dezena_70 : X
q_dezena_70 --> q_dezena_80 : X

q_dezena_10 --> q_dezena_90 : C

q_dezena_10 --> q_unid_1 : I
q_dezena_20 --> q_unid_1 : I
q_dezena_30 --> q_unid_1 : I
q_dezena_40 --> q_unid_1 : I
q_dezena_50 --> q_unid_1 : I
q_dezena_60 --> q_unid_1 : I
q_dezena_70 --> q_unid_1 : I
q_dezena_80 --> q_unid_1 : I
q_dezena_90 --> q_unid_1 : I

q_unid_1 --> q_unid_2 : I
q_unid_2 --> q_unid_3 : I

q_unid_1 --> q_unid_4 : V

q_unid_5 --> q_unid_6 : I
q_unid_6 --> q_unid_7 : I
q_unid_7 --> q_unid_8 : I

q_unid_1 --> q_unid_9 : X
```

---

# Interpretação do Diagrama

Cada estado representa um **valor semântico da tradução**.

Por exemplo:

| Estado        | Valor emitido |
| ------------- | ------------- |
| q_milhar_1000 | 1000          |
| q_centena_500 | 500           |
| q_dezena_40   | 40            |
| q_unid_9      | 9             |

Sempre que a máquina entra em um estado, o valor associado é emitido conforme a função de saída **λ (lambda)** do modelo de Moore.

---

# Observação Teórica

Em um **Transdutor de Moore**:

* a função de saída depende **somente do estado**
* não depende do símbolo de entrada

Formalmente:

λ : Q → Γ

Essa característica torna a modelagem particularmente adequada para **conversores de representação numérica**, pois cada estado pode representar diretamente uma magnitude decimal.

---

# Conclusão

A modelagem apresentada garante:

* determinismo
* validação sintática dos numerais romanos
* conversão correta para decimal
* aderência ao modelo formal de **Transdutor de Moore**

O autômato aceita cadeias válidas no intervalo de **1 a 3999** e rejeita cadeias que não obedecem às regras da numeração romana clássica.
