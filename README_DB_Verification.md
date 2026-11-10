# دليل التحقق من قاعدة البيانات ومراجعة المشروع

## 1️⃣ الاتصال بقاعدة البيانات (SQL Server LocalDB)

- **سلسلة الاتصال** المستخدمة في المشروع معرفة في `appsettings.json` وملف `DependencyInjection.cs`:
  ```
  Server=(localdb)\\MSSQLLocalDB;Database=FoodBridgeDb;Trusted_Connection=True;MultipleActiveResultSets=true;TrustServerCertificate=True
  ```
- **استخدام SSMS** (SQL Server Management Studio):
  1. افتح SSMS.
  2. في نافذة "Connect to Server"، اختر **Server type** = `Database Engine`.
  3. في حقل **Server name** أدخل `(localdb)\\MSSQLLocalDB`.
  4. اضغط **Connect** (المصادقة Windows تعمل تلقائيًا).
  5. بعد الاتصال، ستظهر قاعدة البيانات **FoodBridgeDb** ضمن المجلد *Databases*.
  6. يمكنك استعراض الجداول مثل `AspNetUsers`, `AspNetRoles`, `FoodListings` إلخ.

## 2️⃣ التحقق من تشغيل المشروع محليًا

- **تشغيل الواجهة الخلفية** (تم تشغيلها كعملية daemon في الخلفية):
  ```powershell
  cd "C:\\Users\\abdallah ahmed\\Downloads\\protifole\\FoodBridge"
  dotnet run --project src\\FoodBridge.Web\\FoodBridge.Web.csproj --urls "http://localhost:5000"
  ```
  ستظهر رسالة `Now listening on: http://localhost:5000`.

- **فتح الواجهة الأمامية**:
  - افتح المتصفح وادخل: `http://localhost:5000`.
  - ستظهر صفحة **Landing** مع إحصائيات المنصة.
  - من هناك يمكن الانتقال إلى **Register** أو **Login**.

## 3️⃣ اختبار تسجيل الدخول/التسجيل الحقيقي

1. **تسجيل مستخدم جديد** (Provider أو Charity):
   - املأ النموذج، تأكد من مطابقة كلمة المرور وحقل *Confirm Password*.
   - بعد الإرسال، سيظهر لك توست نجاح وإذا كانت خاصية `RequireConfirmedEmail` مفعلة فستحتاج إلى تأكيد البريد.
2. **تسجيل الدخول**:
   - استخدم البريد وكلمة المرور التي سجلتها.
   - بعد successful login، سيحولك التطبيق إلى لوحة تحكم حسب الدور (Admin, Provider, Charity).

## 4️⃣ أدوات سطر الأوامر للتحقق من الـ Migrations

- **عرض المايغريشنز المتوفرة**:
  ```powershell
  dotnet ef migrations list --project src/FoodBridge.Infrastructure/FoodBridge.Infrastructure.csproj
  ```
- **تحقق من قاعدة البيانات الحالية**:
  ```powershell
  dotnet ef dbcontext info --project src/FoodBridge.Infrastructure/FoodBridge.Infrastructure.csproj
  ```
  سيظهر لك اسم الـ DbContext (`FoodBridgeDbContext`) والprovider (`Microsoft.EntityFrameworkCore.SqlServer`).

## 5️⃣ (اختياري) التحويل إلى خادم SQL Server كامل

إذا كنت تفضل عدم استخدام LocalDB:
1. **تعديل `appsettings.json`** أو إعداد متغير بيئة `ConnectionStrings__DefaultConnection` إلى:
   ```json
   "DefaultConnection": "Server=.\\SQLEXPRESS;Database=FoodBridgeDb;Trusted_Connection=True;MultipleActiveResultSets=true;"
   ```
2. **إنشاء/تحديث قاعدة البيانات**:
   ```powershell
   dotnet ef database update --project src/FoodBridge.Infrastructure/FoodBridge.Infrastructure.csproj
   ```
3. تأكد من أن خدمة SQL Server (SQLEXPRESS) تعمل، ثم افتح القاعدة عبر SSMS باستخدام `Server=.\\SQLEXPRESS`.

## 6️⃣ ما يجب ملاحظته

- جميع تغييرات UI (Landing, Register, Login) موجودة في `src/FoodBridge.Web/wwwroot/app.js` و`index.html`.
- لا يوجد أي كود تجريبي (Demo Role Switcher أو Email‑log modal) متبقي.
- المصادقة الآن تعتمد على API حقيقي (`/api/auth/login`, `/api/auth/register`) وتوليد JWT.
- **التحقق من صلاحيات المسؤول**: بعد تسجيل حساب **Admin** (محدَّد يدويًا في قاعدة البيانات) يمكنك الدخول إلى `/admin` وستظهر لك لوحة التحكم.

---

إذا احتجت أي توجيه إضافي—مثل إعداد بيئة إنتاج، أو توصيل بقاعدة بيانات سحابية—أخبرني وسأساعدك.
