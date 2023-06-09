# frozen_string_literal: true

shared_examples_for "gallery accessible page" do |_options|
  it "passes accessibility tests" do
    expect(page).to be_axe_clean.excluding(
      'a[title="Find out more about cookies"]',
      "iframe.video-iframe"
    )
  end

  it "passes HTML validation" do
    # Capybara is stripping the doctype out of the HTML which is required for
    # the validation. If it doesn't exist, add it there.
    html = page.source
    html = "<!DOCTYPE html>\n#{html}" unless html.strip.match?(/^<!DOCTYPE/i)

    expect(html).to be_valid_html
  end
end
