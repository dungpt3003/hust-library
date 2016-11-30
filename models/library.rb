class Library < Sequel::Model
  one_to_many :surveys
  P_ACCESS_ARR = Library.map { |lib| lib.p_access}
  P_ACCESS_POINT_ARR = Library.map { |lib| lib.p_access_point}
  P_QUERY_ARR = Library.map { |lib| lib.p_query}
  P_MEGABYTE_ARR = Library.map { |lib| lib.p_megabyte}

  class << self
    def mean_score
      {
        :p_access => P_ACCESS_ARR.mean,
        :p_acess_point => P_ACCESS_POINT_ARR.mean,
        :p_query => P_QUERY_ARR.mean,
        :p_megabyte => P_MEGABYTE_ARR.mean
      }
    end

    def standard_deviation
      {
        :p_access => P_ACCESS_ARR.standard_deviation,
        :p_acess_point => P_ACCESS_POINT_ARR.standard_deviation,
        :p_query => P_QUERY_ARR.standard_deviation,
        :p_megabyte => P_MEGABYTE_ARR.standard_deviation
      }
    end
  end
end
