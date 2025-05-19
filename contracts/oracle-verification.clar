;; oracle-verification.clar
;; This contract validates data providers

;; Define a map to store authorized oracles
(define-map authorized-oracles principal bool)

;; Contract owner
(define-data-var contract-owner principal tx-sender)

;; Add an oracle to the authorized list
(define-public (add-oracle (oracle principal))
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) (err u1))
    (map-set authorized-oracles oracle true)
    (ok true)))

;; Remove an oracle from the authorized list
(define-public (remove-oracle (oracle principal))
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) (err u1))
    (map-delete authorized-oracles oracle)
    (ok true)))

;; Check if an oracle is authorized
(define-read-only (is-authorized-oracle (oracle principal))
  (default-to false (map-get? authorized-oracles oracle)))

;; Transfer ownership
(define-public (transfer-ownership (new-owner principal))
  (begin
    (asserts! (is-eq tx-sender (var-get contract-owner)) (err u1))
    (var-set contract-owner new-owner)
    (ok true)))
