child: ClipRRect(
borderRadius: BorderRadius.circular(50),
child: Padding(
padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
child: TextButton(
onPressed: press,
style: ButtonStyle(
backgroundColor: MaterialStateProperty.all(kPrimaryColor),
),
child: Text(
text,
style: TextStyle(color: textColor),
),
),
),
),
