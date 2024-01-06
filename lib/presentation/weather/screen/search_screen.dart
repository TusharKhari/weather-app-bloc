import 'package:auto_route/auto_route.dart';
import 'package:de_nada/application/bloc/weather_bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController cityController = TextEditingController();
  final List<String> _cityList = [
    "McLean",
    "Mumbai",
    "Bengaluru",
    "Hyderabad",
    "Ahmedabad",
    "Muzaffarnagar",
    "Chandigarh",
    "Delhi",
    "Chennai",
    "Pune",
    "Kolkata",
    "Kochi"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
          onPressed: () {
            context.read<WeatherBloc>().add(WeatherFetchedCurrentLocation());
            Navigator.pop(context);
          },
          icon: const Icon(Icons.location_searching)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                TextField(
                  controller: cityController,
                  onSubmitted: (value) {
                    context.read<WeatherBloc>().add(WeatherFetchedSearchedCity(
                        city: cityController.text.trim()));
                    Navigator.pop(context);
                  },
                  decoration: const InputDecoration(hintText: "  City Name"),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _cityList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context
                            .read<WeatherBloc>()
                            .add(WeatherFetchedSearchedCity(
                              city: _cityList[index],
                            ));
                        Navigator.pop(context);
                      },
                      child: ListTile(
                        title: Text(_cityList[index]),
                        leading: const Icon(Icons.location_city_outlined),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
