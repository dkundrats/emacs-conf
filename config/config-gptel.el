(require 'auth-source)

(defun get-authinfo-secret (host user)
  "Retrieve the secret (password) for a given HOST and USER from `auth-source`."
  (let ((entry (car (auth-source-search :host host :user user :type 'netrc))))
    (when entry
      (funcall (plist-get entry :secret)))))

(let* ((api-host (get-authinfo-secret "openai-config" "api-host"))
       (api-key (get-authinfo-secret "openai-config" "openai-api-key"))
       (api-endpoint (get-authinfo-secret "openai-config" "openai-endpoint")))

  ;; Initialize gptel
  (setq gptel-model 'gpt-4o
        gptel-backend (gptel-make-azure "Azure-1"
                        :protocol "https"
                        :host api-host
                        :endpoint api-endpoint
                        :stream t
                        :key api-key
                        :models '(gpt-4o))))
