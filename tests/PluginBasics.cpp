#include "helpers/test_helpers.h"
#include <PluginProcessor.h>
#include <catch2/catch_test_macros.hpp>
#include <catch2/matchers/catch_matchers_string.hpp>
#include <fstream>
#include <string>

TEST_CASE ("one is equal to one", "[dummy]")
{
    REQUIRE (1 == 1);
}

TEST_CASE ("Plugin instance", "[instance]")
{
    PluginProcessor testPlugin;

    SECTION ("name")
    {
        CHECK_THAT (testPlugin.getName().toStdString(),
            Catch::Matchers::Equals ("Pamplejuce Demo"));
    }
}

#ifdef PAMPLEJUCE_IPP
    #include <ipp.h>

TEST_CASE ("IPP version", "[ipp]")
{
    CHECK_THAT (ippsGetLibVersion()->Version, Catch::Matchers::Equals ("2021.11.0 (r0xcd107b02)"));
}
#endif

TEST_CASE ("Plugin version matches VERSION file", "[version]")
{
    // Read the version from the VERSION file
    std::ifstream versionFile("VERSION");
    REQUIRE(versionFile.is_open()); // Ensure the file is accessible

    std::string fileVersion;
    std::getline(versionFile, fileVersion);
    versionFile.close();

    // Create a PluginProcessor instance
    PluginProcessor testPlugin;

    // Check that the version in the file matches the version reported by the plugin
    CHECK(fileVersion == testPlugin.getVersion().toStdString());
}
