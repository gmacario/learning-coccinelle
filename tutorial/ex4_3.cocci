@@ ide_hwif_t *hwif; expression data; @@
- hwif->hwif_data = data
+ ide_set_hwifdata(hwif, data)

@@ ide_hwif_t *hwif; @@
- hwif->hwif_data
+ ide_get_hwifdata(hwif)
