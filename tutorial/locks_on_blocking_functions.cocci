// Identify locks on blocking functions
// Author: Julia Lawall
// See https://www.youtube.com/watch?v=xA5FBvuCvMs 25:26

@@
@@
( spin_lock(...)
| spin_lock_irqsave(...)
| spin_lock_irq(...)
| spin_lock_bh(...)
| spin_trylock(...)
)
  ... when != spin_unlock(...)
      when != spin_unlock_irqrestore(...)
      when != spin_unlock_irq(...)
      when != spin_unlock_bh(...)
* copy_from_user(...)
