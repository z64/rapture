# frozen_string_literal: true

# Binding to Discord's HTTPS REST API
module Rapture::REST
  include Rapture::HTTP

  # Gets the current working gateway URL
  # https://discordapp.com/developers/docs/topics/gateway#get-gateway
  # @return [GatewayInfo]
  def get_gateway
    response = request(:get, "gateway")
    Rapture::GatewayInfo.from_json(response.body)
  end

  # Gets the current working gateway URL, with additional sharding
  # recommendation
  # https://discordapp.com/developers/docs/topics/gateway#get-gateway-bot
  # @return [GatewayInfo]
  def get_gateway_bot
    response = request(:get, "gateway/bot")
    Rapture::GatewayInfo.from_json(response.body)
  end

  # Returns a {User} object for a given user ID.
  # https://discordapp.com/developers/docs/resources/user#get-user
  # @return [User]
  def get_user(id)
    response = request(:get, "users/#{id}")
    Rapture::User.from_json(response.body)
  end

  # Returns the {User} associated with the current authorization token.
  # https://discordapp.com/developers/docs/resources/user#get-current-user
  # @return [User]
  def get_current_user
    get_user("@me")
  end

  # Returns a {Channel{ object for a given channel ID
  # https://discordapp.com/developers/docs/resources/channel#get-channel
  # @return [Channel]
  def get_channel(id)
    response = request(:get, "channels/#{id}")
    Rapture::Channel.from_json(response.body)
  end

  # Creates a message in a channel.
  # https://discordapp.com/developers/docs/resources/channel#create-message
  # @return [Message] the created message
  def create_message(channel_id, content: nil, embed: nil, tts: false)
    response = request(
      :post,
      "channels/#{channel_id}/messages",
      content: content, embed: embed, tts: tts,
    )
    Rapture::Message.from_json(response.body)
  end

  # Edits a message in a channel.
  # https://discordapp.com/developers/docs/resources/channel#edit-message
  # @return [Message] the edited message
  def edit_message(channel_id, message_id, content: nil, embed: nil)
    response = request(
      :patch,
      "channels/#{channel_id}/messages/#{message_id}",
      content: content, embed: embed,
    )
    Rapture::Message.from_json(response.body)
  end

  # Deletes a message in a channel.
  # https://discordapp.com/developers/docs/resources/channel#delete-message
  def delete_message(channel_id, message_id)
    request(:delete, "channels/#{channel_id}/messages/#{message_id}")
  end
end
