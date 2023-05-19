VENV = .venv
VENV_BIN = $(VENV)/bin

.PHONY: setup clean update-lock lock check test

setup: $(VENV)

$(VENV):
	mamba create -p .venv python==3.10.10 --yes
	$(VENV_BIN)/python -m pip install --upgrade pip
	$(VENV_BIN)/python -m pip install pip-tools -r requirements.in

clean:
	rm -rf $(VENV)

lock:
	$(VENV_BIN)/python -m piptools compile --resolver=backtracking -o requirements.txt requirements.in

update-lock: lock clean setup

upgrade:
	$(VENV_BIN)/python -m piptools compile --resolver=backtracking --upgrade -o requirements.txt requirements.in

upgrade-lock: upgrade clean setup