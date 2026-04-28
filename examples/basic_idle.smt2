;; KLOU Conceptual Example: Basic Idle Instance Proof
;; 
;; This is a synthetic representation of how KLOU proves financial waste.
;; It does NOT represent the actual KLOU proprietary metadata translator.
;;
;; Constraint: An EC2 instance is considered "SAT" for waste if its CPU 
;; utilization is under 5% and it has zero network traffic over the period.

(set-logic QF_LIRA)

;; Define variables for the instance state
(declare-fun cpu_utilization () Real)
(declare-fun network_in () Real)
(declare-fun network_out () Real)
(declare-fun is_running () Bool)

;; Axioms of the infrastructure state (Mocked Data)
(assert is_running)
(assert (= cpu_utilization 3.5)) ; 3.5% CPU
(assert (= network_in 0.0))
(assert (= network_out 0.0))

;; The Policy Constraint for "Waste"
;; Waste is defined as: Running AND CPU < 5.0 AND Network == 0
(declare-fun is_waste () Bool)
(assert (= is_waste 
    (and is_running 
         (< cpu_utilization 5.0) 
         (= network_in 0.0) 
         (= network_out 0.0))))

;; We want to check if the state satisfies the condition of being waste
(assert is_waste)

(check-sat)
(get-model)
