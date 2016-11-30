class Library < Sequel::Model
  one_to_many :surveys
  P_ACCESS_ARR = Library.map { |lib| lib.p_access}
  P_ACCESS_POINT_ARR = Library.map { |lib| lib.p_access_point}
  P_QUERY_ARR = Library.map { |lib| lib.p_query}
  P_MEGABYTE_ARR = Library.map { |lib| lib.p_megabyte}

  OBJECTIVE_CRITERIA = {
    1 => :p_access,
    2 => :p_access_point,
    3 => :p_query,
    4 => :p_megabyte
  }

  GROUPS = {
    :much_worse => -2,
    :worse => -1,
    :better => 1,
    :much_better => 2
  }

  class << self
    def mean_score
      {
        :p_access => P_ACCESS_ARR.mean,
        :p_access_point => P_ACCESS_POINT_ARR.mean,
        :p_query => P_QUERY_ARR.mean,
        :p_megabyte => P_MEGABYTE_ARR.mean
      }
    end

    def standard_deviation
      {
        :p_access => P_ACCESS_ARR.standard_deviation,
        :p_access_point => P_ACCESS_POINT_ARR.standard_deviation,
        :p_query => P_QUERY_ARR.standard_deviation,
        :p_megabyte => P_MEGABYTE_ARR.standard_deviation
      }
    end
  end

  def group_of oc_index
    criteria = send(OBJECTIVE_CRITERIA[oc_index])
    mean = Library.mean_score[OBJECTIVE_CRITERIA[oc_index]]
    sd = Library.standard_deviation[OBJECTIVE_CRITERIA[oc_index]]
    if criteria < mean - sd
      return GROUPS[:much_worse]
    elsif criteria < mean
      return GROUPS[:worse]
    elsif criteria < mean + sd
      return GROUPS[:better]
    else
      return GROUPS[:much_better]
    end
  end

  def group_of_two oc1, oc2
    (group_of(oc1) + group_of(oc2)) / 2.0
  end
end
