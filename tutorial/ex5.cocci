@@ expression E1, E2, E3, E4; @@
- dma_map_single(E1,
+ pci_map_single(&E1->dev,
     E2, E3, E4)

@@ expression E1, E2, E3; @@
  dma_map_single(E1, E2, E3,
(
-    PCI_DMA_BIDIRECTIONAL
+    DMA_BIDIRECTIONAL
|
-    PCI_DMA_TODEVICE
+    DMA_TO_DEVICE
|
-    PCI_DMA_FROMDEVICE
+    DMA_FROM_DEVICE
|
-    PCI_DMA_NONE
+    DMA_NONE_DEVICE
)
  )
