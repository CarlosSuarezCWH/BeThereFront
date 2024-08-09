import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final String eventTitle;
  final double price;

  const PaymentScreen({Key? key, required this.eventTitle, required this.price})
      : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedPaymentMethod = 'Tarjeta de crédito/Tarjeta de débito';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.eventTitle),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.eventTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'FORMA DE PAGO',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildPaymentOption(
              context,
              'Tarjeta de crédito/Tarjeta de débito',
              'Visa, MasterCard, American Express',
            ),
            _buildPaymentOption(context, 'PayPal', ''),
            _buildPaymentOption(context, 'Transferencia bancaria', ''),
            const SizedBox(height: 20),
            if (_selectedPaymentMethod ==
                'Tarjeta de crédito/Tarjeta de débito') ...[
              _buildCardDetails(),
              const SizedBox(height: 20),
            ],
            if (_selectedPaymentMethod == 'Transferencia bancaria') ...[
              _buildBankTransferDetails(),
              const SizedBox(height: 20),
            ],
            Text(
              'Total: \$${widget.price.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para confirmar el pago
                },
                child: const Text('Confirmar Pago'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
      BuildContext context, String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      subtitle: subtitle.isNotEmpty
          ? Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            )
          : null,
      leading: Radio<String>(
        value: title,
        groupValue: _selectedPaymentMethod,
        onChanged: (String? value) {
          setState(() {
            _selectedPaymentMethod = value;
          });
        },
        activeColor: Colors.blue,
      ),
    );
  }

  Widget _buildCardDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: 'Número',
            labelStyle: const TextStyle(
              color: Colors.grey,
            ),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Caduca',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'CVV',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  border: const OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBankTransferDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Nombre de la Empresa: Bether Corp',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Banco: Banco Ejemplo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Número de Cuenta: 123456789',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'CLABE: 012345678901234567',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
