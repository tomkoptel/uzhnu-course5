import React, { useEffect, useState } from "react";
import {
  ActivityIndicator,
  SafeAreaView,
  View,
  FlatList,
  StyleSheet,
  Text,
  StatusBar,
} from "react-native";

import Realm from "realm";
import "react-native-get-random-values";
import { v4 as uuidv4 } from "uuid";

import Icon from "react-native-vector-icons/FontAwesome";
import { TouchableOpacity } from "react-native-gesture-handler";

const BreedSchema = {
  name: "Breed",
  primaryKey: "id",
  properties: {
    id: "string",
    name: "string",
    isFavorite: { type: "bool", default: false },
  },
};
const config = {
  deleteRealmIfMigrationNeeded: true,
  schema: [BreedSchema],
};

export default function App() {
  // To build refreshig state https://www.pluralsight.com/guides/display-a-list-using-the-flatlist-component-in-react-native
  const [isLoading, setLoading] = useState(true);
  const [data, setData] = useState([]);

  const loadFromDatabase = () => {
    return Realm.open(config).then((realm) => {
      const breeds = realm.objects("Breed");
      const items = breeds.map((item) => {
        let copy = {};
        copy.name = item.name;
        copy.id = item.id;
        return copy;
      });
      realm.close();
      return items;
    });
  };

  const cacheInDatabase = (data) => {
    return Realm.open(config).then((realm) => {
      realm.write(() => {
        data.forEach((item) => {
          realm.create("Breed", { ...item });
        });
      });
      realm.close();
      return data;
    });
  };

  const loadFromNetwork = () => {
    return fetch("https://dog.ceo/api/breeds/list/all")
      .then((response) => response.json())
      .then((json) => {
        let keys = Object.keys(json.message);
        let uniqueKeys = new Set(keys);
        let data = Array.from(uniqueKeys);
        let items = data.map((key) => {
          return { id: uuidv4(), name: key };
        });
        return items;
      });
  };

  useEffect(() => {
    loadFromDatabase()
      .then(
        (cachedData) => {
          if (cachedData.length == 0) {
            return loadFromNetwork().then((data) => cacheInDatabase(data));
          } else {
            return Promise.resolve(cachedData);
          }
        },
        (rejection) => console.log(rejection)
      )
      .then((data) => setData(data))
      .catch((error) => console.error(error))
      .finally(() => setLoading(false));
  }, []);

  return (
    <SafeAreaView
      style={{
        flex: 1,
        marginTop: StatusBar.currentHeight || 0,
      }}
    >
      {isLoading ? (
        <ActivityIndicator />
      ) : (
        <FlatList
          data={data}
          renderItem={({ index, item }) => {
            return <Item item={item} onBookmark={(id) => console.log(id)} />;
          }}
          keyExtractor={(item) => item.id}
        />
      )}
    </SafeAreaView>
  );
}

const Item = ({ item, onBookmark }) => {
  let { name, id } = item;

  return (
    <View
      style={{
        height: 100,
        padding: 20,
        flexDirection: "row",
        justifyContent: "space-between",
        alignItems: "center",
      }}
    >
      <Text
        style={{
          fontSize: 32,
        }}
      >
        {name}
      </Text>
      <Text>
        <TouchableOpacity onPress={() => onBookmark(id)}>
          <Icon name="heart" size={30} color="#900" />
        </TouchableOpacity>
      </Text>
    </View>
  );
};
