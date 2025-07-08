# 🎟️ TicketEase API Documentation

## API Version
Current: v1  

## 📌 Overview
This collection includes authentication, booking, and notification APIs for the TicketEase mobile application.

## 🔐 Authentication
Explain how to authenticate. Example:
- Use `/api/auth/login` to obtain a token
- Add `Authorization: Bearer <token>` to protected endpoints

# 📁 Collection: Auth 
undefined 

## End-point: request otp
### Method: POST
>```
>{{base_url}}/api/auth/request-otp
>```
### Headers

|Content-Type|Value|
|---|---|
|Content-Type|application/json|


### Body (**raw**)

```json
{
  "identifier": "seed2@inboxkitten.com"
}
```

### Response: 200
```json
{
    "message": "OTP sent"
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: signup
### Method: POST
>```
>{{base_url}}/api/auth/signup
>```
### Body (**raw**)

```json
{
  "email": "user@example.com",
  "name": "John Doe",
  "mobile": "1234567891"
}
```

### Response: 200
```json
{
    "message": "OTP sent"
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: login
### Method: POST
>```
>{{base_url}}/api/auth/login
>```
### Body (**raw**)

```json
{
  "email": "seed2@inboxkitten.com"
}
```

### Response: 200
```json
{
    "message": "OTP sent"
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: verify-otp
### Method: POST
>```
>{{base_url}}/api/auth/verify-otp
>```
### Body (**raw**)

```json
{
  "identifier": "seed2@inboxkitten.com",
  "otp":"4952"
}
```

### Response: 200
```json
{
    "message": "Verified successfully",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIyNjcxMzczNC03MWVmLTQwNDktOTY5Mi0xOTU1NzgwM2M3MTQiLCJpYXQiOjE3NTE2MDkxMzAsImV4cCI6MTc1MjIxMzkzMH0.bT-Hp1B9K8rw7_LAwUb9TdlOejpZWSN3m9azO-Hc2zo"
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: request otp with invalid email
### Method: POST
>```
>{{base_url}}/api/auth/request-otp
>```
### Headers

|Content-Type|Value|
|---|---|
|Content-Type|application/json|


### Body (**raw**)

```json
{
  "identifier": "temp1@.com"
}
```

### Response: 400
```json
{
    "message": "Invalid identifier"
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: signup with invalid email
### Method: POST
>```
>{{base_url}}/api/auth/signup
>```
### Headers

|Content-Type|Value|
|---|---|
|Content-Type|application/json|


### Body (**raw**)

```json
{
  "email": "userexample.com",
  "name": "John Doe",
  "mobile": "1234567891"
}
```

### Response: 400
```json
{
    "message": "Invalid email or mobile"
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: signup with already exist email
### Method: POST
>```
>{{base_url}}/api/auth/signup
>```
### Headers

|Content-Type|Value|
|---|---|
|Content-Type|application/json|


### Body (**raw**)

```json
{
  "email": "seed2@inboxkitten.com",
  "name": "John Doe Tor",
  "mobile": "1234567892"
}
```

### Response: 409
```json
{
    "message": "User already exists with this email or mobile"
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: wrong-otp
### Method: POST
>```
>{{base_url}}/api/auth/verify-otp
>```
### Headers

|Content-Type|Value|
|---|---|
|Content-Type|application/json|


### Body (**raw**)

```json
{
  "identifier": "seed2@inboxkitten.com",
  "otp":"4951"
}
```

### Response: 401
```json
{
    "message": "Invalid or expired OTP"
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃
# 📁 Collection: Movies 
undefined 


## End-point: latest
### Method: GET
>```
>{{base_url}}/api/movies/latest
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Body (**raw**)

```json
{}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 200
```json
[
    {
        "id": 16,
        "title": "Customer-focused radical hardware",
        "description": "Stips aurum capitulus theca audio vinitor. Laborum cohibeo calamitas vallum vero suppono uredo altus repellendus. Celebrer ara aveho bellicus contego stips administratio urbs comminor summopere.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?movie&sig=20",
        "releaseDate": "2025-07-16T21:08:16.061Z",
        "timeSlot": "14:00",
        "duration": 153,
        "format": "D3",
        "language": "Gujarati",
        "priceAdult": 103.1655609808649,
        "priceKid": 84.01944948461616,
        "priceSchool": 82.99906923852217,
        "createdAt": "2025-07-03T17:09:44.552Z"
    },
    {
        "id": 18,
        "title": "Balanced cohesive structure",
        "description": "Clamo tumultus canonicus. Thesis tubineus sed defessus. Campana laboriosam vulgus praesentium subiungo.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?movie&sig=2593",
        "releaseDate": "2025-07-14T00:41:57.184Z",
        "timeSlot": "10:00",
        "duration": 174,
        "format": "D2",
        "language": "English",
        "priceAdult": 222.6050296222667,
        "priceKid": 94.88891295537809,
        "priceSchool": 80.44984526776327,
        "createdAt": "2025-07-03T17:09:44.554Z"
    },
    {
        "id": 19,
        "title": "Open-architected 24/7 service-desk",
        "description": "Cattus cattus acsi alioqui decor aggero cupiditas tersus. Depopulo tandem synagoga voco canonicus comminor. Vilicus vacuus soluta nobis carmen quia vacuus.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?movie&sig=1913",
        "releaseDate": "2025-07-09T17:53:16.659Z",
        "timeSlot": "14:00",
        "duration": 127,
        "format": "D2",
        "language": "Tamil",
        "priceAdult": 167.0634292023135,
        "priceKid": 64.82422194815545,
        "priceSchool": 64.18687032065664,
        "createdAt": "2025-07-03T17:09:44.552Z"
    },
    {
        "id": 15,
        "title": "Advanced intermediate architecture",
        "description": "Ipsum desolo nobis umquam amita saepe volaticus unde harum sunt. Veritas deprecator denique appono atqui. Adhuc curvo volubilis canis caelestis verto capitulus correptius audeo terror.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?movie&sig=4391",
        "releaseDate": "2025-07-08T18:36:51.628Z",
        "timeSlot": "18:00",
        "duration": 91,
        "format": "D2",
        "language": "Hindi",
        "priceAdult": 224.7858548334125,
        "priceKid": 95.15030577172898,
        "priceSchool": 86.70001556507418,
        "createdAt": "2025-07-03T17:09:44.553Z"
    },
    {
        "id": 20,
        "title": "Intuitive maximized attitude",
        "description": "Vesco vesco deinde studio deleo teneo subseco cuppedia cribro. Audeo arcus admitto itaque terra desidero traho vestrum bellum. Attollo campana recusandae vere.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?movie&sig=7496",
        "releaseDate": "2025-07-07T23:56:58.296Z",
        "timeSlot": "16:00",
        "duration": 151,
        "format": "D2",
        "language": "Gujarati",
        "priceAdult": 196.4470373235232,
        "priceKid": 88.45428731534088,
        "priceSchool": 53.59991780416055,
        "createdAt": "2025-07-03T17:09:44.554Z"
    }
]
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: all
### Method: GET
>```
>{{base_url}}/api/movies
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Body (**raw**)

```json
{}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 200
```json
[
    {
        "id": 15,
        "title": "Advanced intermediate architecture",
        "description": "Ipsum desolo nobis umquam amita saepe volaticus unde harum sunt. Veritas deprecator denique appono atqui. Adhuc curvo volubilis canis caelestis verto capitulus correptius audeo terror.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?movie&sig=4391",
        "releaseDate": "2025-07-08T18:36:51.628Z",
        "timeSlot": "18:00",
        "duration": 91,
        "format": "D2",
        "language": "Hindi",
        "priceAdult": 224.7858548334125,
        "priceKid": 95.15030577172898,
        "priceSchool": 86.70001556507418,
        "createdAt": "2025-07-03T17:09:44.553Z"
    },
    {
        "id": 16,
        "title": "Customer-focused radical hardware",
        "description": "Stips aurum capitulus theca audio vinitor. Laborum cohibeo calamitas vallum vero suppono uredo altus repellendus. Celebrer ara aveho bellicus contego stips administratio urbs comminor summopere.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?movie&sig=20",
        "releaseDate": "2025-07-16T21:08:16.061Z",
        "timeSlot": "14:00",
        "duration": 153,
        "format": "D3",
        "language": "Gujarati",
        "priceAdult": 103.1655609808649,
        "priceKid": 84.01944948461616,
        "priceSchool": 82.99906923852217,
        "createdAt": "2025-07-03T17:09:44.552Z"
    },
    {
        "id": 17,
        "title": "Customer-focused heuristic utilisation",
        "description": "Comedo volutabrum custodia. Terror laboriosam admitto damno advenio odit curvo delinquo. Itaque tertius cubo subiungo vere adhuc viscus expedita tripudio utrimque.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?movie&sig=516",
        "releaseDate": "2025-07-04T22:03:07.074Z",
        "timeSlot": "15:00",
        "duration": 138,
        "format": "D3",
        "language": "Hindi",
        "priceAdult": 233.7562738977529,
        "priceKid": 85.4272804008537,
        "priceSchool": 59.55059022012787,
        "createdAt": "2025-07-03T17:09:44.552Z"
    },
    {
        "id": 18,
        "title": "Balanced cohesive structure",
        "description": "Clamo tumultus canonicus. Thesis tubineus sed defessus. Campana laboriosam vulgus praesentium subiungo.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?movie&sig=2593",
        "releaseDate": "2025-07-14T00:41:57.184Z",
        "timeSlot": "10:00",
        "duration": 174,
        "format": "D2",
        "language": "English",
        "priceAdult": 222.6050296222667,
        "priceKid": 94.88891295537809,
        "priceSchool": 80.44984526776327,
        "createdAt": "2025-07-03T17:09:44.554Z"
    },
    {
        "id": 19,
        "title": "Open-architected 24/7 service-desk",
        "description": "Cattus cattus acsi alioqui decor aggero cupiditas tersus. Depopulo tandem synagoga voco canonicus comminor. Vilicus vacuus soluta nobis carmen quia vacuus.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?movie&sig=1913",
        "releaseDate": "2025-07-09T17:53:16.659Z",
        "timeSlot": "14:00",
        "duration": 127,
        "format": "D2",
        "language": "Tamil",
        "priceAdult": 167.0634292023135,
        "priceKid": 64.82422194815545,
        "priceSchool": 64.18687032065664,
        "createdAt": "2025-07-03T17:09:44.552Z"
    },
    {
        "id": 20,
        "title": "Intuitive maximized attitude",
        "description": "Vesco vesco deinde studio deleo teneo subseco cuppedia cribro. Audeo arcus admitto itaque terra desidero traho vestrum bellum. Attollo campana recusandae vere.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?movie&sig=7496",
        "releaseDate": "2025-07-07T23:56:58.296Z",
        "timeSlot": "16:00",
        "duration": 151,
        "format": "D2",
        "language": "Gujarati",
        "priceAdult": 196.4470373235232,
        "priceKid": 88.45428731534088,
        "priceSchool": 53.59991780416055,
        "createdAt": "2025-07-03T17:09:44.554Z"
    },
    {
        "id": 21,
        "title": "Total zero administration capacity",
        "description": "Repellendus aspernatur tollo corrupti suasoria. Adipisci universe debilito aegre ea supplanto certus decretum. Accedo cicuta sum admoneo conatus cum carbo.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?movie&sig=6455",
        "releaseDate": "2025-07-07T04:33:17.021Z",
        "timeSlot": "11:00",
        "duration": 129,
        "format": "D2",
        "language": "Hindi",
        "priceAdult": 195.6879339613714,
        "priceKid": 81.51644695679212,
        "priceSchool": 85.6152195241929,
        "createdAt": "2025-07-03T17:09:44.555Z"
    }
]
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Unauthorized
### Method: GET
>```
>{{base_url}}/api/movies/latest
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Body (**raw**)

```json
{}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 401
```json
{
    "message": "Unauthorized"
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃
# 📁 Collection: Entry/Attraction/Parking/News/Outreach 
undefined 


## End-point: entry-tickets
### Method: GET
>```
>{{base_url}}/api/entry-tickets
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Body (**raw**)

```json
{}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 200
```json
[
    {
        "id": "3c728e88-28b7-4ba6-bc05-a9f41560f423",
        "name": "Adult",
        "description": "People above 18 Years of age",
        "price": 20,
        "slotCount": 100,
        "iconUrl": "https://cdn-icons-png.flaticon.com/512/3571/3571490.png",
        "createdAt": "2025-07-03T17:09:37.990Z",
        "updatedAt": "2025-07-03T17:09:37.990Z"
    },
    {
        "id": "314d0fee-61a7-455d-9f47-4eda2e0b1590",
        "name": "kids",
        "description": "Age between 8 to 18 years",
        "price": 10,
        "slotCount": 100,
        "iconUrl": "https://cdn-icons-png.flaticon.com/512/3571/3571490.png",
        "createdAt": "2025-07-03T17:09:37.990Z",
        "updatedAt": "2025-07-03T17:09:37.990Z"
    },
    {
        "id": "01c79c4b-dec0-40b5-aea3-a4f8534fec8e",
        "name": "Schools",
        "description": "A min of 15 pax",
        "price": 5,
        "slotCount": 50,
        "iconUrl": "https://cdn-icons-png.flaticon.com/512/2645/2645897.png",
        "createdAt": "2025-07-03T17:09:37.990Z",
        "updatedAt": "2025-07-03T17:09:37.990Z"
    }
]
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: attractions
### Method: GET
>```
>{{base_url}}/api/attractions
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Body (**raw**)

```json
{}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 200
```json
[
    {
        "id": 15,
        "title": "Rustic Granite Hat",
        "description": "Ex synagoga tactus accendo minima tribuo quia unde. Socius patrocinor porro correptius tabula cogito uredo alveus appositus. Stultus corrupti auxilium amplexus cunabula timidus congregatio conscendo tepesco ullam.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?attraction&sig=3147",
        "priceAdult": 121.2204902380899,
        "priceKid": 85.51849402093293,
        "priceSchool": 75.06266803708453,
        "createdAt": "2025-07-03T17:09:41.942Z",
        "updatedAt": "2025-07-03T17:09:41.942Z"
    },
    {
        "id": 16,
        "title": "Awesome Bamboo Towels",
        "description": "Sui centum accusator. Venio utrimque acies nihil tego valde decor tero uredo comes. Amita totus aufero aequus urbanus fuga alter.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?attraction&sig=3215",
        "priceAdult": 133.0310319727652,
        "priceKid": 84.47784624582752,
        "priceSchool": 44.4728484201958,
        "createdAt": "2025-07-03T17:09:41.943Z",
        "updatedAt": "2025-07-03T17:09:41.943Z"
    },
    {
        "id": 17,
        "title": "Incredible Plastic Computer",
        "description": "Provident ab amicitia verecundia ante. Corroboro vinculum curtus est vestigium sordeo patruus. Utilis acidus stillicidium cetera.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?attraction&sig=3724",
        "priceAdult": 150.4383159153446,
        "priceKid": 90.3088434079508,
        "priceSchool": 69.87609704208731,
        "createdAt": "2025-07-03T17:09:41.943Z",
        "updatedAt": "2025-07-03T17:09:41.943Z"
    },
    {
        "id": 18,
        "title": "Handcrafted Bamboo Computer",
        "description": "Viriliter collum desipio carmen uxor nesciunt tui. Tametsi vilitas crustulum caritas animus crustulum. Summisse audentia degero aureus cavus vere.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?attraction&sig=4153",
        "priceAdult": 100.6764244359491,
        "priceKid": 75.65016723792037,
        "priceSchool": 63.30999475695295,
        "createdAt": "2025-07-03T17:09:41.943Z",
        "updatedAt": "2025-07-03T17:09:41.943Z"
    },
    {
        "id": 20,
        "title": "Handcrafted Granite Pants",
        "description": "Deprecator somnus sollicito. Sonitus eveniet vae virga. Decipio absque colo ait.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?attraction&sig=8192",
        "priceAdult": 141.4969120471454,
        "priceKid": 70.82385329168453,
        "priceSchool": 51.76187912365696,
        "createdAt": "2025-07-03T17:09:41.942Z",
        "updatedAt": "2025-07-03T17:09:41.942Z"
    },
    {
        "id": 19,
        "title": "Sleek Metal Chair",
        "description": "Conor saepe crebro adflicto. Terreo tabesco abbas tres aggero. Vado valetudo conqueror turbo est turpis sodalitas carpo decor.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?attraction&sig=5248",
        "priceAdult": 167.1458692670848,
        "priceKid": 60.23561326090362,
        "priceSchool": 59.21107764617654,
        "createdAt": "2025-07-03T17:09:41.942Z",
        "updatedAt": "2025-07-03T17:09:41.942Z"
    },
    {
        "id": 21,
        "title": "Handmade Marble Bike",
        "description": "Ambulo reiciendis venio admoneo utrimque spiculum ventosus cenaculum ullus. Cito demitto voluptatum uterque curvo arbor sto. Ademptio rerum congregatio.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?attraction&sig=3853",
        "priceAdult": 146.0717598372082,
        "priceKid": 79.49337219072586,
        "priceSchool": 41.89260539212751,
        "createdAt": "2025-07-03T17:09:41.942Z",
        "updatedAt": "2025-07-03T17:09:41.942Z"
    }
]
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: parking-options
### Method: GET
>```
>{{base_url}}/api/parking-options
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Body (**raw**)

```json
{}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 200
```json
[
    {
        "id": "b3cd64cd-b26d-45dc-8d10-f8859421f3c4",
        "vehicleType": "two_wheeler",
        "description": "Scooter,Bike etc",
        "price": 5,
        "slotCount": 40,
        "createdAt": "2025-07-03T17:09:39.845Z",
        "updatedAt": "2025-07-03T17:09:39.845Z"
    },
    {
        "id": "d401f5d7-752e-489d-956b-3ae200fcdd81",
        "vehicleType": "four_wheeler",
        "description": "Car & Passenger Vehicles",
        "price": 10,
        "slotCount": 30,
        "createdAt": "2025-07-03T17:09:39.845Z",
        "updatedAt": "2025-07-03T17:09:39.845Z"
    },
    {
        "id": "fa7faf76-2094-4054-81ea-9e7c21412860",
        "vehicleType": "school_bus",
        "description": "A min of 15 pax makes a group",
        "price": 25,
        "slotCount": 10,
        "createdAt": "2025-07-03T17:09:39.845Z",
        "updatedAt": "2025-07-03T17:09:39.845Z"
    }
]
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: news
### Method: GET
>```
>{{base_url}}/api/news
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Response: 200
```json
[
    {
        "id": 3,
        "summary": "Derelinquo coadunatio coaegresco verbera validus chirographum.",
        "date": "2025-07-03T16:48:51.150Z",
        "createdAt": "2025-07-03T17:09:46.426Z"
    },
    {
        "id": 4,
        "summary": "Bonus civis supellex benigne fugiat sapiente demitto.",
        "date": "2025-07-03T15:29:26.489Z",
        "createdAt": "2025-07-03T17:09:46.426Z"
    },
    {
        "id": 7,
        "summary": "Argentum distinctio coruscus approbo sui templum ex vos alii subnecto.",
        "date": "2025-07-03T15:22:03.377Z",
        "createdAt": "2025-07-03T17:09:46.428Z"
    },
    {
        "id": 1,
        "summary": "Triduana corrigo necessitatibus.",
        "date": "2025-07-03T03:44:57.891Z",
        "createdAt": "2025-07-03T17:09:46.427Z"
    },
    {
        "id": 2,
        "summary": "Paens ter terminatio tego.",
        "date": "2025-07-02T23:55:19.167Z",
        "createdAt": "2025-07-03T17:09:46.425Z"
    },
    {
        "id": 6,
        "summary": "Defendo candidus sulum appello natus minima tot.",
        "date": "2025-07-02T23:49:46.466Z",
        "createdAt": "2025-07-03T17:09:46.428Z"
    },
    {
        "id": 5,
        "summary": "Suscipio defendo stips curiositas suppellex carmen bos subseco.",
        "date": "2025-07-02T17:56:32.658Z",
        "createdAt": "2025-07-03T17:09:46.425Z"
    }
]
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: outreach
### Method: GET
>```
>{{base_url}}/api/outreach
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Response: 200
```json
[
    {
        "id": 4,
        "title": "Expanded zero defect software",
        "description": "Cenaculum temeritas turpis ciminatio quidem sit. Vereor crapula comparo.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?event&sig=1087",
        "Startdate": "2025-07-01T17:40:19.642Z",
        "Enddate": "2025-07-15T10:40:50.408Z",
        "createdAt": "2025-07-03T17:09:45.535Z",
        "updatedAt": "2025-07-03T17:09:45.535Z"
    },
    {
        "id": 7,
        "title": "Polarised discrete infrastructure",
        "description": "Vilitas volva aestus torqueo suasoria vulnero solus. Taedium adeo laborum dens voco claustrum thesaurus defaeco reiciendis denique.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?event&sig=7945",
        "Startdate": "2025-07-01T10:29:22.313Z",
        "Enddate": "2025-07-09T19:52:03.427Z",
        "createdAt": "2025-07-03T17:09:45.538Z",
        "updatedAt": "2025-07-03T17:09:45.538Z"
    },
    {
        "id": 1,
        "title": "Exclusive real-time data-warehouse",
        "description": "Patior spiculum sustineo conor. Suspendo nam consequuntur alveus clementia cresco canonicus agnosco.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?event&sig=8764",
        "Startdate": "2025-06-29T21:31:47.074Z",
        "Enddate": "2025-07-20T23:37:07.768Z",
        "createdAt": "2025-07-03T17:09:45.538Z",
        "updatedAt": "2025-07-03T17:09:45.538Z"
    },
    {
        "id": 2,
        "title": "Open-source context-sensitive complexity",
        "description": "Cursus sonitus demulceo. Quibusdam vinitor quia amissio comptus.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?event&sig=6200",
        "Startdate": "2025-06-28T16:36:02.795Z",
        "Enddate": "2025-07-10T00:37:38.059Z",
        "createdAt": "2025-07-03T17:09:45.535Z",
        "updatedAt": "2025-07-03T17:09:45.535Z"
    },
    {
        "id": 5,
        "title": "Intuitive high-level access",
        "description": "Tempus basium tendo thesaurus summopere. Usus aranea quis vix viscus eligendi undique thalassinus titulus ter.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?event&sig=5203",
        "Startdate": "2025-06-27T12:29:07.734Z",
        "Enddate": "2025-07-04T00:36:50.085Z",
        "createdAt": "2025-07-03T17:09:45.535Z",
        "updatedAt": "2025-07-03T17:09:45.535Z"
    },
    {
        "id": 6,
        "title": "User-friendly fresh-thinking core",
        "description": "Claro angelus valens verto dapifer cuppedia. Sulum sursum vobis desparatus viriliter aggero contego aliqua cresco.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?event&sig=3993",
        "Startdate": "2025-06-26T18:57:08.115Z",
        "Enddate": "2025-07-05T06:03:22.252Z",
        "createdAt": "2025-07-03T17:09:45.538Z",
        "updatedAt": "2025-07-03T17:09:45.538Z"
    },
    {
        "id": 3,
        "title": "Universal value-added core",
        "description": "Suus tristis terror. Undique cotidie tergiversatio accendo tumultus defaeco tego.",
        "imageUrl": "https://source.unsplash.com/random/800x600/?event&sig=9096",
        "Startdate": "2025-06-24T15:35:05.286Z",
        "Enddate": "2025-07-14T16:44:25.506Z",
        "createdAt": "2025-07-03T17:09:45.535Z",
        "updatedAt": "2025-07-03T17:09:45.535Z"
    }
]
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Unauthorized
### Method: GET
>```
>{{base_url}}/api/parking-options
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Body (**raw**)

```json
{}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 401
```json
{
    "message": "Unauthorized"
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃
# 📁 Collection: Notifications 
undefined 


## End-point: unread notification count
### Method: GET
>```
>{{base_url}}/api/notifications/count
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Body (**raw**)

```json
{}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 200
```json
{
    "count": 1
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: all notification for particular user
### Method: GET
>```
>{{base_url}}/api/notifications
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Body (**raw**)

```json
{}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 200
```json
[
    {
        "id": 3,
        "title": "Booking Confirmed",
        "message": "Your booking is paid. Total: ₹25.00",
        "isRead": false,
        "userId": "26713734-71ef-4049-9692-19557803c714",
        "createdAt": "2025-07-03T17:09:55.912Z"
    },
    {
        "id": 2,
        "title": "Booking Failed",
        "message": "Your booking is pending. Total: ₹267.61",
        "isRead": true,
        "userId": "26713734-71ef-4049-9692-19557803c714",
        "createdAt": "2025-07-03T17:09:54.357Z"
    }
]
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: mark read notification
### Method: PUT
>```
>{{base_url}}/api/notifications/mark-read/:id
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Body (**raw**)

```json
{}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 200
```json
{
    "success": true,
    "notification": {
        "id": 3,
        "title": "Booking Confirmed",
        "message": "Your booking is paid. Total: ₹25.00",
        "isRead": true,
        "userId": "26713734-71ef-4049-9692-19557803c714",
        "createdAt": "2025-07-03T17:09:55.912Z"
    }
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: mark all notification read
### Method: POST
>```
>{{base_url}}/api/notifications/mark-all-read
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Body (**raw**)

```json
{}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 200
```json
{
    "success": true
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Unauthorized
### Method: GET
>```
>{{base_url}}/api/notifications
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Body (**raw**)

```json
{}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 401
```json
{
    "message": "Unauthorized"
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃
# 📁 Collection: Booking 
undefined 


## End-point: create booking
### Method: POST
>```
>{{base_url}}/api/bookings
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Headers

|Content-Type|Value|
|---|---|
|Content-Type|application/json|


### Body (**raw**)

```json
{
"userId": "26713734-71ef-4049-9692-19557803c714",
  "entryTickets": [
    {
      "id": "3c728e88-28b7-4ba6-bc05-a9f41560f423",
      "count": 2,
      "pricePerUnit": 20
    },
    {
      "id": "314d0fee-61a7-455d-9f47-4eda2e0b1590",
      "count": 1,
      "pricePerUnit": 10
    }
  ],
  "parking": [
    {
      "id": "fa7faf76-2094-4054-81ea-9e7c21412860",
      "count": 2,
      "pricePerUnit": 25
    },
    {
      "id": "d401f5d7-752e-489d-956b-3ae200fcdd81",
      "count": 3,
      "pricePerUnit": 10
    }
  ],
  "attractions": [ 15 ],
  "movies": [ 15, 16 ],
  "attractionVisitorSlots": [
    { "id": 15, "count": 2, "pricePerUnit": 85.51849402093293 },
    { "id": 15, "count": 2, "pricePerUnit": 75.06266803708453 },
    { "id": 15, "count": 2, "pricePerUnit": 121.2204902380899 }
  ],
  "movieVisitorSlots": [
    { "id": 15, "count": 2, "pricePerUnit": 224.7858548334125 },
    { "id": 15, "count": 1, "pricePerUnit": 95.15030577172898 },
    { "id": 15, "count": 1, "pricePerUnit": 86.70001556507418 },
    { "id": 16, "count": 2, "pricePerUnit": 103.1655609808649 },
    { "id": 16, "count": 2, "pricePerUnit": 84.01944948461616 },
    { "id": 16, "count": 1, "pricePerUnit": 82.99906923852217 }
  ],
  "total": 1782.3944257653272
}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 201
```json
{
    "success": true,
    "bookingId": "e42dd1a9-d340-4f56-bede-0cabbc3fdcb7"
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: booking with empty cart
### Method: POST
>```
>{{base_url}}/api/bookings
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Body (**raw**)

```json
{
"userId": "26713734-71ef-4049-9692-19557803c714",
  "entryTickets": [
  ],
  "parking": [
  ],
  "attractions": [ ],
  "movies": [  ],
  "attractionVisitorSlots": [
  ],
  "movieVisitorSlots": [
  ],
  "total": 0
}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 400
```json
{
    "success": false,
    "message": "userId and totalAmount are required"
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃
# 📁 Collection: Payments 
undefined 


## End-point: create payments
### Method: POST
>```
>{{base_url}}/api/payments
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Headers

|Content-Type|Value|
|---|---|
|Content-Type|application/json|


### Body (**raw**)

```json
{
  "userId": "26713734-71ef-4049-9692-19557803c714",
  "bookingId": "e42dd1a9-d340-4f56-bede-0cabbc3fdcb7",
  "amount": 1782.3944257653272,
  "method": "card"
}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 201
```json
{
    "success": true,
    "payment": {
        "id": "fefddd43-0592-43fd-9978-d3940f2c1a87",
        "userId": "26713734-71ef-4049-9692-19557803c714",
        "bookingId": "e42dd1a9-d340-4f56-bede-0cabbc3fdcb7",
        "amount": 1782.394425765327,
        "status": "success",
        "method": "card",
        "transactionId": "34e11be3-2a08-4811-953f-c12d902c9992",
        "createdAt": "2025-07-04T09:37:19.214Z"
    }
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: payment with smaller amount than total amount
### Method: POST
>```
>{{base_url}}/api/payments
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Body (**raw**)

```json
{
  "userId": "26713734-71ef-4049-9692-19557803c714",
  "bookingId": "e42dd1a9-d340-4f56-bede-0cabbc3fdcb",
  "amount": 0,
  "method": "card"
}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 500
```json
{
    "success": false,
    "error": "Payment failed"
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: wrong booking id
### Method: POST
>```
>{{base_url}}/api/payments
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Body (**raw**)

```json
{
  "userId": "26713734-71ef-4049-9692-19557803c714",
  "bookingId": "e42dd1a9-d340-4f56-bede-0cabbc3fdcd",
  "amount": 1782.3944257653272,
  "method": "card"
}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 500
```json
{
    "success": false,
    "error": "Payment failed"
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃
# 📁 Collection: Profile 
undefined 


## End-point: profile
### Method: GET
>```
>{{base_url}}/api/profile
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Headers

|Content-Type|Value|
|---|---|
|Content-Type|application/json|


### Body (**raw**)

```json
{
  "userId": "26713734-71ef-4049-9692-19557803c714"
}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 200
```json
{
    "user": {
        "id": "26713734-71ef-4049-9692-19557803c714",
        "name": "Francis Murphy",
        "email": "seed2@inboxkitten.com",
        "mobile": "9494949494"
    },
    "bookings": [
        {
            "id": "e42dd1a9-d340-4f56-bede-0cabbc3fdcb7",
            "entryAmount": 50,
            "parkingAmount": 80,
            "attractionAmount": 563.6033045922147,
            "movieAmount": 1088.7911211731125,
            "total": 1782.394425765327,
            "createdAt": "Friday, 04 July 2025",
            "status": "paid"
        },
        {
            "id": "cf8e2432-f3a5-467f-87dc-ed2a69d744b2",
            "entryAmount": 50,
            "parkingAmount": 80,
            "attractionAmount": 563.6033045922147,
            "movieAmount": 1088.7911211731125,
            "total": 1782.394425765327,
            "createdAt": "Friday, 04 July 2025",
            "status": "paid"
        },
        {
            "id": "7c3c6e52-e02c-4d51-a85f-3511e7ed53ee",
            "entryAmount": 40,
            "parkingAmount": 0,
            "attractionAmount": 0,
            "movieAmount": 0,
            "total": 40,
            "createdAt": "Thursday, 03 July 2025",
            "status": "paid"
        },
        {
            "id": "f4a381be-3f2e-429b-8293-0158fd65afc8",
            "entryAmount": 40,
            "parkingAmount": 5,
            "attractionAmount": 0,
            "movieAmount": 222.6050296222667,
            "total": 267.6050296222667,
            "createdAt": "Thursday, 03 July 2025",
            "status": "pending"
        }
    ]
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: update profile
### Method: PUT
>```
>{{base_url}}/api/profile
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Headers

|Content-Type|Value|
|---|---|
|Content-Type|application/json|


### Body (**raw**)

```json
{
 "name": "Ravi Sharma",
 "email": "seed2@inboxkitten.com",
 "mobile": "9898989898"
}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 200
```json
{
    "success": true,
    "user": {
        "id": "26713734-71ef-4049-9692-19557803c714",
        "name": "Ravi Sharma",
        "email": "seed2@inboxkitten.com",
        "mobile": "9898989898",
        "userType": "kid",
        "verified": true,
        "createdAt": "2025-07-03T17:09:32.534Z",
        "updatedAt": "2025-07-04T09:40:59.732Z"
    }
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: update email with existing email
### Method: PUT
>```
>{{base_url}}/api/profile
>```
### Headers

|Content-Type|Value|
|---|---|
|Authorization|{{token}}|


### Body (**raw**)

```json
{
 "name": "Ravi Sharma",
 "email": "seed3@inboxkitten.com",
 "mobile": "9898989898"
}
```

### 🔑 Authentication jwt

|Param|value|Type|
|---|---|---|


### Response: 500
```json
{
    "success": false,
    "message": "Internal server Error"
}
```


⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃
_________________________________________________
Powered By: [postman-to-markdown](https://github.com/bautistaj/postman-to-markdown/)
