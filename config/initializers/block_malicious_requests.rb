# frozen_string_literal: true

require_relative "../../app/middleware/block_malicious_requests"

Rails.application.config.middleware.insert_before(0, BlockMaliciousRequests)
