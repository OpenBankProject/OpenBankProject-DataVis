class Obp_transactions
  def initialize()
      file_handle = open("https://demo.openbankproject.com/api/accounts/tesobe/anonymous")
      transactions = ActiveSupport::JSON.decode(file_handle)
  end

  def getTransactions()
          @holder = transactions["obp_transaction"]["this_account"]["holder"]["holder"]
          this_account.holdername = transactions["obp_transaction"]["this_account"]["holder"]["holder"]
          other_account.holdername = transactions["obp_transaction"]["other_account"]["holder"]["holder"]
        
          details.date_posted = transactions["obp_transaction"]["details"]["posted"]
          details.date_completed = transactions["obp_transaction"]["details"]["completed"]
          details.value.currency = transactions["obp_transaction"]["details"]["value"]["currency"]
          details.value.amount = transactions["obp_transaction"]["details"]["value"]["amount"]
          obp_comments = transactions["obp_transaction"]["value"]
  end
end
