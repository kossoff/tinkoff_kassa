# frozen_string_literal: true

module TinkoffKassa
  class Client
    # Инициирует платежную сессию и регистрирует заказ в системе Банка
    def self.init(amount, order_id, data, params = {})
      params = params.merge(Amount: amount, OrderId: order_id, DATA: data)
      TinkoffKassa::Request.new('Init', params).perform
    end

    # Подтверждает платеж и осуществляет списание заблокированных ранее денежных средств
    def self.confirm(payment_id, params = {})
      params = params.merge(PaymentId: payment_id)
      TinkoffKassa::Request.new('Confirm', params).perform
    end

    # Осуществляет рекуррентный (повторный) платеж — безакцептное списание денежных средств
    # со счета банковской карты Покупателя
    def self.charge(payment_id, rebill_id, params = {})
      params = params.merge(PaymentId: payment_id, RebillId: rebill_id)
      TinkoffKassa::Request.new('Charge', params).perform
    end

    # Отменяет платежную сессию
    def self.cancel(payment_id, params = {})
      params = params.merge(PaymentId: payment_id)
      TinkoffKassa::Request.new('Cancel', params).perform
    end

    # Возвращает текуший статус платежа
    def self.state(payment_id, params = {})
      params = params.merge(PaymentId: payment_id)
      TinkoffKassa::Request.new('GetState', params).perform
    end
  end
end
