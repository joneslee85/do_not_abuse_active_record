class ClaimTemplate
  def initialize(client, code)
    @client = client
    @code   = code
  end

  def attributes
    find_template_by_code(@code).new(@client).attributes.merge(client: @client)
  end

  private

  def find_template_by_code(code)
    "ClaimTemplates::#{code}".constantize
  end
end