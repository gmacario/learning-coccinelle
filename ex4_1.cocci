@@
expression hwif;
@@
- hwif->hwif_data
+ ide_get_hwifdata(hwif)

@@
expression hwif, data;
@@
- hwif->hwif_data = data
+ ide_set_hwifdata(hwif, data)

