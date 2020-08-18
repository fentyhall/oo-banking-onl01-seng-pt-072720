# Transfer class acts as a space for a transaction between two 
# instances of the bank account class, as well as check the 
# validity of the accounts before the transaction occurs.
# Transfer instance should be able to reject a transfer if the
# accounts aren't valid or if the sender doesn't have the money.

class Transfer
  attr_accessor :status
  attr_reader :sender, :receiver, :amount
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver 
    @amount = amount
    @status = "pending"
  end 
    
  def valid?
    sender.valid?
    receiver.valid?
  end 

  def execute_transaction 
    if valid? && sender.balance > self.amount && @status == "pending"
      sender.balance -= self.amount 
      receiver.balance += self.amount 
      self.status = "complete"
    else 
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end 
  end 

  def reverse_transfer 
    execute_transaction
    sender.balance += self.amount 
    receiver.balance -= self.amount 
    self.status = "reversed"
  end 
end