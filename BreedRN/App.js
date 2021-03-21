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
      const breeds = realm
        .objects("Breed")
        .filtered(`TRUEPREDICATE SORT(name ASC) DISTINCT(name)`);
      const items = breeds.map((item) => {
        let copy = {};
        copy.name = item.name;
        copy.id = item.id;
        copy.isFavorite = item.isFavorite;
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

  const toggleBookmark = (id) => {
    Realm.open(config)
      .then((realm) => {
        const results = realm.objects("Breed").filtered(`id="${id}"`);
        const item = results[0];
        if (item) {
          realm.write(() => {
            item.isFavorite = !item.isFavorite;
          });
        }
        realm.close();
      })
      .then(() => loadFromDatabase())
      .then((data) => setData(data));
  };

  useEffect(() => {
    loadFromDatabase()
      .then(
        (cachedData) => {
          if (cachedData.length == 0) {
            console.log("Loaded from Network");
            return loadFromNetwork()
              .then((data) => cacheInDatabase(data))
              .then(() => loadFromDatabase());
          } else {
            console.log("Loaded from Realm");
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
    <SafeAreaView style={styles.content}>
      <StatusBar
        backgroundColor="#333"
        barStyle="light-content"
        hidden={false}
      />
      {isLoading ? (
        <ActivityIndicator />
      ) : (
        <FlatList
          data={data}
          renderItem={({ index, item }) => {
            return <Item item={item} onBookmark={(id) => toggleBookmark(id)} />;
          }}
          keyExtractor={(item) => item.id}
        />
      )}
    </SafeAreaView>
  );
}

const Item = ({ item, onBookmark }) => {
  let { name, id, isFavorite } = item;

  return (
    <View style={styles.item}>
      <Text style={styles.itemText}>{name}</Text>
      <Text>
        <TouchableOpacity onPress={() => onBookmark(id)}>
          <Icon
            name={isFavorite ? "heart" : "heart-o"}
            size={30}
            color="#900"
          />
        </TouchableOpacity>
      </Text>
    </View>
  );
};

const styles = StyleSheet.create({
  content: {
    flex: 1,
  },
  item: {
    height: 100,
    padding: 20,
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  itemText: {
    fontSize: 30,
  },
});
