require 'spec_helper'

describe Map do
  let(:country_options) { { :displayMode => 'region',
                            :region => 'world',
                            :legend => 'none',
                            :colors => ['FF8F86', 'C43512']} }

  let(:city_options) { { :displayMode => 'markers',
                         :region => 'world',
                         :legend => 'none',
                         :colors => ['FF8F86', 'C43512']}
                      }

  describe "default attributes" do

    it "should have the correct country options" do
      expect(Map::COUNTRY_OPTIONS).to eq(country_options)
    end

    it "should have the correct city options" do
      expect(Map::CITY_OPTIONS).to eq(city_options)
    end
  end

  describe "instance methods" do
    let(:john) do
      double("user", :has_no_city? => false, city_name: "New York, NY, USA",
        :has_no_country? => false, country_name: "United States")
    end

    let(:masha) do
      double("user", :has_no_city? => true, :has_no_country? => true)
    end

    let(:justin) do
      double("user", :has_no_city? => false, city_name: "New Jersey, USA",
        :has_no_country? => false, country_name: "United States")
    end

    let(:repo) do
      double("repo", full_name: "johnkellyferguson/octomaps",
        users: [john, masha, justin], contributions_count: 3)
    end

    let(:country_params) { {"owner"=>"johnkellyferguson", "repo"=>"octomaps", "country"=>"Map by Country"} }
    let(:city_params) { {"owner"=>"johnkellyferguson", "repo"=>"octomaps", "city"=>"Map by City*"} }
    let(:country_map) { Map.new(repo, country_params) }
    let(:city_map) { Map.new(repo, city_params) }

    describe "public methods" do

      it "should respond to #type" do
        expect(country_map).to respond_to(:type)
      end

      it "should respond to #repository" do
        expect(country_map).to respond_to(:repository)
      end

      describe "#repository_name" do
        it "should return the correct repository name" do
          expect(country_map.repository_name).to eq("johnkellyferguson/octomaps")
        end
      end

      describe "#contributions_count" do
        it "should return the correct contributions count" do
          expect(country_map.contributions_count).to eq(3)
        end
      end

      describe "#number_of_locations" do
        context "when it is a country map" do
          it "should return the correct number of locations" do
            expect(country_map.number_of_locations).to eq(2)
          end
        end

        context "when it is a city map" do
          it "should return the correct number of locations" do
            expect(city_map.number_of_locations).to eq(3)
          end
        end
      end #number_of_locations

      describe "#is_of_cities?" do
        context "when the map type is 'city'" do
          it "should return true" do
            expect(city_map.is_of_cities?).to eq(true)
          end
        end

        context "when the map type is not 'city'" do
          it "should return false" do
            expect(country_map.is_of_cities?).to eq(false)
          end
        end
      end #is_of_cities?

      describe "#is_of_countries?" do
        context "when the map type is 'country'" do
          it "should return true" do
            expect(country_map.is_of_countries?).to eq(true)
          end
        end

        context "when the map type is not 'country'" do
          it "should return false" do
            expect(city_map.is_of_countries?).to eq(false)
          end
        end
      end #is_of_countries?

      describe "#sorted_list" do
        it "should return a list with the location with the most contributors first" do
          expect(country_map.sorted_list.first).to eq(["United States", 2])
        end

        it "should return a list with the location with the least contributors last" do
          expect(country_map.sorted_list.last).to eq(["Location Unknown", 1])
        end
      end #sorted_list

      describe "#google_visualr_chart_markers" do
        it "should return an instance of GoogleVisualr::Interactive::GeoChart" do
          expect(country_map.google_visualr_chart_markers.class).to eq(GoogleVisualr::Interactive::GeoChart)
        end
      end

    end # public methods

    describe "private methods" do

      describe "#determine_type_based_upon(params)" do
        context "when params['city'] is present" do
          it "should return 'city'" do
            expect(country_map.send(:determine_type_based_upon, city_params)).to eq("city")
          end
        end

        context "when params['country'] is present" do
          it "should return 'country'" do
            expect(city_map.send(:determine_type_based_upon, country_params)).to eq("country")
          end
        end

        context "when params['country'] or params['city'] is not present" do
          it "should return nil" do
            expect(country_map.send(:determine_type_based_upon, {"fake"=>"fake"})).to eq(nil)
          end
        end
      end #determine_type_based_upon(params)

      describe "#location_count_hash" do
        context "when map type is city" do
          it "should return the same value as #city_count_hash" do
            expect(city_map.send(:location_count_hash)).to eq(city_map.send(:city_count_hash))
          end

          it "should not return the same value as #country_count_hash" do
            expect(city_map.send(:location_count_hash)).not_to eq(city_map.send(:country_count_hash))
          end
        end

        context "when map type is country" do
          it "should return the same value as #country_count_hash" do
            expect(country_map.send(:location_count_hash)).to eq(country_map.send(:country_count_hash))
          end

          it "should not return the same value as #city_count_hash" do
            expect(country_map.send(:location_count_hash)).not_to eq(country_map.send(:city_count_hash))
          end
        end
      end #location_count_hash

      describe "#city_count_hash" do
        it "returns the correct hash with count" do
          expect(city_map.city_count_hash).to eq({"New York, NY, USA"=>1, "New Jersey, USA"=>1, "Location Unknown"=>1})
        end
      end

      describe "#country_count_hash" do
        it "returns the correct hash with count" do
          expect(country_map.country_count_hash).to eq({"United States"=>2, "Location Unknown"=>1})
        end
      end

      describe "#markers" do
        it "should return an instance of GoogleVisualr::DataTable" do
          expect(country_map.send(:markers).class).to eq(GoogleVisualr::DataTable)
        end
      end

      describe "#options_based_upon_type" do
        context "when map type is city" do
          it "should return the city options hash" do
            expect(city_map.send(:options_based_upon_type)).to eq(Map::CITY_OPTIONS)
          end
        end

        context "when map type is country" do
          it "should return the country options hash" do
            expect(country_map.send(:options_based_upon_type)).to eq(Map::COUNTRY_OPTIONS)
          end
        end
      end

    end # private methods
  end # instance methods

end