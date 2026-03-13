class ADF
  def initialize(cadeia)
    @cadeia = cadeia.upcase
    @indice = 0
    @max = cadeia.size
  end

  def proximo
    @indice == @max ? "" : @cadeia[@indice]
  end
  
  def iniciar

    estado = "q_milhar_0"

    milhar = ""; 

    centena = ""; 

    dezena = ""; 

    unidade = ""
  
    puts "--- INICIANDO TRADUCAO (TRANSIDUTOR DE MOORE) ---"

    puts "Estado inicial: #{estado}"
  
    loop do
      simbolo = proximo
  
      case [simbolo, estado]

      # --- BLOCO MILHARES ---
      in ["M", "q_milhar_0"]
        estado = "q_milhar_1000"; milhar = "1000"

      in ["M", "q_milhar_1000"]
        estado = "q_milhar_2000"; milhar = "2000"

      in ["M", "q_milhar_2000"]
        estado = "q_milhar_3000"; milhar = "3000"

      # --- BLOCO CENTENAS ---
      in ["C", "q_milhar_0"] | ["C", "q_milhar_1000"] | ["C", "q_milhar_2000"] | ["C", "q_milhar_3000"]
        estado = "q_centena_100"; centena = "100"

      in ["C", "q_centena_100"]
        estado = "q_centena_200"; centena = "200"

      in ["C", "q_centena_200"]
        estado = "q_centena_300"; centena = "300"

      in ["D", "q_centena_100"]
        estado = "q_centena_400"; centena = "400"

      in ["D", "q_milhar_0"] | ["D", "q_milhar_1000"] | ["D", "q_milhar_2000"] | ["D", "q_milhar_3000"]
        estado = "q_centena_500"; centena = "500"

      in ["C", "q_centena_500"]
        estado = "q_centena_600"; centena = "600"

      in ["C", "q_centena_600"]
        estado = "q_centena_700"; centena = "700"

      in ["C", "q_centena_700"]
        estado = "q_centena_800"; centena = "800"

      in ["M", "q_centena_100"]
        estado = "q_centena_900"; centena = "900"

      # --- BLOCO DEZENAS ---
      in ["X", "q_milhar_0"] | ["X", "q_milhar_1000"] | ["X", "q_milhar_2000"] | ["X", "q_milhar_3000"] | 
         ["X", "q_centena_100"] | ["X", "q_centena_200"] | ["X", "q_centena_300"] | ["X", "q_centena_500"]| 
         ["X", "q_centena_600"] | ["X", "q_centena_700"] | ["X", "q_centena_800"] | ["X", "q_centena_900"]
        estado = "q_dezena_10"; dezena = "10"

      in ["X", "q_dezena_10"]
        estado = "q_dezena_20"; dezena = "20"

      in ["X", "q_dezena_20"]
        estado = "q_dezena_30"; dezena = "30"

      in ["L", "q_dezena_10"]
        estado = "q_dezena_40"; dezena = "40"

      in ["L", "q_milhar_0"] | ["L", "q_milhar_1000"] | ["L", "q_milhar_2000"] | ["L", "q_milhar_3000"] |
         ["L", "q_centena_100"] | ["L", "q_centena_200"] | ["L", "q_centena_300"] | ["L", "q_centena_500"]|
         ["L", "q_centena_600"] | ["L", "q_centena_700"] | ["L", "q_centena_800"] | ["L", "q_centena_900"]
        estado = "q_dezena_50"; dezena = "50"

      in ["X", "q_dezena_50"]
        estado = "q_dezena_60"; dezena = "60"

      in ["X", "q_dezena_60"]
        estado = "q_dezena_70"; dezena = "70"

      in ["X", "q_dezena_70"]
        estado = "q_dezena_80"; dezena = "80"

      in ["C", "q_dezena_10"]
        estado = "q_dezena_90"; dezena = "90"

      # --- BLOCO UNIDADES ---
      in ["I", "q_milhar_0"] | ["I", "q_milhar_1000"] | ["I", "q_milhar_2000"] | ["I", "q_milhar_3000"] | 
         ["I", "q_centena_100"] | ["I", "q_centena_500"] | ["I", "q_centena_900"] |
         ["I", "q_dezena_10"] | ["I", "q_dezena_20"] | ["I", "q_dezena_30"] | ["I", "q_dezena_40"] |
         ["I", "q_dezena_50"] | ["I", "q_dezena_60"] | ["I", "q_dezena_70"] | ["I", "q_dezena_80"] | 
         ["I", "q_dezena_90"]
        estado = "q_unid_1"; unidade = "1"

      in ["I", "q_unid_1"]
        estado = "q_unid_2"; unidade = "2"

      in ["I", "q_unid_2"]
        estado = "q_unid_3"; unidade = "3"

      in ["V", "q_unid_1"]
        estado = "q_unid_4"; unidade = "4"

      in ["V", "q_milhar_0"] | ["V", "q_milhar_1000"] | ["V", "q_milhar_2000"] | ["V", "q_milhar_3000"] |
         ["V", "q_centena_100"] | ["V", "q_centena_500"] | ["V", "q_dezena_10"] | ["V", "q_dezena_40"] |
         ["V", "q_dezena_50"] | ["V", "q_dezena_90"]
        estado = "q_unid_5"; unidade = "5"

      in ["I", "q_unid_5"]
        estado = "q_unid_6"; unidade = "6"

      in ["I", "q_unid_6"]
        estado = "q_unid_7"; unidade = "7"

      in ["I", "q_unid_7"]
        estado = "q_unid_8"; unidade = "8"

      in ["X", "q_unid_1"]
        estado = "q_unid_9"; unidade = "9"

      # --- ACEITACAO (FIM DA CADEIA) ---
      
     in ["", _]

        puts "\n[FIM DA FITA DE ENTRADA]"

        # 1. Mostramos a saída REAL (pura) do autômato primeiro

        puts "Fita de Saída (Símbolos puros): #{milhar} #{centena} #{dezena} #{unidade}"

        # 2. Mostramos a interpretação opcional logo abaixo

        resultado_opcional = milhar.to_i + centena.to_i + dezena.to_i + unidade.to_i

        puts "Interpretação Decimal (Opcional): #{resultado_opcional}"

        # OBSERVAÇÃO:

        # O uso de .to_i e a soma (+) acima ocorrem apenas como interpretação opcional para uma
        # interpretação decimal mais humana.

        # O autômato (Transdutor) trabalhou exclusivamente com strings (símbolos),
        # sem realizar cálculos aritméticos durante as transições de estado, fazendo 
        # a concatenação para juntar os símbolos.

        # A soma aqui serve apenas para "limpar" os zeros e exibir o resultado formatado.

        '''Por exemplo, se tivermos o milhar = "2000", centena = "300", dezena = "40" e unidade = "9", 
        a soma  resultará em 2349, que é a tradução correta do número romano, se não fosse feita a soma, 
        a exibição seria "2000300409", o que não é desejável e seria confuso para o usuário.'''
        
        break

      else

        puts "\nERRO: Transição inválida para o símbolo '#{simbolo}' no estado #{estado}"

        break
      end

      @indice += 1

      puts "Lendo: #{simbolo} -> Novo Estado: #{estado}"
    end
  end
end

print "Digite o numero romano: "
input = gets.chomp
adf = ADF.new(input)
adf.iniciar