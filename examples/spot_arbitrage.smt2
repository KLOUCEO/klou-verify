;; KLOU Conceptual Example: Spot Arbitrage Demonstration
;; 
;; This synthetic example shows how runtime constraints invalidate the use 
;; of On-Demand instances in favor of Spot instances.
;;
;; Constraint: If an instance is running a stateless, interruptible workload
;; (e.g., batch processing) and its maximum required runtime is < 1 hour,
;; running it as On-Demand is considered "SAT" for financial waste.

(set-logic QF_LIRA)

;; Define variables
(declare-fun is_stateless () Bool)
(declare-fun is_interruptible () Bool)
(declare-fun max_runtime_hours () Real)
(declare-fun is_on_demand () Bool)
(declare-fun is_spot () Bool)

;; Axioms (Mocked Data)
;; Scenario: A batch processing job running On-Demand
(assert is_stateless)
(assert is_interruptible)
(assert (= max_runtime_hours 0.5)) ; 30 minutes
(assert is_on_demand)
(assert (not is_spot))

;; Ensure mutually exclusive pricing models in this mock
(assert (not (= is_on_demand is_spot)))

;; Policy Constraints
;; A workload is spot-eligible if it's stateless, interruptible, and short-lived
(declare-fun is_spot_eligible () Bool)
(assert (= is_spot_eligible 
    (and is_stateless is_interruptible (< max_runtime_hours 1.0))))

;; It is considered waste if it is spot-eligible BUT running on-demand
(declare-fun is_pricing_waste () Bool)
(assert (= is_pricing_waste (and is_spot_eligible is_on_demand)))

;; Check if the current configuration represents financial waste
(assert is_pricing_waste)

(check-sat)
(get-model)
