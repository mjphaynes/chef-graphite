
python_pip "twisted"
python_pip "whisper" do
  version '0.9.9'
  action :install
end

python_pip "simplejson" do
  version '3.1.0'
  action :install
end
