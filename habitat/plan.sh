pkg_name=voteforit
pkg_origin=fnichol
pkg_version=0.1.0
pkg_description="A simple voting app done in sinatra"
pkg_upstream_url=https://github.com/jjasghar/simple-voting-app
pkg_maintainer="Fletcher Nichol <fnichol@chef.io>"
pkg_license=('Apache-2')
pkg_source=false
pkg_deps=(
  core/coreutils
  core/ruby
  core/openssl
  core/gcc-libs
  core/busybox-static
)
pkg_build_deps=(
  core/bundler
  core/cacerts
  core/coreutils
  core/git
)
pkg_bin_dirs=(bin)
pkg_svc_run="voteforit -o 0.0.0.0 --config $pkg_svc_config_path/config.yml"
pkg_expose=(4567)

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_build() {
  return 0
}

do_install () {
  # Create a Gemfile with what we need
  export BUNDLE_SILENCE_ROOT_WARNING=1 GEM_PATH
  GEM_PATH="$(pkg_path_for core/bundler)"
  cat > Gemfile <<GEMFILE
source 'https://rubygems.org'
gem 'voteforit', git: '$PLAN_CONTEXT/../'
GEMFILE
  bundle install --jobs "$(nproc)" --retry 5 \
    --path "$pkg_prefix/bundle" \
    --shebang=$(pkg_path_for ruby)/bin/ruby \
    --binstubs=$pkg_prefix/bin \
    --standalone
  pkg_lib_dirs+=$(find $pkg_prefix/bundle | grep '**/lib' | grep '\.so' | xargs dirname | sort -u)

  fix_interpreter "$pkg_prefix/bin/*" core/busybox-static bin/env
}
