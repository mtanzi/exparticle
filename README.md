# ExParticle

### ExParticle is a client to use the [Particle Cloud API](https://docs.particle.io/reference/api/) api

[![Build Status](https://travis-ci.org/mtanzi/exparticle.svg?branch=master)](https://travis-ci.org/mtanzi/exparticle) [![Coverage Status](https://coveralls.io/repos/mtanzi/exparticle/badge.svg?branch=master&service=github)](https://coveralls.io/github/mtanzi/exparticle?branch=master) [![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)

## Usage

### Installation

Add the following to your `mix.exs`

````
...

def application do
  [mod: {ExParticlePhoenixExample, []},
   applications: [:exparticle]]
end

...

defp deps do
  [{:exparticle, "~> 0.0.1"}]

...

````

### Configuration

ExParticle will look for application variables, we need to create the configuration file for each environment where to store the `access_token`.

`config/dev.exs`
````
use Mix.Config

config :exparticle, :api,
  access_token: "particle_access_token"
````
