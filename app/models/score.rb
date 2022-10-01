class Score < ApplicationRecord
    after_create_commit -> {
        broadcast_prepend_to "scores", # Broadcast to users subscribed to scores
        partial: "scores/score",
        locals: { score: self },
        target: "scores"
    }
    after_update_commit -> { broadcast_replace_to "scores" }

  after_destroy_commit -> { broadcast_remove_to "scores" }
end
