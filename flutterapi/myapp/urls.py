from django.urls import path
from .views import *
# * ดึงทุกฟังกชั่นใน view.py

urlpatterns = [
    path('', Home),
    path('api/all-todolist/', all_todolist ),  # http://localhost:8000/api/all-todolist/
    path('api/post-todolist', post_todolist ), #ไม่ต้องใส่ / หลังสุด
    path('api/update-todolist/<int:TID>', update_todolist),  #ส่งเป็น id เข้ามาใน path TID เหมือนตรง request
    path('api/delete-todolist/<int:TID>', delete_todolist),
]