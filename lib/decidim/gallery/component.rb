# frozen_string_literal: true

require "decidim/components/namer"

Decidim.register_component(:gallery) do |component|
  component.engine = Decidim::Gallery::Engine
  component.admin_engine = Decidim::Gallery::AdminEngine
  component.icon = "decidim/gallery/icon.svg"
  component.permissions_class_name = "Decidim::Gallery::Permissions"

  component.on(:before_destroy) do |instance|
    raise StandardError, "Can't remove this component" if Decidim::Gallery::GalleryItem.where(component: instance).any?
  end

  # component.on(:update) do |instance|
  # end

  # These actions permissions can be configured in the admin panel
  # component.actions = %w(create)
  # component.actions = %w(endorse vote create withdraw amend comment)

  component.settings(:global) do |settings|
    settings.attribute :announcement, type: :text, translated: true, editor: true
    settings.attribute :show_announcement, type: :boolean, default: true
    settings.attribute :gallery_type, type: :enum, default: "image", choices: %w(image video)
    settings.attribute :items_per_page, type: :enum, default: "12", choices: %w(12 15 18)
    settings.attribute :additional_css, type: :string, default: "medium-up-2 large-up-2"
    settings.attribute :show_title, type: :boolean, default: true
  end

  # component.settings(:step) do |settings|
  # end

  # component.register_resource(:some_resource) do |resource|
  #   # Register a optional resource that can be references from other resources.
  #   resource.model_class_name = "Decidim::Gallery::SomeResource"
  #   resource.template = "decidim/gallery/some_resources/linked_some_resources"
  # end

  # component.register_stat :some_stat do |context, start_at, end_at|
  #   # Register some stat number to the application
  # end

  # component.seeds do |participatory_space|
  #   # Add some seeds for this component
  # end
end
