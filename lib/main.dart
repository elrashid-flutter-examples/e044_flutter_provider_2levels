import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AddressBookViewModel>(
      builder: (context) => AddressBookViewModel(),
      child: HomeScreen(),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddressBookViewModel>(
      builder: (context) => AddressBookViewModel(),
      child: MaterialApp(
        home: Scaffold(
          body: _getBody(context),
        ),
      ),
    );
  }

  Widget _getBody(BuildContext context) {
    AddressBookViewModel vm = Provider.of<AddressBookViewModel>(context);

    final contacts = vm.contacts;
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        print("building ListView item with index $index");
        return ChangeNotifierProvider.value(
          value: contacts[index],
          child: ContactView(),
        );
      },
    );
  }
}

// product_item.dart
class ContactView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contact = Provider.of<Contact>(context);
    print("building ListTile item with contact " + contact.name);
    return ListTile(
      title: Text(contact.name),
      trailing: contact.starred ? Icon(Icons.star) : null,
      onLongPress: () => contact.toggleStarred(),
    );
  }
}

class AddressBookViewModel with ChangeNotifier {
  final contacts = [
    Contact("Contact A", false),
    Contact("Contact B", false),
    Contact("Contact C", false),
    Contact("Contact D", false),
  ];
  void addcontacts(Contact contact) {
    contacts.add(contact);
    notifyListeners();
  }
}

class Contact with ChangeNotifier {
  final String name;
  bool starred;
  Contact(this.name, this.starred);

  void toggleStarred() {
    starred = !starred;
    notifyListeners();
  }
}
