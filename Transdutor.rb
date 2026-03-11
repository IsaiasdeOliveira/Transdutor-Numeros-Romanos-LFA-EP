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
    milhar = 0; centena = 0; dezena = 0; unidade = 0
  
    puts "Máquina iniciou no estado: " + estado
  
    loop do
      simbolo = proximo
  
      case [simbolo, estado]

      # MILHARES (M)
      in ["M", "q_milhar_0"]
        estado = "q_milhar_1000"; milhar = 1000

      in ["M", "q_milhar_1000"]
        estado = "q_milhar_2000"; milhar = 2000

      in ["M", "q_milhar_2000"]
        estado = "q_milhar_3000"; milhar = 3000

      # CENTENAS (C, D, M)
      in ["C", "q_centena_0"] | ["C", "q_milhar_0"]
        estado = "q_centena_100"; centena = 100

      in ["C", "q_centena_100"]
        estado = "q_centena_200"; centena = 200

      in ["C", "q_centena_200"]
        estado = "q_centena_300"; centena = 300

      in ["D", "q_centena_100"]
        estado = "q_centena_400"; centena = 400

      in ["D", "q_centena_0"] | ["D", "q_milhar_0"]
        estado = "q_centena_500"; centena = 500

      in ["C", "q_centena_500"]
        estado = "q_centena_600"; centena = 600

      in ["C", "q_centena_600"]
        estado = "q_centena_700"; centena = 700

      in ["C", "q_centena_700"]
        estado = "q_centena_800"; centena = 800

      in ["M", "q_centena_100"]
        estado = "q_centena_900"; centena = 900

      # DEZENAS (X, L, C)
      in ["X", "q_dezena_0"] | ["X", "q_milhar_0"]
        estado = "q_dezena_10"; dezena = 10

      in ["X", "q_dezena_10"]
        estado = "q_dezena_20"; dezena = 20

      in ["X", "q_dezena_20"]
        estado = "q_dezena_30"; dezena = 30

      in ["L", "q_dezena_10"]
        estado = "q_dezena_40"; dezena = 40

      in ["L", "q_dezena_0"]
        estado = "q_dezena_50"; dezena = 50

      in ["X", "q_dezena_50"] | ["L", "q_milhar_0"]
        estado = "q_dezena_60"; dezena = 60

      in ["X", "q_dezena_60"]
        estado = "q_dezena_70"; dezena = 70

      in ["X", "q_dezena_70"]
        estado = "q_dezena_80"; dezena = 80

      in ["C", "q_dezena_10"]
        estado = "q_dezena_90"; dezena = 90

      # UNIDADES (I, V, X)
      
      in ["I", "q_unid_0"] | ["I", "q_milhar_0"]
        estado = "q_unid_1"; unidade = 1

      in ["I", "q_unid_1"]
        estado = "q_unid_2"; unidade = 2

      in ["I", "q_unid_2"]
        estado = "q_unid_3"; unidade = 3

      in ["V", "q_unid_1"]
        estado = "q_unid_4"; unidade = 4

      in ["V", "q_unid_0"] | ["V", "q_milhar_0"]
        estado = "q_unid_5"; unidade = 5

      in ["I", "q_unid_5"]
        estado = "q_unid_6"; unidade = 6

      in ["I", "q_unid_6"]
        estado = "q_unid_7"; unidade = 7

      in ["I", "q_unid_7"]
        estado = "q_unid_8"; unidade = 8

      in ["X", "q_unid_1"]
        estado = "q_unid_9"; unidade = 9
      
      # Conectando Milhar para Centena
      in ["C", "q_milhar_1000"] | ["C", "q_milhar_2000"] | ["C", "q_milhar_3000"]
        estado = "q_centena_100"; centena = 100

      in ["D", "q_milhar_1000"] | ["D", "q_milhar_2000"] | ["D", "q_milhar_3000"]
        estado = "q_centena_500"; centena = 500

      # Conectando Centena para Dezena
      in ["X", "q_centena_100"] | ["X", "q_centena_200"] | ["X", "q_centena_300"] | ["X", "q_centena_400"] |["X", "q_centena_500"] |
         ["X", "q_centena_600"] | ["X", "q_centena_700"] | ["X", "q_centena_800"] | ["X", "q_centena_900"]
        estado = "q_dezena_10"; dezena = 10

      in ["L", "q_centena_100"] | ["L", "q_centena_200"] | ["L", "q_centena_300"] | ["L", "q_centena_400"] |["L", "q_centena_500"] |
         ["L", "q_centena_600"] | ["L", "q_centena_700"] | ["L", "q_centena_800"] | ["L", "q_centena_900"]
        estado = "q_dezena_50"; dezena = 50

      # Conectando Dezena para Unidade
      in ["I", "q_dezena_10"] | ["I", "q_dezena_20"] | ["I", "q_dezena_30"] | ["I", "q_dezena_40"] |["I", "q_dezena_50"] |
         ["I", "q_dezena_60"] | ["I", "q_dezena_70"] | ["I", "q_dezena_80"] | ["I", "q_dezena_90"]
        estado = "q_unid_1"; unidade = 1

      in ["V", "q_dezena_10"] | ["V", "q_dezena_20"] | ["V", "q_dezena_30"] | ["V", "q_dezena_40"] |["V", "q_dezena_50"] |
         ["V", "q_dezena_60"] | ["V", "q_dezena_70"] | ["V", "q_dezena_80"] | ["V", "q_dezena_90"]
        estado = "q_unid_5"; unidade = 5

      #ESTADOS DE ACEITAÇÃO 
      in ["", "q_unid_1"] | ["", "q_unid_2"] | ["", "q_unid_3"] | ["", "q_unid_4"] | ["", "q_unid_5"] | ["", "q_unid_6"] |
         ["", "q_unid_7"] | ["", "q_unid_8"] | ["", "q_unid_9"] | ["", "q_dezena_10"] | ["", "q_dezena_20"] | ["", "q_dezena_30"] |
         ["", "q_dezena_40"] | ["", "q_dezena_50"] | ["", "q_dezena_60"] | ["", "q_dezena_70"] | ["", "q_dezena_80"] | ["", "q_dezena_90"] |
         ["", "q_centena_100"] | ["", "q_centena_200"] | ["", "q_centena_300"] | ["", "q_centena_400"] | ["", "q_centena_500"] |
         ["", "q_centena_600"] | ["", "q_centena_700"] | ["", "q_centena_800"] | ["", "q_centena_900"] | ["", "q_milhar_1000"] |
         ["", "q_milhar_2000"] | ["", "q_milhar_3000"]
        
        total = milhar + centena + dezena + unidade
        puts "Aceito 😀! Resultado: #{total}"
        break

      else
        puts "Erro, número romano inválido 😞"
        break
      end

      @indice += 1
      puts "Estado atual: #{estado}"
    end
  end
end

# Execução
print "Digite o número romano: "
input = gets.chomp
adf = ADF.new(input)
adf.iniciar