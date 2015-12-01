describe BlackCompany::Pool do
  it "has default pool size" do
    expect(described_class::DEFAULT_POOL_SIZE).not_to be nil
  end
end
