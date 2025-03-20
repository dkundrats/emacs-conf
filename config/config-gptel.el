(require 'auth-source)

(defun get-authinfo-secret (host user)
  "Retrieve the secret (password) for a given HOST and USER from `auth-source`."
  (let ((entry (car (auth-source-search :host host :user user :type 'netrc))))
    (when entry
      (funcall (plist-get entry :secret)))))

;; Get API key from auth-source
(let ((api-key (get-authinfo-secret "api-anthropic.com" "api-key")))
  ;; Initialize gptel with Claude
  (gptel-make-anthropic "Claude-7-Sonnet" ;Any name you want
    :key api-key
    :stream t
    :models '(claude-3-7-sonnet-20250219)
    :header (lambda () 
              (when-let* ((key (gptel--get-api-key)))
                `(("x-api-key" . ,key)
                  ("anthropic-version" . "2023-06-01")
                  ("anthropic-beta" . "pdfs-2024-09-25")
                  ("anthropic-beta" . "output-128k-2025-02-19")
                  ("anthropic-beta" . "prompt-caching-2024-07-31"))))
    :request-params '(:thinking (:type "enabled" :budget_tokens 2048)
                      :max_tokens 4096)))
