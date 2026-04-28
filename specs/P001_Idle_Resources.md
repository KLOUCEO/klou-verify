# Specification: Policy 001 (Idle Resources)

## Description
This specification formally defines the parameters that constitute an "Idle Resource" within the context of KLOU's SMT engine.

## Conceptual Constraints
A compute resource (e.g., EC2) is defined as idle if the following conditions are met continuously over the observation window:
- `CPU_Utilization < 5.0%`
- `Network_In == 0 bytes`
- `Network_Out == 0 bytes`

## Proof Goal
The SMT solver is tasked with finding a satisfying assignment (`SAT`) where an instance is running but meets all the idle criteria, thus mathematically proving it is a source of financial waste.
