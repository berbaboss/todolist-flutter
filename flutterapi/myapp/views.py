from django.shortcuts import render
from django.http import JsonResponse

from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from .serializers import TodolistSerializer
from .models import Todolist

#GET Data
@api_view(['GET']) #เป้นการบอกว่า url นี้ใช้ได้แต่ get ม่าจาก api_view
def all_todolist(request):
    alltodolist = Todolist.objects.all()    # ดึงข้อมูลจาก model to do list = SELECT * FROM 
    serializer = TodolistSerializer(alltodolist,many=True)  #ข้อมูลที่ดึงมาเป็น list ไม่ใช json ต้องมีการบอกว่าดึงมากกว่า 1 ตรง many
    return Response(serializer.data , status=status.HTTP_200_OK)

#POST data (save data to database)
@api_view(['POST'])
def post_todolist(request):
    if request.method == 'POST':
        serializer = TodolistSerializer(data = request.data)  # ส่ง data มาจาก serializer
        if serializer.is_valid(): # check ข้อมูลที่ส่งมาถูกต้อง
            serializer.save()
            return Response(serializer.data , status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)

#PUT data (update data to database)
@api_view(['PUT'])
def update_todolist(request,TID):
    # localhost:8000/api/update-todolist/id
    todo = Todolist.objects.get(id=TID)          #จาก db todolist ดึง id = TID 
    if request.method == 'PUT':
        data = {}
        serializer = TodolistSerializer(todo,data=request.data)   #ใส่ todo เพื่อบอกว่าต้องการอันนี้เพื่อทำการ update
        if serializer.is_valid():
            serializer.save()
            data['status'] = 'updated'
            return Response(data=data, status=status.HTTP_201_CREATED)
        return  Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)

#deleted data (deleted data to database)
@api_view(['DELETE'])
def delete_todolist(request,TID):
    todo = Todolist.objects.get(id=TID)
    if request.method == 'DELETE':
        delete = todo.delete()
        data = {}
        if delete:
            data['status'] = 'deleted'
            statuscode = status.HTTP_200_OK
        else:
            data['status'] = 'failed'
            statuscode = status.HTTP_400_BAD_REQUEST
        return Response(data=data , status=statuscode)


data = [
    {
        "title":"คอมพิวเตอร์คืออะไร5?",
        "subtitle":"คอมพิวเตอร์ คือ อุปกรณ์ที่ใช้สำหรับการคำนวณและทำงานอื่นๆ?",
        "image_url":"https://raw.githubusercontent.com/berbaboss/BasicAPI/main/coding.jpg",
        "detail":"คอมพิวเตอร์ (อังกฤษ: computer) หรือศัพท์บัญญัติราชบัณฑิตยสภาว่า คณิตกรณ์[2][3] เป็นเครื่องจักรแบบสั่งการได้ที่ออกแบบมาเพื่อดำเนินการกับลำดับตัวดำเนินการทางตรรกศาสตร์หรือคณิตศาสตร์ โดยอนุกรมนี้อาจเปลี่ยนแปลงได้เมื่อพร้อม ส่งผลให้คอมพิวเตอร์สามารถแก้ปัญหาได้มากมาย\n\nคอมพิวเตอร์ถูกประดิษฐ์ออกมาให้ประกอบไปด้วยความจำรูปแบบต่าง ๆ เพื่อเก็บข้อมูล อย่างน้อยหนึ่งส่วนที่มีหน้าที่ดำเนินการคำนวณเกี่ยวกับตัวดำเนินการทางตรรกศาสตร์ และตัวดำเนินการทางคณิตศาสตร์ และส่วนควบคุมที่ใช้เปลี่ยนแปลงลำดับของตัวดำเนินการโดยยึดสารสนเทศที่ถูกเก็บไว้เป็นหลัก อุปกรณ์เหล่านี้จะยอมให้นำเข้าข้อมูลจากแหล่งภายนอก และส่งผลจากการคำนวณตัวดำเนินการออกไป"
        
    },
    {
        "title":"มาเขียนโปรแกรมกัน!",
        "subtitle":"บทความนี้จะแนะนำการเริ่มต้นเขียนโปรแกรม",
        "image_url":"https://raw.githubusercontent.com/berbaboss/BasicAPI/main/home.jpg",
        "detail":"การเขียนโปรแกรมคอมพิวเตอร์ (อังกฤษ: Computer programming) หรือเรียกให้สั้นลงว่า การเขียนโปรแกรม (อังกฤษ: Programming) หรือ การเขียนโค้ด (Coding) เป็นขั้นตอนการเขียน ทดสอบ และดูแลซอร์สโค้ดของโปรแกรมคอมพิวเตอร์ ซึ่งซอร์สโค้ดนั้นจะเขียนด้วยภาษาโปรแกรม ขั้นตอนการเขียนโปรแกรมต้องการความรู้ในหลายด้านด้วยกัน เกี่ยวกับโปรแกรมที่ต้องการจะเขียน และขั้นตอนวิธีที่จะใช้ ซึ่งในวิศวกรรมซอฟต์แวร์นั้น การเขียนโปรแกรมถือเป็นเพียงขั้นหนึ่งในวงจรชีวิตของการพัฒนาซอฟต์แวร์"
    },
    {
        "title":"Flutter คือ?",
        "subtitle":"Tools สำหรับออกแบบ UI ของ Google",
        "image_url":"https://raw.githubusercontent.com/berbaboss/BasicAPI/main/phone.jpg",
        "detail":"Flutter 2 สร้างโดย Google บริษัทเทคโนโลยีอันดับต้นๆของโลก ที่มาพร้อมกับความสวยงาม อลังการ พาไปวัดไปวาแบบไม่ต้องอายใคร 55 อีกทั้งสามารถเขียนโปรแกรมครั้งเดียวด้วยภาษา Dart ที่ถูกออกแบบมาให้เขียนง่าย เข้าใจได้ไม่ยาก เขียนแค่ครั้งเดียว ส่งไปใช้งานได้ทุกแพลตฟอร์ม ไม่ว่าจะเป็น Android, iOS, Web Application, Windows, Linux, MacOS เรียกได้ว่าเขียนครั้งเดียวจบ ส่งไปใช้งานได้เลย"
    },
    {
        "title":"Python คือ?",
        "subtitle":"ภาษาเขียนโปรแกรมชนิดหนึ่ง สร้างขึ้นเมื่อ 1991",
        "image_url":"https://raw.githubusercontent.com/berbaboss/BasicAPI/main/work.jpg",
        "detail":"ภาษาไพทอน (Python programming language) หรือที่มักเรียกกันว่าไพทอน เป็นภาษาระดับสูงซึ่งสร้างโดยคีโด ฟัน โรสซึม โดยเริ่มในปีพ.ศ. 2533 การออกแบบของภาษาไพทอนมุ่งเน้นให้ผู้โปรแกรมสามารถอ่านชุดคำสั่งได้โดยง่ายผ่านการใช้งานอักขระเว้นว่าง (whitespaces) จำนวนมาก นอกจากนั้นการออกแบบภาษาไพทอนและการประยุกต์ใช้แนวคิดการเขียนโปรแกรมเชิงวัตถุในตัวภาษายังช่วยให้นักเขียนโปรแกรมสามารถเขียนโปรแกรมที่เป็นระเบียบ อ่านง่าย มีขนาดเล็ก และง่ายต่อการบำรุง[3]"
    },
    {
        "title":"PyPI คือ?",
        "subtitle":"แหล่งรวม package ของ Python",
        "image_url":"https://raw.githubusercontent.com/berbaboss/BasicAPI/main/pypi.png",
        "detail":"The Python Package Index, abbreviated as PyPI (/ˌpaɪpiˈaɪ/) and also known as the Cheese Shop (a reference to the Monty Python's Flying Circus sketch \"Cheese Shop\"),[3][4] is the official third-party software repository for Python.[5] It is analogous to CPAN, the repository for Perl.[6] Some package managers, including pip, use PyPI as the default source for packages and their dependencies.[7][8] As of 1 September 2021, over 324,836 Python packages can be accessed through PyPI.[9]"
    }

]
# Create your views here.

def Home(request):
    return JsonResponse(data=data,safe=False,json_dumps_params={'ensure_ascii': False}) 