class WalletsController < ApplicationController
  before_action :authenticate_user!

  def connect
    wallet = current_user.wallet || current_user.build_wallet
    wallet.update(address: params[:address])
    render json: { status: "ok" }
  end

  def claim_reward
    wallet = current_user.wallet
    return render json: { status: "error", message: "Wallet not connected" } unless wallet&.address

    if wallet.last_claim_at && wallet.last_claim_at > 1.day.ago
      return render json: { status: "error", message: "You already claimed today!" }
    end

    wallet.update(last_claim_at: Time.current)
    render json: { status: "ok", message: "Reward claim recorded. Now sign the transaction in MetaMask!" }
  end
end
