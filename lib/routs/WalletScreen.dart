import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            TextButton(
              onPressed: () {},
              child: Text(
                'تسجيل الخروج',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text('محفظتي'),
          ],
        ),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  balanceCard('الرصيد الحالي', '500 نقطة'),
                  balanceCard('الرصيد السابق', '400 نقطة'),
                ],
              ),
              SizedBox(height: 20),
              Row(
                  textDirection: TextDirection.rtl,
                  children:[ Text(
                'شحن الرصيد',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

              ),]),

              SizedBox(height: 20),
              _buildTextField(
                label: 'رقم البطاقة',
                hintText: 'رقم البطاقة',
              ),
              SizedBox(height: 10),
              _buildTextField(
                label: 'تاريخ الإنتهاء',
                hintText: 'MM/YY',
              ),
              SizedBox(height: 10),
              _buildTextField(
                label: 'رمز الأمان CVV',
                hintText: 'رمز الأمان CVV',
              ),
              SizedBox(height: 10),
              _buildTextField(
                label: 'المبلغ (بالريال)',
                hintText: 'المبلغ (بالريال)',
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  onPressed: () {},
                  child: Text(
                    'شحن الرصيد',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget balanceCard(String title, String balance) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            balance,
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          maxLines: 1,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.blue[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}
