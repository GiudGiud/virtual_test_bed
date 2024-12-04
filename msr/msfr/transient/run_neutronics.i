################################################################################
## Molten Salt Fast Reactor - Euratom EVOL + Rosatom MARS Design              ##
## Griffin Main Application input file                                        ##
## Transient neutronics model                                                 ##
## Neutron diffusion with delayed precursor source, no equivalence            ##
################################################################################
# If using or referring to this model, please cite as explained in
# https://mooseframework.inl.gov/virtual_test_bed/citing.html

!include run_neutronics_base.i

# [MSRNeutronicsFluidCoupling]
#   fluid_blocks = 'fuel pump hx'
#   solid_blocks = 'reflector shield'
#   n_dnp = 6
#   use_transient_multi_app = true
#   initialize_variables_from_mesh_file = true
#   fluid_app_name = ns
#   fluid_input_file = run_ns.i
#   fluid_temperature_name_neutronics_app = tfuel
#   fluid_temperature_name_solid_suffix = _constant
#   fluid_temperature_name_fluid_app = T_fluid
#   dnp_name_prefix = c
#   dnp_array_name = dnp
# []

[AuxVariables]
  [tfuel]
    family = MONOMIAL
    order = CONSTANT
    initial_from_file_var = 'tfuel'
  []
  [tfuel_constant]
    family = MONOMIAL
    order = CONSTANT
    initial_condition = 873.15 # in degree K
    # initial_from_file_var = 'tfuel_constant'
  []
  [c1]
    order = CONSTANT
    family = MONOMIAL
    initial_from_file_var = c1
    block = 'fuel pump hx'
  []
  [c2]
    order = CONSTANT
    family = MONOMIAL
    initial_from_file_var = c2
    block = 'fuel pump hx'
  []
  [c3]
    order = CONSTANT
    family = MONOMIAL
    initial_from_file_var = c3
    block = 'fuel pump hx'
  []
  [c4]
    order = CONSTANT
    family = MONOMIAL
    initial_from_file_var = c4
    block = 'fuel pump hx'
  []
  [c5]
    order = CONSTANT
    family = MONOMIAL
    initial_from_file_var = c5
    block = 'fuel pump hx'
  []
  [c6]
    order = CONSTANT
    family = MONOMIAL
    initial_from_file_var = c6
    block = 'fuel pump hx'
  []
  [dnp]
    order = CONSTANT
    family = MONOMIAL
    components = 6
    # no need to initalize, initialized by auxkernels
    # initial_from_file_var = dnp
    block = 'fuel pump hx'
  []
[]

[AuxKernels]
  [build_dnp]
    type = BuildArrayVariableAux
    variable = dnp
    component_variables = 'c1 c2 c3 c4 c5 c6'
    execute_on = 'initial timestep_begin final'
  []
[]
