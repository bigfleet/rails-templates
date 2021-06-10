def yarn(*packages)
  run("yarn add #{packages.join(" ")}")
end

yarn 'bootstrap@5.0.1'

# inject_into_file 'config/webpack/environment.js', after: "const { environment } = require('@rails/webpacker')\n" do <<~EOF
#   const webpack = require('webpack')
#   environment.plugins.append('Provide', new webpack.ProvidePlugin({
#     $: 'jquery',
#     jQuery: 'jquery',
#     'window.jQuery': 'jquery',
#     Popper: ['popper.js', 'default']
#   }))
#   EOF
# end

inject_into_file 'app/views/layouts/application.html.erb', before: '</head>' do <<~EOF
  <%= stylesheet_pack_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
  EOF
end
  
inject_into_file 'app/javascript/packs/application.js' do <<~EOF
import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap'
  EOF
end
