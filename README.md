# Transdutor de Números Romanos para Decimais

Este projeto foi desenvolvido para a disciplina de **Linguagens Formais e Autômatos (LFA)**. Trata-se de um **Autômato Finito Determinístico (AFD)** do tipo **Transdutor de Moore**, projetado para realizar a análise sintática e a conversão de numerais romanos (no intervalo de **1 a 3999**) para o sistema decimal.

---

# Funcionalidades

### Validação Sintática

O autômato garante que a entrada respeite as regras formais de formação dos numerais romanos, rejeitando sequências inválidas como:

* repetições ilegais (`IIII`)
* subtrações inválidas (`VX`)
* ordem incorreta (`IC`)
* símbolos fora do alfabeto (`XAM`)

### Conversão por Transdução

A tradução ocorre através da emissão de símbolos de saída associados **aos estados do autômato**, conforme o modelo de **Moore**.

### Estrutura Hierárquica

A modelagem foi organizada em blocos decrescentes de magnitude:

* milhares
* centenas
* dezenas
* unidades

Essa organização garante **determinismo e clareza na modelagem do autômato**.

---

# Definição Formal do Transdutor

O transdutor é definido pela **6-tupla**:

M = (Q, Σ, Γ, δ, λ, q₀)

onde:

---

## Q — Conjunto de Estados

Os estados representam posições semânticas do número romano.

### Estado Inicial

{ q_milhar_0 }

### Estados de Milhar

{
q_milhar_1000,
q_milhar_2000,
q_milhar_3000
}

### Estados de Centena

{
q_centena_100,
q_centena_200,
q_centena_300,
q_centena_400,
q_centena_500,
q_centena_600,
q_centena_700,
q_centena_800,
q_centena_900
}

### Estados de Dezena

{
q_dezena_10,
q_dezena_20,
q_dezena_30,
q_dezena_40,
q_dezena_50,
q_dezena_60,
q_dezena_70,
q_dezena_80,
q_dezena_90
}

### Estados de Unidade

{
q_unid_1,
q_unid_2,
q_unid_3,
q_unid_4,
q_unid_5,
q_unid_6,
q_unid_7,
q_unid_8,
q_unid_9
}

---

## Σ — Alfabeto de Entrada

Σ = { I, V, X, L, C, D, M }

Cada símbolo representa um valor romano:

| Símbolo | Valor |
| ------- | ----- |
| I       | 1     |
| V       | 5     |
| X       | 10    |
| L       | 50    |
| C       | 100   |
| D       | 500   |
| M       | 1000  |

---

## Γ — Alfabeto de Saída

O alfabeto de saída contém **magnitudes decimais representadas como símbolos textuais**.

Γ = {

0, 1, 2, 3, 4, 5, 6, 7, 8, 9,

10, 20, 30, 40, 50, 60, 70, 80, 90,

100, 200, 300, 400, 500, 600, 700, 800, 900,

1000, 2000, 3000

}

Esses valores são tratados como **símbolos do alfabeto de saída**, não como valores aritméticos.

---

## δ — Função de Transição

δ : Q × Σ → Q

Define para qual estado a máquina transita ao ler um símbolo.

Exemplos formais de transição:

δ(q_milhar_0, M) = q_milhar_1000

δ(q_centena_100, C) = q_centena_200

δ(q_dezena_10, X) = q_dezena_20

δ(q_unid_5, I) = q_unid_6

Se uma transição não estiver definida, a cadeia é **rejeitada**.

---

## λ — Função de Saída (Moore)

λ : Q → Γ

No modelo de **Moore**, a saída depende exclusivamente do **estado atual**.

Exemplos:

λ(q_centena_100) = 100
λ(q_dezena_20) = 20
λ(q_unid_5) = 5

Ou seja, sempre que a máquina entra em um estado, ela **emite o símbolo associado a esse estado**.

---

## q₀ — Estado Inicial

q₀ = q_milhar_0

---

# Justificativa do Uso do Modelo de Moore

A escolha pelo modelo de **Moore** foi motivada pela clareza conceitual da modelagem.

No modelo de Moore:

* a saída depende apenas do **estado atual**
* cada estado representa uma **magnitude decimal bem definida**

Isso facilita a visualização do processo de tradução.

Embora o modelo de **Mealy** possa reduzir o número total de estados ao associar a saída às transições, o modelo de Moore torna o autômato mais intuitivo para conversores de base.

---

# Notas sobre a Implementação

A implementação foi construída com foco em **tradução formal de linguagens**, e não em cálculo numérico.

---

## Emissão simbólica

Durante o processamento da cadeia:

* os valores são tratados como **Strings**
* cada estado emite um símbolo pertencente ao alfabeto Γ

Exemplo:

λ(q_centena_100) = "100"

---

## Ausência de operações aritméticas

Durante a execução do autômato:

* **nenhuma soma é realizada**
* o sistema apenas identifica símbolos e emite saídas.

---

## Uso de `.to_i`

A conversão `.to_i` ocorre **apenas na etapa final de exibição**.

Ela serve para:

* converter os símbolos emitidos em números
* apresentar um resultado decimal legível ao usuário.

Teoricamente, o transdutor já concluiu sua tarefa ao emitir a fita de saída.

A soma final evita resultados confusos como:

```
2000300409
```

para representar o número:

```
2349
```

---

# Modelagem do Autômato

O diagrama completo do autômato foi construído utilizando **Mermaid**.

Ele pode ser encontrado em:

```
docs/Modelagem.md
```

---

# Exemplos de Execução

## Cadeias Aceitas

| Entrada | Saída emitida    | Resultado |
| ------- | ---------------- | --------- |
| CXXV    | 100, 20, 5       | 125       |
| MCX     | 1000, 10         | 1010      |
| XVIII   | 10, 8            | 18        |
| MCMXCIV | 1000, 900, 90, 4 | 1994      |

---

## Cadeias Rejeitadas

| Entrada | Motivo                   |
| ------- | ------------------------ |
| IIII    | repetição ilegal         |
| VX      | subtração inválida       |
| IC      | ordem incorreta          |
| XAM     | símbolo fora do alfabeto |

Quando ocorre uma transição indefinida, a máquina entra em **estado de erro implícito**, e a cadeia é rejeitada.

---

# Estrutura do Projeto

```
Transdutor.rb
README.md
docs/
  Modelagem.md
```

---

# Execução

Certifique-se de ter **Ruby 3.0+** instalado.

Execute no terminal:

```
ruby Transdutor.rb
```
