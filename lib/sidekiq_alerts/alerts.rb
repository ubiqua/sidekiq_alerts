module SidekiqAlerts
  class Error < StandardError; end

  MAX_LATENCY = ENV['SIDEKIQ_LATENCY_THRESHOLD'] || 800
  MAX_RETRY_COUNT = ENV['SIDEKIQ_RETRY_COUNT_THRESHOLD'] || 10
  QUEUES = ENV['SIDEKIQ_QUEUES_MONITOR'] || 'default'
  APP_NAME = ENV['APP_NAME'] || ENV['HEROKU_APP_NAME'] || 'APP_NAME'

  def self.check_latency
    # Get the list of queue names to check
    queue_names = QUEUES.split(',').map { |name| name.strip! }
    # Find the queues we are looking for
    queues = Sidekiq::Queue.all.select { |queue| queue_names.include? queue.name }

    queues.each do |queue|
      # Check if the latency exceeds the threshold
      latency = queue.latency
      if latency > MAX_LATENCY.to_i
        report_latency(queue)
      end
    end
  end

  def self.check_retries
    retry_set = Sidekiq::RetrySet.new
    if retry_set.count > MAX_RETRY_COUNT.to_i
      report_retry_queue(retry_set.count)
    end
  end

  def self.report_latency(queue)
    # Send the sentry report
    message = "[SidekiqLatency][#{APP_NAME}] - "
    message += "Latency for queue #{queue.name} exceeded #{MAX_LATENCY} with #{queue.latency}"
    puts message
    Raven.capture_message(message, tags: { type: 'sidekiq' })
  end

  def self.report_retry_queue(current_count)
    # Send the sentry report
    message = "[SidekiqLatency][#{APP_NAME}] - "
    message += "Retry count of #{current_count} exceeded maximun threshold of #{MAX_RETRY_COUNT}"
    puts message
    Raven.capture_message(message, tags: { type: 'sidekiq' })
  end
end