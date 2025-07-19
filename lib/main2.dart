import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Submission Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: EventSubmissionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EventSubmissionScreen extends StatefulWidget {
  const EventSubmissionScreen({super.key});

  @override
  _EventSubmissionScreenState createState() => _EventSubmissionScreenState();
}

class _EventSubmissionScreenState extends State<EventSubmissionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eventTitleController = TextEditingController();
  final TextEditingController _organizerNameController =
      TextEditingController();
  final TextEditingController _organizerContactController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _additionalNotesController =
      TextEditingController();
  final TextEditingController _otherResourcesController =
      TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? _modeOfEvent;
  String? _typeOfEvent;
  String? _audienceType;
  String? _fundSource;
  bool _agreedToTerms = false;

  List<String> selectedResources = [];
  final List<String> resourceOptions = [
    'Projector',
    'Mic/Speakers',
    'Food/Refreshments',
    'Certificates',
    'Stationery',
    'Volunteers',
  ];

  final List<String> modeOptions = ['Offline', 'Online', 'Hybrid'];
  final List<String> typeOptions = [
    'Workshop',
    'Seminar',
    'Competition',
    'Cultural',
    'Sports',
    'Other',
  ];
  final List<String> audienceOptions = ['Internal', 'External', 'Both'];
  final List<String> fundSourceOptions = [
    'College',
    'Sponsor',
    'Club Budget',
    'Self-Funded',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _endTime) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _agreedToTerms) {
      // Process form data
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Event submitted successfully for approval!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _resetForm();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please agree to the terms and conditions'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _eventTitleController.clear();
      _organizerNameController.clear();
      _organizerContactController.clear();
      _descriptionController.clear();
      _venueController.clear();
      _budgetController.clear();
      _additionalNotesController.clear();
      _otherResourcesController.clear();
      _selectedDate = null;
      _startTime = null;
      _endTime = null;
      _modeOfEvent = null;
      _typeOfEvent = null;
      _audienceType = null;
      _fundSource = null;
      selectedResources.clear();
      _agreedToTerms = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Submission Form'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🟦 Basic Event Info Section
              _buildSectionHeader('🧾 Basic Event Info'),
              _buildTextField(
                controller: _eventTitleController,
                label: 'Event Title',
                hint: 'e.g., Coding Bootcamp 2025',
                validator: (value) => value!.isEmpty ? 'Required field' : null,
              ),
              _buildTextField(
                controller: _organizerNameController,
                label: 'Organizer Name',
                hint: 'Name of person/team requesting the event',
                validator: (value) => value!.isEmpty ? 'Required field' : null,
              ),
              _buildTextField(
                controller: _organizerContactController,
                label: 'Organizer Contact Info',
                hint: 'Email or phone number for contact',
                validator: (value) => value!.isEmpty ? 'Required field' : null,
                keyboardType: TextInputType.emailAddress,
              ),
              // Date and Time Pickers
              Row(
                children: [
                  Expanded(
                    child: _buildDatePickerField(
                      label: 'Date of Event',
                      selectedDate: _selectedDate,
                      onTap: () => _selectDate(context),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTimePickerField(
                      label: 'Start Time',
                      selectedTime: _startTime,
                      onTap: () => _selectStartTime(context),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTimePickerField(
                      label: 'End Time',
                      selectedTime: _endTime,
                      onTap: () => _selectEndTime(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Mode and Type Dropdowns
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      label: 'Mode of Event',
                      value: _modeOfEvent,
                      items: modeOptions,
                      onChanged: (value) {
                        setState(() {
                          _modeOfEvent = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Required field' : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdown(
                      label: 'Type of Event',
                      value: _typeOfEvent,
                      items: typeOptions,
                      onChanged: (value) {
                        setState(() {
                          _typeOfEvent = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Required field' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _descriptionController,
                label: 'Description / Objective',
                hint: 'What the event is about and why it\'s important',
                maxLines: 4,
                validator: (value) => value!.isEmpty ? 'Required field' : null,
              ),

              // 🏛️ Venue & Logistics Section
              _buildSectionHeader('🏛️ Venue & Logistics'),
              _buildTextField(
                controller: _venueController,
                label: 'Proposed Venue / Platform',
                hint:
                    'Physical venue or virtual platform (e.g., "Auditorium", "Google Meet")',
                validator: (value) => value!.isEmpty ? 'Required field' : null,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: TextEditingController(), // For audience size
                      label: 'Expected Audience Size',
                      hint: 'Estimated number of participants',
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'Required field' : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdown(
                      label: 'Audience Type',
                      value: _audienceType,
                      items: audienceOptions,
                      onChanged: (value) {
                        setState(() {
                          _audienceType = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Required field' : null,
                    ),
                  ),
                ],
              ),

              // 💸 Funding & Resources Section
              _buildSectionHeader('💸 Funding & Resources'),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _budgetController,
                      label: 'Estimated Budget',
                      hint: 'Total funds required',
                      prefixText: '\$ ',
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'Required field' : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdown(
                      label: 'Fund Source',
                      value: _fundSource,
                      items: fundSourceOptions,
                      onChanged: (value) {
                        setState(() {
                          _fundSource = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Required field' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Resources Requested',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              // Resources Checklist
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: resourceOptions.map((resource) {
                  return FilterChip(
                    label: Text(resource),
                    selected: selectedResources.contains(resource),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          selectedResources.add(resource);
                        } else {
                          selectedResources.remove(resource);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 8),
              _buildTextField(
                controller: _otherResourcesController,
                label: 'Other Resources',
                hint: 'Specify any other resources needed',
              ),

              // 📝 Additional Notes Section
              _buildSectionHeader('📝 Additional Notes'),
              _buildTextField(
                controller: _additionalNotesController,
                hint:
                    'Any specific requirements, collaborations, or risk mitigation notes',
                maxLines: 3,
              ),

              // ✅ Declaration Section
              _buildSectionHeader('✅ Declaration'),
              Text(
                'I declare that the above information is true and that I take full responsibility for the conduct of the event. I understand the event will only be held after all approvals are received.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        _agreedToTerms = value ?? false;
                      });
                    },
                  ),
                  Text('I Agree'),
                ],
              ),

              // Submit Button
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Submit for Approval',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue[800],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? label,
    String? hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? prefixText,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
          prefixText: prefixText,
        ),
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }

  Widget _buildDatePickerField({
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        child: Text(
          selectedDate != null
              ? DateFormat('MMM dd, yyyy').format(selectedDate)
              : 'Select date',
        ),
      ),
    );
  }

  Widget _buildTimePickerField({
    required String label,
    required TimeOfDay? selectedTime,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.access_time),
        ),
        child: Text(
          selectedTime != null ? selectedTime.format(context) : 'Select time',
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      value: value,
      items: items.map((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
