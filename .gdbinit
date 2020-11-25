source ~/.gdbtools/peda/peda.py
source ~/.gdbtools/Pwngdb/pwngdb.py
source ~/.gdbtools/Pwngdb/angelheap/gdbinit.py

define hook-run
python
import angelheap
angelheap.init_angelheap()
end
end
