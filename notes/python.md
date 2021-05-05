# Dynamic module import

```python
import importlib

foo = importlib.import_module("src.foo")
```


# Using cProfile

```python
import cProfile, pstats

pr = cProfile.Profile()
pr.enable()

# ... code here ...

pr.create_stats()
ps = pstats.Stats(pr)
ps.print_stats()
```
