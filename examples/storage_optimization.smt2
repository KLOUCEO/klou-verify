;; KLOU Conceptual Example: Storage Optimization Proof
;; 
;; This synthetic example demonstrates how to prove inefficiency in 
;; orphaned EBS volumes or extremely old snapshots.
;;
;; Constraint: A volume is "SAT" for waste if it is unattached, OR 
;; if it is a snapshot older than 90 days.

(set-logic QF_LIA)

;; Define variables
(declare-fun is_attached () Bool)
(declare-fun is_snapshot () Bool)
(declare-fun snapshot_age_days () Int)

;; Axioms (Mocked Data)
;; Scenario: An unattached EBS volume
(assert (not is_attached))
(assert (not is_snapshot))
(assert (= snapshot_age_days 0))

;; Policy Constraints
;; 1. Unattached volumes are waste
;; 2. Snapshots older than 90 days are waste
(declare-fun is_orphan_volume () Bool)
(assert (= is_orphan_volume (not is_attached)))

(declare-fun is_stale_snapshot () Bool)
(assert (= is_stale_snapshot (and is_snapshot (> snapshot_age_days 90))))

(declare-fun is_storage_waste () Bool)
(assert (= is_storage_waste (or is_orphan_volume is_stale_snapshot)))

;; Check if the current state is waste
(assert is_storage_waste)

(check-sat)
(get-model)
