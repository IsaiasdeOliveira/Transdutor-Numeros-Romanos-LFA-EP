# Transdutor de Números Romanos para Decimais

Este projeto foi desenvolvido para a disciplina de Linguagens Formais e Autômatos (LFA). Trata-se de um Autômato Finito Determinístico (AFD) do tipo Transdutor de Moore, projetado para realizar a análise sintática e a conversão de numérais romanos (no intervalo de 1 a 3999) para o sistema decimal.

## Funcionalidades
- Validação Sintática: O autômato garante que a entrada respeite as regras de formação dos numérais romanos, rejeitando sequências como repetições inválidas ou ordens incorretas.
- Conversão Direta: O transdutor processa os símbolos e associa a transição de estados a uma saída numérica correspondente.
- Estrutura Hierárquica: A modelagem é dividida em blocos decrescentes de grandeza (Milhares, Centenas, Dezenas e Unidades), garantindo o determinismo.

## Definição Formal (6-tupla)
O transdutor é definido como M = (Q, Σ, Γ, δ, λ, q0), onde:
- Q: Conjunto finito de estados representando as potências de 10 e regras subtrativas.
- Σ (Alfabeto de Entrada): {I, V, X, L, C, D, M}.
- Γ (Alfabeto de Saída): Inteiros pertencentes ao conjunto {0, ..., 3999}.
- δ (Função de Transição): δ: Q × Σ → Q.
- λ (Função de Saída): λ: Q → Γ (Modelo de Moore).
- q0 (Estado Inicial): q_milhar_0.

## Justificativa do Modelo de Moore
A escolha pelo modelo de Moore fundamenta-se na clareza da associação entre o estado e o valor semântico do numeral. 
- Lógica de Estado: No modelo de Moore, a saída é uma função exclusiva do estado atual. Isso facilita a visualização da "posição" do processamento (ex: saber que a maquina já processou as centenas e está nas dezenas).
- Eficiência vs. Clareza: Embora o modelo de Mealy possa reduzir o número total de estados ao associar a saída as transições, o modelo de Moore oferece uma implementação mais intuitiva para conversores de base, onde cada estado final de um bloco decimal representa um acúmulo de valor estático e bem definido.

## Modelagem do Autômato

A modelagem detalhada do Transdutor de Moore, incluindo o diagrama de estados e as transições de salto, pode ser visualizada no link abaixo:

 [Visualizar Modelagem e Diagrama Mermaid](./docs/MODELAGEM.md)

## Demonstração de Fluxo e Validação

Abaixo, detalha-se o comportamento do autômato perante diferentes classes de cadeias de entrada.

### 1. Exemplos de Sucesso (Emissão de Símbolos Γ)
Nestes casos, a máquina percorre a hierarquia de estados e, ao processar o caractere de fim de cadeia, emite a soma dos valores acumulados nos estados de aceitação.

| Entrada (Romano) | Valor Decimal | Fluxo de Estados (Caminho Percorrido) | Saída do Transdutor |
| :--- | :---: | :--- | :---: |
| **CXXV** | 125 | q_milhar_0 → q_centena_100 → q_dezena_10 → q_dezena_20 → q_unid_5 | **125** |
| **MCX** | 1010 | q_milhar_0 → q_milhar_1000 → q_dezena_10 (Salto nas centenas) | **1010** |
| **XVIII** | 18 | q_milhar_0 → q_dezena_10 → q_unid_5 → q_unid_6 → q_unid_7 → q_unid_8 | **18** |
| **MCMXCIV** | 1994 | q_milhar_0 → q_milhar_1000 → q_centena_900 → q_dezena_90 → q_unid_4 | **1994** |

### 2. Exemplos de Rejeição (Sem Emissão de Símbolo)
Cadeias que violam a gramática nao permitem que o autômato atinja um estado de saída para o símbolo de encerramento, resultando em erro de processamento.

| Entrada Inválida | Motivo da Rejeição | Comportamento do AFD |
| :--- | :--- | :--- |
| **IIII** | Repetição ilegal | Estaciona em q_unid_3 e não possui transição para o 4 símbolo I. |
| **VX** | Subtração inválida | O estado q_unid_5 (V) não possui transição para o símbolo X. |
| **IC** | Ordem incorreta | O bloco de Unidades não possui transição de retorno para Centenas. |
| **XAM** | Símbolo estranho | O símbolo A nao pertence ao Alfabeto de Entrada Σ. |

---

### Notas Técnicas sobre o Fluxo
- Cadeias de Transição Multipla: Números compostos como CXXV validam a robustez das "pontes" de conexão entre blocos, garantindo que o acumulador de valor transite corretamente entre diferentes ordens de grandeza.
- Salto de Classe (Zero Implícito): A capacidade de transitar diretamente entre blocos nao adjacentes (ex: Milhar para Dezena) permite que o autômato processe o valor zero em determinadas casas decimais sem a necessidade de símbolos explícitos, mantendo o determinismo do AFD.

## Execução 
Certifique-se de ter o interpretador Ruby instalado no ambiente.
1. Navegue ate o diretório do projeto via terminal.
2. Execute o script principal:
    ```bash
    ruby Transdutor.rb
    ```
