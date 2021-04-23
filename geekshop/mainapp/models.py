from django.db import models


class ProductCategory(models.Model):
    name = models.CharField(max_length=64, unique=True, verbose_name='имя')
    description = models.TextField(verbose_name='описание', blank=True)
    is_active = models.BooleanField(verbose_name='активность', default=True)

    def __str__(self):
        return self.name


class Product(models.Model):
    category = models.ForeignKey(ProductCategory, on_delete=models.CASCADE)
    name = models.CharField(max_length=128, verbose_name='имя')
    image = models.ImageField(upload_to='products_images', blank=True)
    short_desc = models.CharField(max_length=64, blank=True, verbose_name='краткое описание')
    description = models.TextField(blank=True, verbose_name='описание')
    price = models.DecimalField(max_digits=8, decimal_places=2, default=0, verbose_name='цена')
    quantity = models.PositiveSmallIntegerField(default=0, verbose_name='кол-во на складе')
    is_active = models.BooleanField(verbose_name='активность', default=True)

    def __str__(self):
        return f'{self.name} ({self.category.name})'
