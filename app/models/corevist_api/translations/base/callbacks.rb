module CorevistAPI::Translations::Base::Callbacks
  extend ActiveSupport::Concern

  included do
    validates_presence_of :key, :locale, :status, message: N_('msg|%{attribute} required')
    validate :translation_blank?

    before_update :reject_default_changed
    before_destroy :reject_default
    before_save :reject_duplicate
  end

  private

  def reject_duplicate
    duplicate = self.class.where(self.class.arel_table[:id].not_eq(id)).where(upsert_query).first

    if duplicate.present?
      errors.add(:key, _('msg|duplicated_translation'))
      throw :abort
    end
  end

  def translation_blank?
    if df_translation.to_s.empty? && cst_translation.to_s.empty?
      errors.add(:cst_translation, _('msg|blank_translation'))
      throw :abort
    end
  end

  def reject_default_changed
    if df_translation_changed?
      errors.add(:df_translation, _('msg|default_translation_changed'))
      throw :abort
    end
  end

  def reject_default
    unless df_translation.to_s.empty?
      errors.add(:df_translation, _('msg|default_translation_deleting'))
      throw :abort
    end
  end
end
