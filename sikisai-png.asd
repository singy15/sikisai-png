(defsystem "sikisai-png"
  :version "0.1.0"
  :author "kedama"
  :license "MIT"
  :depends-on ("sikisai" "png")
  :components ((:module "src"
                :components
                ((:file "sikisai-png"))))
  :description "PNG loader for sikisai.")

