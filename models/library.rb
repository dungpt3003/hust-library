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

  SUBJECTIVE_CRITERIA = {
    1 => "You find what you are looking for",
    2 => "Coverage about search topics",
    3 => "Information electronic services about new inputs",
    4 => "Variety of search tools",
    5 => "Navigability of the Website",
    6 => "Understandability of the Website",
    7 => "Added value information profits",
    8 => "Satisfaction degree with the computing infrastructure",
    9 => "Satisfaction degree with the response time",
    10 => "Training received"
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

  def generate_advices
    advices = []
    # Rule 1: If G(oc13) < 0, and G(oc2) < 0, and G(oc4) < 0, then the following recommendation is generated:
    if group_of_two(1, 3) < 0 and group_of(2) < 0 and group_of(4) < 0
      advices << Advice[1].content
    end

    # Rule 2: If G(oc13) < 0, and G(oc2) < 0, and G(oc4) > 0, then the following recommendation is generated:
    if group_of_two(1, 3) < 0 and group_of(2) < 0 and group_of(4) > 0
      advices << Advice[2].content
    end

    # Rule 3: If G(oc13) < 0, and G(oc2) > 0, and G(oc4) > 0, then the following recommendation is generated:
    if group_of_two(1, 3) < 0 and group_of(2) > 0 and group_of(4) > 0
      advices << Advice[3].content
    end

    # Rule 4:  If G(oc13) > 0, and G(oc4) > 0, and G(oc2) < 0, then the following recommendation is generated:
    if group_of_two(1, 3) > 0 and group_of(4) > 0 and group_of(2) < 0
      advices << Advice[4].content
    end

    # Rule 5: If G(oc13) > 0, and G(oc2) > 0, and G(oc4) < 0, then the following recommendation is generated:
    if group_of_two(1, 3) > 0 and group_of(2) > 0 and group_of(4) < 0
      advices << Advice[5].content
    end

    return advices
  end
end
