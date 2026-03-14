class ADF
  def initialize(cadeia)
    @cadeia = cadeia.upcase
    @indice = 0
    @max = cadeia.size
  end

  def proximo
    if @indice == @max
      ""
    else
      @cadeia[@indice]
    end
  end

  def iniciar

    # Estado inicial conforme a definição formal (q0) e logica de construção do Transdutor 
    # de Moore para números romanos.

    estado = "q_milhar_0"

    # Alfabeto de Saída (Gamma): Símbolos decimais tratados como strings

    # Representam as saídas associadas a cada estado de acordo com a função de saída (lambda) 
    #da Máquina de Moore.

    milhar = ""
    centena = ""
    dezena = ""
    unidade = ""

    puts "--- INICIANDO TRADUÇÃO (TRANSDUTOR DE MOORE) ---"
    puts "Estado inicial: #{estado}"

    loop do

      simbolo = proximo

      # --- FUNÇÃO DE TRANSIÇÃO (DELTA) ---

      # Decide o próximo estado baseado no par [símbolo, estado_atual]

      case [simbolo, estado]

      # ---------------- MILHAR ----------------

      in ["M", "q_milhar_0"]
        estado = "q_milhar_1000" #usa o estado para indicar que já leu um 'M' e, portanto, tem 1000 na saída.

      in ["M", "q_milhar_1000"]
        estado = "q_milhar_2000"

      in ["M", "q_milhar_2000"]
        estado = "q_milhar_3000"

      # ---------------- CENTENA ----------------

      in ["C", "q_milhar_0"] | ["C", "q_milhar_1000"] | ["C", "q_milhar_2000"] | ["C", "q_milhar_3000"]
        estado = "q_centena_100"

      in ["C", "q_centena_100"]
        estado = "q_centena_200"

      in ["C", "q_centena_200"]
        estado = "q_centena_300"

      in ["D", "q_centena_100"]
        estado = "q_centena_400"

      in ["D", "q_milhar_0"] | ["D", "q_milhar_1000"] | ["D", "q_milhar_2000"] | ["D", "q_milhar_3000"]
        estado = "q_centena_500"

      in ["C", "q_centena_500"]
        estado = "q_centena_600"

      in ["C", "q_centena_600"]
        estado = "q_centena_700"

      in ["C", "q_centena_700"]
        estado = "q_centena_800"

      in ["M", "q_centena_100"]
        estado = "q_centena_900"

      # ---------------- DEZENA ----------------

      in ["X", "q_milhar_0"] | ["X", "q_milhar_1000"] | ["X", "q_milhar_2000"] | ["X", "q_milhar_3000"] |
         ["X", "q_centena_100"] | ["X", "q_centena_200"] | ["X", "q_centena_300"] | ["X", "q_centena_500"] |
         ["X", "q_centena_600"] | ["X", "q_centena_700"] | ["X", "q_centena_800"] | ["X", "q_centena_900"]

        estado = "q_dezena_10"

      in ["X", "q_dezena_10"]
        estado = "q_dezena_20"

      in ["X", "q_dezena_20"]
        estado = "q_dezena_30"

      in ["L", "q_dezena_10"]
        estado = "q_dezena_40"

      in ["L", "q_milhar_0"] | ["L", "q_milhar_1000"] | ["L", "q_milhar_2000"] | ["L", "q_milhar_3000"] |
         ["L", "q_centena_100"] | ["L", "q_centena_200"] | ["L", "q_centena_300"] | ["L", "q_centena_500"] |
         ["L", "q_centena_600"] | ["L", "q_centena_700"] | ["L", "q_centena_800"] | ["L", "q_centena_900"]

        estado = "q_dezena_50"

      in ["X", "q_dezena_50"]
        estado = "q_dezena_60"

      in ["X", "q_dezena_60"]
        estado = "q_dezena_70"

      in ["X", "q_dezena_70"]
        estado = "q_dezena_80"

      in ["C", "q_dezena_10"]
        estado = "q_dezena_90"

      # ---------------- UNIDADE ----------------

      in ["I", "q_milhar_0"] | ["I", "q_milhar_1000"] | ["I", "q_milhar_2000"] | ["I", "q_milhar_3000"] |
         ["I", "q_centena_100"] | ["I", "q_centena_500"] | ["I", "q_centena_900"] |
         ["I", "q_dezena_10"] | ["I", "q_dezena_20"] | ["I", "q_dezena_30"] | ["I", "q_dezena_40"] |
         ["I", "q_dezena_50"] | ["I", "q_dezena_60"] | ["I", "q_dezena_70"] | ["I", "q_dezena_80"] |
         ["I", "q_dezena_90"]

        estado = "q_unid_1"

      in ["I", "q_unid_1"]
        estado = "q_unid_2"

      in ["I", "q_unid_2"]
        estado = "q_unid_3"

      in ["V", "q_unid_1"]
        estado = "q_unid_4"

      in ["V", "q_milhar_0"] | ["V", "q_milhar_1000"] | ["V", "q_milhar_2000"] | ["V", "q_milhar_3000"] |
         ["V", "q_centena_100"] | ["V", "q_centena_500"] | ["V", "q_dezena_10"] | ["V", "q_dezena_20"] | 
         ["V", "q_dezena_30"]| ["V", "q_dezena_40"] |["V", "q_dezena_50"] | ["V", "q_dezena_90"]

        estado = "q_unid_5"

      in ["I", "q_unid_5"]
        estado = "q_unid_6"

      in ["I", "q_unid_6"]
        estado = "q_unid_7"

      in ["I", "q_unid_7"]
        estado = "q_unid_8"

      in ["X", "q_unid_1"]
        estado = "q_unid_9"

      # --- CONDIÇÃO DE ACEITAÇÃO ---

      in ["", _]

        puts "\n[FIM DA FITA]"

        puts "Fita de saída: #{milhar} #{centena} #{dezena} #{unidade}"

        # INTERPRETAÇÃO DECIMAL (Opcional)

        # O uso de .to_i e soma ocorre APENAS para visualização humana do resultado.

        # Teoricante, o Transdutor encerrou sua tarefa ao emitir os símbolos de saída acima.

        # A soma evita saídas confusas como "2000300409" para o número 2349.

        resultado = milhar.to_i + centena.to_i + dezena.to_i + unidade.to_i

        puts "Interpretação decimal: #{resultado}"

        break

        in [_, "q_erro"]
         estado = "q_erro"

      else
        estado = "q_erro"
      end

      if estado == "q_erro"

       puts "\nERRO: símbolo '#{simbolo}' inválido"

      break

      end

      # --- FUNÇÃO DE SAÍDA (LAMBDA) ---

      # Em uma Máquina de Moore, a saída depende exclusivamente do ESTADO atual.

      case estado
      
      #Usa then para associar a saída ao estado, garantindo que a saída seja atualizada corretamente 
      #após cada transição de estado.

      in "q_milhar_1000" then milhar = "1000"
      in "q_milhar_2000" then milhar = "2000"
      in "q_milhar_3000" then milhar = "3000"

      in "q_centena_100" then centena = "100"
      in "q_centena_200" then centena = "200"
      in "q_centena_300" then centena = "300"
      in "q_centena_400" then centena = "400"
      in "q_centena_500" then centena = "500"
      in "q_centena_600" then centena = "600"
      in "q_centena_700" then centena = "700"
      in "q_centena_800" then centena = "800"
      in "q_centena_900" then centena = "900"

      in "q_dezena_10" then dezena = "10"
      in "q_dezena_20" then dezena = "20"
      in "q_dezena_30" then dezena = "30"
      in "q_dezena_40" then dezena = "40"
      in "q_dezena_50" then dezena = "50"
      in "q_dezena_60" then dezena = "60"
      in "q_dezena_70" then dezena = "70"
      in "q_dezena_80" then dezena = "80"
      in "q_dezena_90" then dezena = "90"

      in "q_unid_1" then unidade = "1"
      in "q_unid_2" then unidade = "2"
      in "q_unid_3" then unidade = "3"
      in "q_unid_4" then unidade = "4"
      in "q_unid_5" then unidade = "5"
      in "q_unid_6" then unidade = "6"
      in "q_unid_7" then unidade = "7"
      in "q_unid_8" then unidade = "8"
      in "q_unid_9" then unidade = "9"  

      end

      @indice += 1

      puts "Lendo: #{simbolo} -> Estado: #{estado}"
      puts "Saída parcial: #{milhar} #{centena} #{dezena} #{unidade}"

    end
  end
end


print "Digite o número romano: "
entrada = gets.chomp

adf = ADF.new(entrada)
adf.iniciar