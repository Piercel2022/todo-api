class Task < ApplicationRecord
    belongs_to :user  # Si une tâche appartient à un utilisateur
  
    validates :title, presence: true, length: { maximum: 255 }
    validates :description, presence: true
    validates :category, presence: true
    validates :priority, presence: true, inclusion: { in: [1, 2, 3, 4, 5], message: "doit être un nombre entre 1 et 5" }
    validates :due_date, presence: true
    validates :completed, inclusion: { in: [true, false] }
  
    # Méthodes pour marquer comme complété
    def mark_as_completed
      update(completed: true)
    end
  
    # Scopes pour les filtres de tâches
    scope :completed, -> { where(completed: true) }
    scope :pending, -> { where(completed: false) }
    scope :due_soon, -> { where("due_date <= ?", Time.now + 1.day) }
  end
  
