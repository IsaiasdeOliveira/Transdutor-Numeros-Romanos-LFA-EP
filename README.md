# Transdutor de Números Romanos para Decimais

Este projeto foi desenvolvido para a disciplina de Linguagens Formais e Autômatos (LFA). Trata-se de um Autômato Finito Determinístico (AFD) do tipo Transdutor de Moore, projetado para realizar a análise sintática e a conversão de numerais romanos (no intervalo de 1 a 3999) para o sistema decimal.

## Funcionalidades
- **Validação Sintática**: O autômato garante que a entrada respeite as regras de formação dos numerais romanos, rejeitando sequências como repetições inválidas ou ordens incorretas.
- **Conversão por Transdução**: O transdutor processa os símbolos e associa a transição de estados a uma saída de símbolo decimal correspondente.
- **Estrutura Hierárquica**: A modelagem é dividida em blocos decrescentes de grandeza (Milhares, Centenas, Dezenas e Unidades), garantindo o determinismo.

## Definição Formal (6-tupla)
O transdutor é definido como $M = (Q, \Sigma, \Gamma, \delta, \lambda, q_0)$, onde:
- **Q**: Conjunto finito de estados representando as potências de 10 e regras subtrativas.
- **$\Sigma$ (Alfabeto de Entrada)**: {I, V, X, L, C, D, M}.
- **$\Gamma$ (Alfabeto de Saída)**: Símbolos textuais (Strings) representando magnitudes decimais.
- **$\delta$ (Função de Transição)**: $\delta: Q \times \Sigma \to Q$.
- **$\lambda$ (Função de Saída)**: $\lambda: Q \to \Gamma$ (Modelo de Moore).
- **$q_0$ (Estado Inicial)**: `q_milhar_0`.

## Justificativa do Modelo de Moore
A escolha pelo modelo de Moore fundamenta-se na clareza da associação entre o estado e o valor semântico do numeral. 
- **Lógica de Estado**: No modelo de Moore, a saída é uma função exclusiva do estado atual. Isso facilita a visualização da "posição" do processamento (ex: saber que a máquina já processou as centenas e está nas dezenas).
- **Eficiência vs. Clareza**: Embora o modelo de Mealy possa reduzir o número total de estados ao associar a saída às transições, o modelo de Moore oferece uma implementação mais intuitiva para conversores de base, onde cada estado final de um bloco decimal representa um acúmulo de valor estático e bem definido.

## Notas Técnicas sobre o Fluxo e Implementação

### Processamento de Saída e Concatenação
Para manter a integridade teórica do Transdutor de Moore e evitar o uso de acumuladores aritméticos durante o processamento, a implementação segue estas premissas:

* **Emissão Simbólica**: Durante o processamento no `loop`, as magnitudes (milhar, centena, etc.) são tratadas estritamente como **Strings (Texto)**. O autômato emite símbolos textuais (ex: "1000", "50") ao atingir cada estado.
* **Ausência de Operações Aritméticas**: O autômato **não realiza somas** enquanto percorre os estados. A lógica é baseada na identificação e armazenamento de símbolos de saída ($\Gamma$).
* **Justificativa do `.to_i`**: O método `.to_i` (conversão para inteiro) é utilizado **exclusivamente na interface de exibição final**, após o encerramento do autômato. Ele serve apenas para "limpar" strings vazias e unir os símbolos emitidos em um formato decimal legível para o usuário, funcionando como uma lógica de apresentação e não de processamento interno.

## Modelagem do Autômato

A modelagem detalhada do Transdutor de Moore, incluindo o diagrama de estados e as transições de salto, pode ser visualizada no link abaixo:

[Visualizar Modelagem e Diagrama Mermaid](./docs/Modelagem.md)

## Demonstração de Fluxo e Validação

### 1. Exemplos de Sucesso (Emissão de Símbolos $\Gamma$)
Nestes casos, a máquina percorre a hierarquia de estados e, ao processar o caractere de fim de fita, emite a união dos símbolos traduzidos.

| Entrada (Romano) | Valor Decimal | Fluxo de Estados (Caminho Percorrido) | Saída do Transdutor |
| :--- | :---: | :--- | :---: |
| **CXXV** | 125 | q_milhar_0 → q_centena_100 → q_dezena_10 → q_dezena_20 → q_unid_5 | **125** |
| **MCX** | 1010 | q_milhar_0 → q_milhar_1000 → q_dezena_10 (Salto nas centenas) | **1010** |
| **XVIII** | 18 | q_milhar_0 → q_dezena_10 → q_unid_5 → q_unid_6 → q_unid_7 → q_unid_8 | **18** |
| **MCMXCIV** | 1994 | q_milhar_0 → q_milhar_1000 → q_centena_900 → q_dezena_90 → q_unid_4 | **1994** |

### 2. Exemplos de Rejeição (Sem Emissão de Símbolo)

| Entrada Inválida | Motivo da Rejeição | Comportamento do AFD |
| :--- | :--- | :--- |
| **IIII** | Repetição ilegal | Estaciona em q_unid_3 e não possui transição para o 4º símbolo I. |
| **VX** | Subtração inválida | O estado q_unid_5 (V) não possui transição para o símbolo X. |
| **IC** | Ordem incorreta | O bloco de Unidades não possui transição de retorno para Centenas. |
| **XAM** | Símbolo estranho | O símbolo 'A' não pertence ao Alfabeto de Entrada $\Sigma$. |

---

## Execução 
Certifique-se de ter o interpretador Ruby instalado no ambiente.
1. Navegue até o diretório do projeto via terminal.
2. Execute o script principal:
    ```bash
    ruby Transdutor.rb
    ```
