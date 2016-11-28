class Advice < Sequel::Model
  ADVICES = [
    "The number of users accessing to the academic digital library is low and there are few access points in the academic digital library. Furthermore, the digital collection is poor.
    Maybe it causes the low number of users. It is advised to increase and to improve the digital collection.",
    "The number of users accessing to the academic digital library is low and there are few access points in the academic digital library, although the digital collection is appropriate.
    It is advised to increase the number of access points. In addition, it would be recommendable to give grants to the users for buying computers.",
    "There exist few accesses to the academic digital library, although the number of access points and the digital collection are
    appropriate. It is advised to train better to the users and to improve the query tools.",
    "There exist few access points in the academic digital library. It is advised to increase the number of access points to query on the
    academic digital library and to give grants to the users for buying computers.",
    "Although the academic digital library has a good number of accesses and queries, the digital collection is poor.
    It is advised to increase and to improve the digital collection.",
    "It seems that users do not find out what they are looking for. Maybe it is due to that the digital collection is poor. It is advised to
    increase and to improve the digital collection.",
    "It seems that users do not find out what they are looking for. However, the digital collection is appropriate.
    It is advised to invest in training of users and to provide better query tools.",
    "Users think that the coverage of the academic digital library about search topics is poor. It is advised to increase the digital
    collection and to improve the mechanisms of information diffusion (mailing lists, news pages, etc.).",
    "Users are not well informed about new inputs in the academic digital library. It is advised to improve the mechanisms of infor- mation diffusion (mailing lists, news pages, etc.).",
    "Users think that the variety of search tools is not appropriate. It is advised to improve both the current search tools and the
    training of users.",
    "Users think that the navigability/understandability of the academic digital library Website is poor. It is advised to improve the Website design and to use more Web standards.",
    "Users think that the academic digital library should provide more added value information profits. It is advised to provide more
    added value information profits, as for example: completing the search results with links to other search engines and providing
    access to other Websites.",
    "Users think that the computing infrastructure of the academic digital library is not appropriate. It is advised to improve the computing infrastructure and to increase the number of access points.",
    "Users think that the response time of the academic digital library is not appropriate. It is advised to improve the system design and to invest in servers more powerful.",
    "Users do not receive training in the use of the academic digital library. It is advised to invest in the training of users."
  ]
  class << self
    def initiate_data
      ADVICES.each do |a|
        Advice.create(content: a)
      end
    end
  end
end
