import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shimmer/shimmer.dart';

class PokeMons extends StatelessWidget {
  PokeMons({Key? key}) : super(key: key);

  APICacheManager apiCacheManager = APICacheManager();

  List<String> names = [];

  List<String> photosUrls = [];

  Map<String, dynamic> data = {};

  Future<Map<String, dynamic>?> getData() async {
    Response response = await Dio().get('https://pokeapi.co/api/v2/pokemon');
    if (!await apiCacheManager.isAPICacheKeyExist('DATA')) {
      if (response.statusCode == 200) {
        APICacheDBModel apiCacheDBModel = APICacheDBModel(
          key: 'DATA',
          syncData: response.toString(),
        );
        apiCacheManager.addCacheData(apiCacheDBModel);
        data = jsonDecode(response.toString());
        getNames();
        await getPhotos(false);
        return data;
      }
      return null;
    } else {
      var cashData = await apiCacheManager.getCacheData('DATA');
      data = await jsonDecode(cashData.syncData);
      getNames();
      await getPhotos(true);
      return data;
    }
  }

  void getNames() {
    for (var i in data['results'] as List) {
      names.add(i['name']);
    }
  }

  Future<void> getPhotos(bool isCached) async {
    if (isCached) {
      for (int i = 0; i < (data['results'] as List).length; i++) {
        if (await apiCacheManager.isAPICacheKeyExist('PHOTO$i')) {
          var cacheData = await apiCacheManager.getCacheData('PHOTO$i');
          Map<String, dynamic> data = await jsonDecode(cacheData.syncData);
          photosUrls.add(data['sprites']['back_default']);
        }
      }
    } else {
      int counter = 0;
      for (var i in data['results']) {
        Response response = await Dio().get(i['url']);
        if (response.statusCode == 200) {
          APICacheDBModel apiCacheDBModel = APICacheDBModel(
            key: 'PHOTO$counter',
            syncData: response.toString(),
          );
          apiCacheManager.addCacheData(apiCacheDBModel);
          Map<String, dynamic> data = jsonDecode(response.toString());
          photosUrls.add(data['sprites']['back_default']);
          counter += 1;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _enabled = true;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemons'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _enabled = false;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  itemCount: snapshot.hasData ? names.length : 0,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 5);
                  },
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: photosUrls[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          names[index],
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            } else {
              return _enabled ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                enabled: _enabled,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                    itemCount: 7,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 5);
                    },
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Container(
                                  width: 40.0,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ) : SizedBox();
            }
          }),
    );
  }
}
