RSpec.describe SidekiqAlerts do
  it "has a version number" do
    expect(SidekiqAlerts::VERSION).not_to be nil
  end

  describe "#check_latency" do
    QueueTest = Struct.new(:name, :latency)

    it "returns true in case there is a queue with latency that surpass threshold" do
      queues_test = [
        QueueTest.new("queue1", 5),
        QueueTest.new("queue2", 805), # this goes over the default threshold of 800
      ]
      allow(SidekiqAlerts).to receive(:get_queues_to_check).and_return(queues_test)

      result = SidekiqAlerts.check_latency
      expect(result).to eq(true)
    end

    it "returns false in case there is not a queue with latency that surpass threshold" do
      queues_test = [
        QueueTest.new("queue1", 5),
        QueueTest.new("queue2", 799), # this goes under the default threshold of 800
      ]
      allow(SidekiqAlerts).to receive(:get_queues_to_check).and_return(queues_test)

      result = SidekiqAlerts.check_latency
      expect(result).to eq(false)
    end
  end
end
