class Api::TicketsController < ApplicationController
  def create
    permitted = params.permit(:user_id, :title, tags: [])
    user_id = permitted[:user_id]
    title = permitted[:title]
    tags = permitted[:tags] || []
    errors = []

    errors << 'user_id is required' unless user_id.present?
    errors << 'title is required' unless title.present?
    if tags.length > 4
      errors << 'tags must be fewer than 5'
    end

    if errors.any?
      return render json: { errors: errors }, status: :unprocessable_entity
    end

    ticket = Ticket.create!(
      user_id: user_id,
      title: title,
      received_at: Time.current
    )

    tags.map(&:downcase).each do |tag_name|
      tag = Tag.find_or_initialize_by(name: tag_name)
      tag.count ||= 0
      tag.count += 1
      tag.save!
    end

    most_common_tag = Tag.order(count: :desc).first

    if most_common_tag
      WebhookNotifier.call(most_common_tag.name)
    end

    render json: { message: 'Ticket created successfully' }, status: :created
  end
end
