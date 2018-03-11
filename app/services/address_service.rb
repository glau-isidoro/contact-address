class AddressService
  attr_reader :cep, :number, :complement
    
  def initialize(options = {})
    @cep = validate_cep(options[:cep])
    @number = options[:number]
    @complement = options[:complement]
  end
    
  def full_address
    begin
      address_cli = RestClient::Request.execute(
        method: :get,
        url: "http://viacep.com.br/ws/#{cep}/json/"
        )
      address_hash(JSON.parse(address_cli))
    rescue
      raise 'CEP Invalid'
    end
  end
  
  private
  
  def address_hash(address)
    { cep: address['cep'], street: address['logradouro'],
    city: address['localidade'], state: address['uf'],
    neighborhood: address['bairro'], number: number, complement: complement}
  end
  
  def validate_cep(cep)
    clean_cep = cep.gsub(/\D/, '')
    return clean_cep if clean_cep.length == 8
    raise 'CEP Invalid'
  end
end
        