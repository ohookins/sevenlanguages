; Maximum number of customers in the waiting room
(def maxWaitingCustomers 3)

; Minimum random wait time between customers in milliseconds
(def minWaitTime 10)

; Maximum random wait time between customers in milliseconds
(def maxWaitTime 30)

; Haircut time in milliseconds
(def haircutTime 20)

; Limit maximum runtime in milliseconds
(def maxRuntime (* 10 1000))

;;; Main Program ;;;
; Customer
(defrecord Customer [])

; Waiting Room
; q is a LinkedBlockingQueue, which can have 0 to maxWaitingCustomers customers
(defprotocol WaitingRoomProtocol
  (newCustomer [_, customer])
  (getCustomer [_])
)
(defrecord WaitingRoom [q]
  WaitingRoomProtocol
  (newCustomer [_, customer]
    (. q offer customer)
  )
  (getCustomer [_]
    (. q take)
  )
)

; Hmm, how do you deftype without defprotocol first?
(defprotocol StarterProtocol
  "Something that can be started in a future"
  (start [_])
)

; Something that introduces new customers to the system from the outside world.
(deftype CustomerSpawner [waitingRoom numCustomersCreated]
  StarterProtocol
  (start [_]
    (loop [customer (Customer.)]
      (swap! numCustomersCreated inc) ; increment number of total customers
      (newCustomer waitingRoom customer)
      (Thread/sleep (+ minWaitTime (rand-int (+ (- maxWaitTime minWaitTime) 1))))
      (recur (Customer.))
    )
  )
)

; Define the barber, which takes a waiting room and counter atom
(defrecord Barber [waitingRoom, counterAtom]
  StarterProtocol
  (start [_]
    (loop [customer (getCustomer waitingRoom) i 0] ; Sleep, waiting for next customer
     (Thread/sleep haircutTime) ; Give the haircut
      (swap! counterAtom inc); increment the counter atom
      (recur (getCustomer waitingRoom) (inc i)) ; Wait again for the next customer
    )
  )
)

; Record the number of haircuts given
(def numHaircutsGiven (atom 0))
(def numCustomersCreated (atom 0))

; Set up the waiting room, barber and customer spawner
(def waitingRoom (WaitingRoom. (java.util.concurrent.LinkedBlockingQueue. maxWaitingCustomers)))
(def barber (Barber. waitingRoom numHaircutsGiven))
(def customerSpawner (CustomerSpawner. waitingRoom numCustomersCreated))

; Start barber and waiting room in futures
(def barberFuture (future (start barber)))
(def spawnerFuture (future (start customerSpawner)))

; Wait maxRuntime and then stop the barber and spawner
(Thread/sleep maxRuntime)
(future-cancel barberFuture)
(future-cancel spawnerFuture)

; Now print how many haircuts were given
(println (str "The barber gave a total of " @numHaircutsGiven " haircuts in " (/ maxRuntime 1000.0) " seconds."))
(println (str "A total of " @numCustomersCreated " customers attempted to get their hair cut."))
