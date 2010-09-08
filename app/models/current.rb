class Current < ActiveRecord::Base
  
  acts_as_authorizable
  
  unless !Current.table_exists? 
    acts_as_tsearch :fields => %w(title description)
  end
  
  belongs_to :inventor, :class_name => 'User'
  has_many :ideas, :order => 'ideas.created_at' do
    def visible
      r = find :all, :conditions => { :hidden => false }
    end
  end
  validates_presence_of :title, :description
  
  DEFAULT_CURRENT_ID = 1
  
  def closed_or_expired?
    if closed? || expired?
      self.closed = true
    else
      return false
    end
  end
  
  def expired?
    !submission_deadline.nil? && submission_deadline < Date.today
  end
  
  def self.populate_idea_counts(currents)
    idea_counts = Idea.find :all,
      :select => 'count(*) as idea_count, current_id',
      :conditions => ['current_id in (?) and hidden = ?', currents.map{ |i| i.id }, false],
      :group => 'current_id'
    counts_by_id = Hash.new(0)
    idea_counts.each do |c|
      counts_by_id[c.current_id] = c.idea_count.to_i
    end
    currents.each do |current|
      current.idea_count = counts_by_id[current.id]
    end
  end
  
  attr_writer :idea_count
  
  def idea_count
    @idea_count ||= (attributes[:idea_count] || ideas.visible.size)
  end
  
end
