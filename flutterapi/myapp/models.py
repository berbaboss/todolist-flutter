from django.db import models

class Todolist(models.Model):
    title = models.CharField(max_length=100)   
    # name_length คือจำกัดตัวอักษร
    detail = models.TextField(null=True, blank=True)
    # null คือ ค่าใน database ว่างได้ blank คือไม่ต้องใส่ค่าตอนกรอก
    
    def __str__(self):
        return self.title

    # ให้ชื่อโชว์ใน database เป็น title


