git clone --recurse-submodules --branch v0.1-preview --depth 1 https://github.com/Yukkurisiteikitai/Y_sys.git
cd Y-sys-backend
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
cd ..
cd Y-sys-frontend
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
cd ..
