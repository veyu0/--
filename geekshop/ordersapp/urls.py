import ordersapp.views as ordersapp
from django.urls import path

app_name = 'ordersapp'

urlpatterns = [
    path('', ordersapp.OrderList.as_view(), name='orders_list'),
    path('create/', ordersapp.OrderCreateView.as_view(), name='order_create'),
    path('read/<int:pk>/', ordersapp.OrderRead.as_view(),name='order_read'),
    path('update/<int:pk>/', ordersapp.OrderUpdateView.as_view(), name='order_update'),
    path('delete/<int:pk>/', ordersapp.OrderDelete.as_view(), name='order_delete'),

    #path('forming/complete/<int:pk>/', ordersapp.order_forming_complete, name='order_forming_complete')
]