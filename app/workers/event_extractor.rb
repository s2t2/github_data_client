class EventExtractor
  def self.perform
    client = Octokit::Client.new(:access_token => ENV["GITHUB_DATA_CLIENT_GITHUB_ACCESS_TOKEN"])

    # Extract my user info.

    octocat = client.user
    pp octocat

    user = User.where(:username => octocat.login, :github_id => octocat.id).first_or_create!
    user.update_attributes!({:user_type => octocat.type, :name => octocat.name})

    # Measure my metrics.

    period_name = Time.zone.now.strftime("%Y-%m-%d")

    public_repo_count = MeasureCount.where(:user_id => user.id, :metric_name => "public_repos", :period_name => period_name).first_or_create!
    public_repo_count.update_attributes!(:measure_value => octocat.public_repos.to_i)

    total_private_repo_count = MeasureCount.where(:user_id => user.id, :metric_name => "total_private_repos", :period_name => period_name).first_or_create!
    total_private_repo_count.update_attributes!(:measure_value => octocat.total_private_repos.to_i)

    owned_private_repo_count = MeasureCount.where(:user_id => user.id, :metric_name => "owned_private_repos", :period_name => period_name).first_or_create!
    owned_private_repo_count.update_attributes!(:measure_value => octocat.owned_private_repos.to_i)

    public_gist_count = MeasureCount.where(:user_id => user.id, :metric_name => "public_gists", :period_name => period_name).first_or_create!
    public_gist_count.update_attributes!(:measure_value => octocat.public_gists.to_i)

    private_gist_count = MeasureCount.where(:user_id => user.id, :metric_name => "private_gists", :period_name => period_name).first_or_create!
    private_gist_count.update_attributes!(:measure_value => octocat.private_gists.to_i)

    follower_count = MeasureCount.where(:user_id => user.id, :metric_name => "followers", :period_name => period_name).first_or_create!
    follower_count.update_attributes!(:measure_value => octocat.followers.to_i)

    following_count = MeasureCount.where(:user_id => user.id, :metric_name => "following", :period_name => period_name).first_or_create!
    following_count.update_attributes!(:measure_value => octocat.following.to_i)

    disk_usage_count = MeasureCount.where(:user_id => user.id, :metric_name => "disk_usage", :period_name => period_name).first_or_create!
    disk_usage_count.update_attributes!(:measure_value => octocat.disk_usage.to_i)

    disk_space_count = MeasureCount.where(:user_id => user.id, :metric_name => "disk_space", :period_name => period_name).first_or_create!
    disk_space_count.update_attributes!(:measure_value => octocat.plan.space.to_i)

    #disk_utilization_rate = MeasureRate.where(:user_id => user.id, :metric_name => "disk_utilization", :period_name => period_name)
    #disk_utilization_rate.update_attributes!(:measure_value => octocat.disk_usage.to_f / octocat.plan.space.to_f)

    # Log my events.

    user_events = client.user_events(octocat.login)
    user_events.each do |user_event|
      event = Event.where(:github_id => user_event.id).first_or_create!
      event.update_attributes!({
        :event_type => user_event.type,
        :repo_id => user_event.try(:repo).try(:id),
        :org_id => user_event.try(:org).try(:id),
        :public => user_event[:public],
        :event_at => user_event.created_at
      })
    end

    puts "fun times"
  end
end
