# Nelder-Mead and Multi Directional Search methods

## Run examples

Enter project home directory and run code snippets.

#### Initial simplex generation

```matlab
init
run('examples/initial_simplices/regular_simplex.m');
run('examples/initial_simplices/right_simplex.m');
run('examples/initial_simplices/pfeffer_method.m');
```

#### Perturbed quadratics

```matlab
init
run('examples/perturbed_quadratics/perturbed_quadratics.m');
```

#### Rosenbrock Valley

```matlab
init
run('examples/rosenbrock_valley/nm.m');
run('examples/rosenbrock_valley/mds.m');
```

#### Nelder favorite examples

```matlab
init
run('examples/nelders_favorite/nelders_favorite-1.m');
run('examples/nelders_favorite/nelders_favorite-2.m');
run('examples/nelders_favorite/nelders_favorite-3.m');
```

#### McKinnon examples (original and with Kelley's restarts)

```matlab
init
run('examples/mckinnon/mckinnon-1.m');
run('examples/mckinnon/mckinnon-2.m');
run('examples/mckinnon/mckinnon-3.m');
run('examples/mckinnon/mckinnon-with-restarts-1.m');
run('examples/mckinnon/mckinnon-with-restarts-2.m');
run('examples/mckinnon/mckinnon-with-restarts-3.m');
```

#### Woods examples of premature Nelder-Mead termination

```matlab
init
run('examples/nm_pretermination/nm_pretermination-1.m');
run('examples/nm_pretermination/nm_pretermination-2.m');
```
