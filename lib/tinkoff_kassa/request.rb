# frozen_string_literal: true

module TinkoffKassa
  class Request
    BASE_URL = 'https://securepay.tinkoff.ru/v2/'

    def initialize(path, params = {})
      @url     = BASE_URL + path
      @params  = params
      @headers = { 'Content-Type' => 'application/json' }
    end

    def perform
      prepare_params

      response = HTTParty.post(@url, body: @params.to_json, headers: @headers).parsed_response
      TinkoffKassa::Payment.new(response)
    end

    private

    def prepare_params
      # Add terminal key and password
      @params.merge!(default_params)

      # Sort params by key
      @params = @params.sort.to_h

      # Add token (signature)
      @params[:Token] = token
    end

    # Подпись запроса
    # https://www.tinkoff.ru/kassa/dev/payments/#section/Podpis-zaprosa
    def token
      values = @params.except(:DATA, :Receipt).values.join

      Digest::SHA256.hexdigest(values)
    end

    def default_params
      { TerminalKey: TinkoffKassa.config.terminal_key, Password: TinkoffKassa.config.password }
    end
  end
end
