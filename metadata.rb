name             "graphite"
maintainer       "Michael Haynes @mjphaynes"
original_author  "Heavy Water Software Inc."
license          "Apache 2.0"
description      "Installs and configures Graphite"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1"
recipe           "graphite", "Installs and configures Graphite and all of its components"

supports         "amazon"

depends          "python"
depends          "apache2"
